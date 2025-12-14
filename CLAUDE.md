# CLAUDE.md — Project Architecture & Working Guide (Repo-Accurate)

> This repo started as `flutter-boilerplate-project` (MobX + get_it) and is being adapted into a **Local‑First Outfit App**.  
> The **runtime entrypoint today** is the newer **Riverpod + go_router** flow described below. Legacy boilerplate still exists in `lib/presentation/*` and `lib/domain/*`.

---

## What runs (source of truth)

- **Entrypoint**: `lib/main.dart`
  - Locks orientation to portrait
  - Creates `SharedPreferences` and injects it via Riverpod override (`sharedPreferencesProvider`)
  - Runs `OutfitApp` (not `MyApp`)
- **Root widget**: `lib/app.dart`
  - `MaterialApp.router(...)`
  - Reads router from `appRouterProvider` in `lib/routes/app_router.dart`

If you’re debugging “why isn’t my MobX store used?” — it’s because `MyApp` is not used by `main.dart`.

---

## Routing (go_router)

Router definition: `lib/routes/app_router.dart`

- **Auth routes**
  - `/login` → `features/auth/presentation/screens/login_screen.dart`
  - `/register` → `features/auth/presentation/screens/register_screen.dart`
- **Shell tabs** (bottom navigation via `StatefulShellRoute.indexedStack`)
  - `/` (Home) → `presentation/home/widgets/home_content.dart`
  - `/wardrobe` (Wardrobe) → `features/wardrobe/screens/wardrobe_screen.dart`
    - `/wardrobe/import` → `features/wardrobe/screens/import_screen.dart`
  - `/outfits` (Outfits) → `features/outfits/screens/outfits_screen.dart`
    - `/outfits/try-on` → `features/outfits/screens/try_on_screen.dart` (expects `state.extra as List<WardrobeItem>`)
  - `/settings` → placeholder `SettingsScreen` in `app_router.dart`
- **Modal/standalone**
  - `/add-item` → `features/wardrobe/screens/add_item_screen.dart`

### Auth gating / redirect

`GoRouter.redirect` is driven by Riverpod `authControllerProvider`:
- `features/auth/presentation/controllers/auth_controller.dart`
- `features/auth/providers/auth_providers.dart` (wires repository + prefs)

It uses `SharedPreferenceHelper.isLoggedIn` (stored under `Preferences.is_logged_in`) to decide whether to redirect to `/login`.

---

## State management: new vs legacy (important)

### New (actively used by Outfit flow)

- **Riverpod** (`flutter_riverpod`)
- Patterns used:
  - `Provider` for services and adapters (`dbProvider`, `localStoreProvider`, `imageServiceProvider`)
  - `StateNotifierProvider` for feature controllers (`wardrobeControllerProvider`, `suggestControllerProvider`, `tryOnControllerProvider`)
  - `AsyncNotifierProvider` for auth (`authControllerProvider`)

### Legacy (still in repo, not used by `main.dart`)

- **MobX** + **get_it** DI + classic `MaterialApp(routes: ...)`
- Primary files:
  - `lib/presentation/my_app.dart` (legacy app root)
  - `lib/di/service_locator.dart` + `lib/*/di/**` (get_it wiring)
  - `lib/presentation/**` + `lib/domain/**` + `lib/data/**` (boilerplate layers)

Do not mix these two stacks in the same feature unless you’re intentionally migrating.

---

## Local-first data & persistence (current implementation)

### Local file store

- `lib/data/local_store.dart`
  - Saves imported images by copying them into the app documents directory.

### Local database (sqflite)

- `lib/data/db_provider.dart`
  - DB name: `outfit_app.db`
  - Tables:
    - `wardrobe_items`
    - `outfits` (created but not fully used by the new flow yet)

### Shared preferences

- `lib/data/sharedpref/shared_preference_helper.dart`
  - Auth: `auth_token`, `is_logged_in`
  - Theme/language preferences (legacy boilerplate utilities still present)

---

## Feature flows (how the app works today)

### Auth

- UI:
  - `features/auth/presentation/screens/login_screen.dart` (Riverpod)
  - `features/auth/presentation/screens/register_screen.dart` (Riverpod)
- Logic:
  - `features/auth/presentation/controllers/auth_controller.dart`
  - Reads `authRepositoryProvider` + `sharedPreferenceHelperProvider` from `features/auth/providers/auth_providers.dart`
- Backend endpoints:
  - `lib/data/network/constants/endpoints.dart` (defaults to `http://localhost:5001`)

> Note: there is also a *legacy* Bloc-based register screen at `features/auth/presentation/pages/register_screen.dart` using `getIt<RegisterCubit>()`. The router does **not** use it.

### Wardrobe (import → persist → list)

- UI:
  - `features/wardrobe/screens/wardrobe_screen.dart` shows stored items
  - `features/wardrobe/screens/add_item_screen.dart` is the “Add item” UX entry
  - `features/wardrobe/screens/import_screen.dart` uses `image_picker` to capture/choose, then saves
- Logic:
  - `features/wardrobe/wardrobe_controller.dart`
    - `LocalStore.saveImage(...)`
    - `ImageService.segmentGarment(...)`
    - inserts `WardrobeItem` into `wardrobe_items` table
- Model:
  - `features/wardrobe/models/wardrobe_item.dart`

### Outfits (suggest → try-on)

- Suggestion list:
  - UI: `features/outfits/screens/outfits_screen.dart`
  - Controller: `features/outfits/suggest_controller.dart` reads wardrobe items and calls scoring
  - Scoring: `services/scoring_service.dart` (deterministic heuristic placeholder)
- Try-on:
  - UI: `features/outfits/screens/try_on_screen.dart`
  - State machine: `features/outfits/tryon_controller.dart` (`TryOnStatus`)
  - Preview renderer: `features/outfits/widgets/try_on_preview.dart` (simple overlay via `CustomPainter`)

---

## Image pipeline & native iOS hook (current state)

### Dart abstraction

- `lib/services/image_service.dart`
  - `segmentGarment(imagePath) -> maskPath`
  - `composeOutfit(selfiePath, garmentPaths) -> compositePath`
  - Current default implementation (`ImageServiceImpl`) is a stub (returns original paths).

### iOS native channel wrapper

- `lib/platform/ios/native_image_service.dart`
  - `MethodChannel('com.example.outfit_app/image_processing')`
  - Methods:
    - `segmentGarment` with `{ imagePath }`
    - `composeOutfit` with `{ selfiePath, garmentPaths }`

If you add iOS Swift/ObjC implementations, keep payloads as **file paths**, not raw bytes.

---

## Conventions for new work (recommended)

- **New screens/controllers**: put under `lib/features/<feature>/...`
- **New state**: prefer Riverpod providers close to the feature (same folder)
- **New routes**: extend `lib/routes/app_router.dart`
- **Persistence**:
  - small settings → `SharedPreferenceHelper`
  - structured data → `sqflite` via `DbProvider`
  - blobs/images → `LocalStore` (documents dir)

---

## Known sharp edges / cleanup backlog

- **Duplicate auth UIs**: Riverpod screens vs legacy Bloc register page (`features/auth/presentation/pages/register_screen.dart`).
- **Legacy boilerplate still present**: MobX + get_it flows under `lib/presentation/**` are not wired to `main.dart`.
- **Image segmentation/composition are placeholders**: implement in `ImageServiceImpl` (Dart) and/or native iOS channel.

---

## Commands (local dev)

- `flutter pub get`
- `dart format .`
- `flutter analyze`
- `flutter run`


