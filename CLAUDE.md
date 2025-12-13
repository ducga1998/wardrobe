# Frontend Architecture — Local‑First Outfit App

> Purpose: high-confidence frontend architecture and implementation blueprint you can drop into the repo. Local-first mobile app (Flutter) that owns photo persistence, indexing, outfit suggestion, and low-res try-on. Native iOS augment (Vision/CoreML/Metal) for higher-quality segmentation & fast compositing.

---

## Core principles

* **Local-first:** device stores originals, masks, composites. Backend only used as ephemeral processor or optional high-res generator when user opts in.
* **Progressive enhancement:** start with lightweight Dart/OpenCV compositing; plug native modules for quality/performance later.
* **Deterministic & explainable:** suggestion rules are deterministic for MVP; ML additions are incremental and observable.
* **Modular & testable:** providers + repositories separate UI and logic; clear contracts for platform channels.

---

## High-level layers

1. **UI Layer (Flutter):** views, widgets, routing, lightweight transforms, interactive try-on controls.
2. **State/Domain Layer (Riverpod):** providers, state notifiers, local-only scoring engine, sync queue.
3. **Data Layer:** local file store (images/masks/composites), local DB (sqflite/hive) for metadata and indexes.
4. **Platform Layer (Native):** iOS Swift for Vision/CoreML segmentation, Metal compositing; Android optional later.
5. **Optional Remote Layer:** ephemeral processing endpoints and Gemini bridge invoked only on explicit user opt-in.

---

## Folder & module layout (opinionated)

```
/lib
  app.dart                // Router + provider scope
  main.dart
  /core
    settings.dart
    constants.dart
    logging.dart
  /data
    local_store.dart      // file I/O, file paths
    db_provider.dart      // sqflite or hive wrapper
  /services
    image_service.dart    // high-level image ops (calls native or fallback)
    scoring_service.dart  // outfit rules + ranking
    sync_service.dart     // upload queue for opt-in ops
  /features
    /wardrobe
      wardrobe_controller.dart  // orchestrates import -> index
      models/
      widgets/
      screens/
    /outfits
      suggest_controller.dart
      tryon_controller.dart
      widgets/
    /profile
  /platform
    /ios
      swift_interface.dart // method channel wrappers
  /routes
    app_router.dart
  /widgets
/tests
```

---

## Routing & UX flow

* Use **Navigator 2.0** driven by `AppRouter` and `AppState` provider.
* Shell: bottom navigation with 4 tabs — Home, Wardrobe, Outfits, Settings.
* Modal flows:

  * Wardrobe import: fullscreen modal (`/wardrobe/import`) to manage camera lifecycle.
  * Try-on: fullscreen modal with `fullscreenDialog: true` to avoid nested navigation complexity.
* Persist last route in local DB to restore user session.

---

## Key providers & responsibilities (Riverpod)

* `AppStateProvider` — global route, auth flags, onboarding state.
* `WardrobeProvider` — manages list, import, delete, indexing, emits streams on changes.
* `ImageServiceProvider` — abstraction to run segmentation/composite. Decides between native channel and Dart fallback.
* `ScoringProvider` — accepts metadata + context -> returns ranked outfits. Stateless, deterministic.
* `TryOnProvider` — state machine for try-on: idle → preparing → segmenting → compositing → ready/failed.
* `SyncProvider` — queue uploads for opt-in high-res exports and analytics events.

---

## Data model (frontend canonical)

**WardrobeItem**

* id
* local_path (image)
* mask_path (local)
* type (top/bottom/shoe)
* colors
* tags
* created_at

**Outfit**

* id
* item_ids[]
* score
* thumbnail_path
* created_at

**TryOnSession**

* id
* selfie_path
* composite_path
* params (transforms)
* created_at

Store metadata in `sqflite` (single DB file) or `hive` if you prefer binary speed.

---

## Image pipeline (device responsibilities)

