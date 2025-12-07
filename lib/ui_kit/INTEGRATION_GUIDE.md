# Apple UI Kit - Integration Guide

This guide will help you integrate the Apple UI Kit into your Flutter Boilerplate project.

## Quick Integration (5 minutes)

### Step 1: Update Your App Theme

Open `lib/presentation/my_app.dart` and replace the existing theme with Apple theme:

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... other properties
      theme: AppleTheme.lightTheme(),
      darkTheme: AppleTheme.darkTheme(),
      themeMode: ThemeMode.system,
      // ... rest of your app
    );
  }
}
```

### Step 2: Test the UI Kit

Add a route to the example screen in your `lib/utils/routes/routes.dart`:

```dart
import 'package:boilerplate/ui_kit/examples/ui_kit_example_screen.dart';

class Routes {
  // ... existing routes
  static const String uiKitExample = '/ui-kit-example';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ... existing cases
      case uiKitExample:
        return MaterialPageRoute(builder: (_) => UIKitExampleScreen());
      // ... rest
    }
  }
}
```

### Step 3: Navigate to Example Screen

From anywhere in your app:

```dart
Navigator.pushNamed(context, Routes.uiKitExample);
```

Or directly:

```dart
import 'package:boilerplate/ui_kit/examples/ui_kit_example_screen.dart';

Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => UIKitExampleScreen()),
);
```

## Migrating Existing Screens

### Replace Existing Buttons

**Before:**
```dart
RoundedButtonWidget(
  buttonText: 'Sign In',
  buttonColor: Colors.blue,
  onPressed: () {},
)
```

**After:**
```dart
AppleButton(
  text: 'Sign In',
  onPressed: () {},
  style: AppleButtonStyle.filled,
)
```

### Replace Text Fields

**Before:**
```dart
TextFieldWidget(
  hint: 'Email',
  icon: Icons.email,
  textController: _emailController,
)
```

**After:**
```dart
AppleTextField(
  label: 'Email',
  placeholder: 'Enter your email',
  prefixIcon: Icons.email,
  controller: _emailController,
)
```

### Update Login Screen Example

Here's how to update your login screen (`lib/presentation/login/login.dart`):

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';

class LoginScreen extends StatefulWidget {
  // ... existing code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppleAppBar(
        titleText: 'Sign In',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or title
              Text(
                'Welcome Back',
                style: AppleTypography.largeTitle,
              ),
              SizedBox(height: 40),

              // Email field
              AppleTextField(
                label: 'Email',
                placeholder: 'you@example.com',
                prefixIcon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Password field
              AppleTextField(
                label: 'Password',
                placeholder: 'Enter your password',
                prefixIcon: Icons.lock,
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 24),

              // Sign in button
              AppleButton(
                text: 'Sign In',
                onPressed: _handleSignIn,
                width: double.infinity,
                style: AppleButtonStyle.filled,
              ),
              SizedBox(height: 12),

              // Secondary action
              AppleButton(
                text: 'Create Account',
                onPressed: _handleSignUp,
                width: double.infinity,
                style: AppleButtonStyle.plain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Update Home Screen with Navigation

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';

class HomeScreen extends StatefulWidget {
  // ... existing code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppleLargeTitleAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _openSettings(),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Welcome card
          AppleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome!', style: AppleTypography.title2Emphasized),
                SizedBox(height: 8),
                Text('Start exploring', style: AppleTypography.body),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Settings group
          AppleGroupedCard(
            children: [
              AppleListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                showChevron: true,
                onTap: () {},
              ),
              AppleListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                showChevron: true,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AppleNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          AppleNavigationBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          AppleNavigationBarItem(
            icon: Icons.search,
            label: 'Search',
          ),
          AppleNavigationBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

## Advanced Usage

### Custom Theme Colors

Override specific colors while keeping the Apple theme:

```dart
ThemeData customTheme = AppleTheme.lightTheme().copyWith(
  colorScheme: AppleTheme.lightTheme().colorScheme.copyWith(
    primary: AppleColors.systemPurple,
    secondary: AppleColors.systemOrange,
  ),
);

