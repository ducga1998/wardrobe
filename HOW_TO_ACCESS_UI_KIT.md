# 🎨 How to Access the Apple UI Kit Examples

## Quick Start - 3 Steps

### 1️⃣ Run the App
```bash
flutter run
```

### 2️⃣ Login to the App
- Use any credentials (the boilerplate has mock authentication)
- You'll be taken to the home screen

### 3️⃣ Tap the Palette Icon
- Look at the top-right corner of the app bar
- Tap the **palette icon 🎨** 
- Enjoy exploring all Apple UI Kit components!

---

## Visual Guide

```
┌─────────────────────────────────┐
│  Posts            🎨 🌍 ☀️ ⏻    │ ← Home Screen App Bar
├─────────────────────────────────┤    (Tap the palette icon 🎨)
│                                 │
│  [Your posts content]           │
│                                 │
│                                 │
│                                 │
└─────────────────────────────────┘

                 ↓ Tap 🎨

┌─────────────────────────────────┐
│  ← Apple UI Kit        ⚙️       │ ← UI Kit Examples Screen
├─────────────────────────────────┤
│                                 │
│  Typography                     │
│  ┌───────────────────────────┐ │
│  │ Large Title               │ │
│  │ Title 1                   │ │
│  │ Body Text...              │ │
│  └───────────────────────────┘ │
│                                 │
│  Colors                         │
│  🔵 Blue 🟢 Green 🟣 Purple    │
│                                 │
│  Buttons                        │
│  [ Filled Button ]             │
│  [ Tinted Button ]             │
│  [ Gray Button ]               │
│                                 │
│  ... scroll for more ...        │
└─────────────────────────────────┘
```

---

## What You'll See

### 📚 Full Component Showcase

1. **Typography** - All 12 iOS text styles
2. **Colors** - System color palette
3. **Buttons** - 5 styles, 3 sizes, loading states
4. **Text Fields** - Email, password, search inputs
5. **Cards** - Simple and grouped cards
6. **Segmented Control** - iOS-style picker
7. **Switches** - Toggle switches with icons
8. **List Tiles** - Settings-style lists

### 🌓 Dark Mode Testing

- Toggle dark mode with brightness button (☀️/🌙) in home screen
- All components adapt instantly
- See iOS-accurate dark mode colors

---

## Alternative: Direct Navigation

If you want to navigate programmatically from code:

```dart
// From anywhere in your app
Navigator.of(context).pushNamed(Routes.uiKitExample);

// Or direct import
import 'package:boilerplate/ui_kit/examples/ui_kit_example_screen.dart';

Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => UIKitExampleScreen()),
);
```

---

## Button Location

The palette button is in the **Home Screen** app bar, between the app title and other action buttons:

```
Posts  [🎨]  [🌍]  [☀️]  [⏻]
       ↑
    Palette button
    (UI Kit Examples)
```

**Other buttons:**
- 🎨 **Palette** - UI Kit Examples (NEW!)
- 🌍 **Language** - Change app language
- ☀️/🌙 **Brightness** - Toggle dark mode
- ⏻ **Power** - Logout

---

## Using Components in Your Code

Once you've seen the examples, start using them:

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';

// Buttons
AppleButton(
  text: 'Get Started',
  onPressed: () {},
)

// Text Fields
AppleTextField(
  label: 'Email',
  placeholder: 'you@example.com',
  prefixIcon: Icons.email,
)

// Cards
AppleCard(
  child: Text('Card content'),
)
```

---

## 📖 More Resources

- **Complete Guide**: `INTEGRATION_COMPLETE.md`
- **Component Reference**: `lib/ui_kit/README.md`
- **Migration Guide**: `lib/ui_kit/INTEGRATION_GUIDE.md`
- **Quick Summary**: `UI_KIT_SUMMARY.md`

---

## 🎉 That's It!

**Run → Login → Tap 🎨 → Explore!**

Enjoy your new Apple UI Kit! 🚀