1. **Import** (camera/gallery): capture -> quick-crop UI -> save original to app folder. Create small JPEG for quick previews (max 1024 px).
2. **Segmentation:** prefer native iOS Vision/CoreML via MethodChannel. If unavailable, run lightweight U2Net port or request backend ephemeral `/process/segment` (opt-in). Save mask PNG with alpha.
3. **Feature extraction:** run k-means for dominant colors and simple pattern heuristics in Dart (OpenCV bindings or package). Store metadata in DB.
4. **Index:** update in-memory index (colors map, type map) for fast suggestions.
5. **Low-res composite:** for try-on preview, run affine warps + alpha blend in Canvas using CustomPainter (fast, GPU-backed) or use native Metal for faster on-device processing.
6. **High-res export (opt-in):** push assets to backend or directly to Gemini provider (user opt-in) via SyncProvider.

---

## Native platform channel contracts (iOS Swift)

Expose via MethodChannel + EventChannel for progress:

* `segmentGarment(String imagePath) -> { maskPath, confidence }`
* `composeHighRes(String selfiePath, List<String> garmentPaths, List<String> maskPaths, Map transforms) -> { outputPath }` (async with progress events)
* `estimateBodyLandmarks(String selfiePath) -> { landmarks }` (optional)

Design notes:

* Keep payloads as file paths (not raw bytes) to avoid memory pressure.
* Provide cancelation tokens.

---

## TryOnProvider state machine

```
idle
  -> preparing (load files, validate selfie angle)
    -> segmenting (call native or fallback)
      -> compositing (low-res via Canvas or native)
        -> ready
      -> failed
    -> failed
  -> cancelled
```

* Emit granular progress to UI for feedback.
* On `ready`: persist composite_path and add to TryOnSessions.

---

## Offline-first sync & conflict resolution

* All data authoritative on device.
* SyncProvider only for optional exports; its queue supports retry/backoff and respects user network preferences (Wi-Fi only).
* No automatic server-side merges required — server is stateless. If user opts into cross-device sync later, implement conflict resolution using "last write wins" plus manual merge UI for image conflicts.

---

## Performance & memory management

* Always load scaled bitmaps for display (use `decodeImageFromList` with target size).
* Limit in-memory bitmaps; use caching strategy via `flutter_cache_manager` for thumbnails.
* Offload heavy CPU image ops to isolates or native code.
* Use CustomPainter for compositing; consider using `PictureRecorder` to store pre-rendered layers.

---

## Testing strategy

* Unit tests for scoring rules and controller logic.
* Widget tests for import flow and try-on UI interactions (mock native channel responses).
* Integration tests: import → suggest → tryon (use device/emulator). Mock heavy native parts initially.
* Performance tests: simulate 500+ items, measure import latency and memory.

---

## Security & privacy (frontend)

* Always request camera/photo permission at point-of-use with clear text explaining why.
* Provide settings: "Opt-out of cloud processing" and "Clear all app images".
* Encrypt the DB (use SQLCipher or platform-level encryption) if you plan to store sensitive images locally; otherwise, document risk.
* If user opts into Gemini/high-res, show explicit consent screen explaining external transfer.

---

## CI & developer ergonomics

* Run `flutter analyze` and `dart format` in CI.
* Provide `dev` flavor that enables local native stubs for iOS segmentation to simplify testing without device.
* Mock platform channels with deterministic responses for unit tests.

---

## Minimal MVP milestones (frontend-focused)

1. Project scaffold: Router + global providers + DB wrapper. (1–2 days)
2. Wardrobe import UI: camera, quick-crop, save image + preview. (2–3 days)
3. Segmentation fallback: simple Dart mask generator or backend `/process/segment`. (3–4 days)
4. Scoring engine: rule-based suggest + simple UI. (2–3 days)
5. Try-on low-res compositor with interactive transforms. (3–5 days)
6. Native channel skeleton + iOS Vision segmentation integration (optional post-MVP). (5–10 days)

---

## Deliverables (file notes you can paste)

* `app_router.dart` skeleton
* `wardrobe_controller.dart` (import + index logic)
* `tryon_provider.dart` state machine (Riverpod StateNotifier)
* `image_service.dart` (abstraction layer for native & fallback compositors)

---

If you want, I will now generate one of those file stubs and add it into the canvas as a code file: `app_router.dart`, `wardrobe_controller.dart`, or `tryon_provider.dart`. Pick one and I’ll produce ready-to-paste Dart code.

---

*End of Frontend Architecture — Local‑First Outfit App.*