MaterialApp(
  theme: customTheme,
  // ...
)
```

### Using with MobX Stores

Example with the existing login store:

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

@override
Widget build(BuildContext context) {
  return Observer(
    builder: (_) => AppleButton(
      text: 'Sign In',
      onPressed: _store.canLogin ? _handleSignIn : null,
      loading: _store.loading,
      width: double.infinity,
    ),
  );
}
```

### Adaptive Colors in Custom Widgets

```dart
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final textColor = isDark ? AppleColors.labelDark : AppleColors.label;
  final bgColor = isDark
    ? AppleColors.secondarySystemBackgroundDark
    : AppleColors.secondarySystemBackground;

  return Container(
    color: bgColor,
    child: Text(
      'Adaptive Text',
      style: AppleTypography.body.copyWith(color: textColor),
    ),
  );
}
```

## Component Mapping

Quick reference for migrating from existing components:

| Old Component | New Component | Notes |
|--------------|---------------|-------|
| `RoundedButtonWidget` | `AppleButton` | More styles, built-in loading |
| `TextFieldWidget` | `AppleTextField` | Auto-clear, password toggle |
| `EmptyAppBar` | `AppleAppBar` | Centered title by default |
| Custom cards | `AppleCard` | iOS-style rounded corners |
| Custom lists | `AppleGroupedCard` | Auto dividers |
| Standard `Switch` | `AppleSwitch` | iOS colors |
| Custom nav bar | `AppleNavigationBar` | Active states |

## Styling Best Practices

### 1. Use Semantic Text Styles

```dart
// ✅ Good - Semantic naming
Text('Section Title', style: AppleTypography.title2Emphasized)
Text('Body content', style: AppleTypography.body)
Text('Small print', style: AppleTypography.footnote)

// ❌ Avoid - Arbitrary sizes
Text('Title', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
```

### 2. Consistent Spacing

```dart
// ✅ Good - Multiples of 4 or 8
SizedBox(height: 16)
EdgeInsets.all(16)
EdgeInsets.symmetric(horizontal: 16, vertical: 12)
```

### 3. System Colors

```dart
// ✅ Good - Use system colors
AppleColors.systemBlue
AppleColors.systemRed

// ❌ Avoid - Custom colors unless branded
Color(0xFF1234AB)
```

## Testing Your Integration

1. **Visual Testing**: Run the example screen
   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(builder: (_) => UIKitExampleScreen()),
   );
   ```

2. **Theme Testing**: Toggle between light/dark mode
   - iOS: Settings → Developer → Dark Appearance
   - Android: Settings → Display → Dark theme

3. **Responsive Testing**: Test on different screen sizes

## Troubleshooting

### Colors not changing in dark mode

Make sure you're using adaptive colors:
```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
final color = isDark ? AppleColors.labelDark : AppleColors.label;
```

### Text not visible

Use label colors instead of fixed colors:
```dart
// ✅ Good
color: isDark ? AppleColors.labelDark : AppleColors.label

// ❌ Avoid
color: Colors.black  // Won't work in dark mode
```

### Buttons not responding

Check that `onPressed` is not null:
```dart
AppleButton(
  text: 'Click me',
  onPressed: () {},  // ✅ Not null
)
```

## Next Steps

1. ✅ Update `my_app.dart` with Apple theme
2. ✅ Add route to example screen
3. ✅ Test the UI kit
4. 🔄 Gradually migrate existing screens
5. 🔄 Customize colors if needed
6. 🔄 Add your app-specific components

## Need Help?

- Check the main [README.md](README.md) for component documentation
- Review the [example screen](examples/ui_kit_example_screen.dart) for usage patterns
- Look at iOS Human Interface Guidelines for design patterns

---

**Ready to build beautiful iOS-style Flutter apps!** 🚀
