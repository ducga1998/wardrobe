# Apple UI Kit 🍎

A comprehensive Apple-inspired UI component library for Flutter, following iOS Human Interface Guidelines.

## Features

✨ **Complete Component Library**
- Buttons (5 styles: Filled, Tinted, Gray, Bordered, Plain)
- Cards & Grouped Lists
- Text Fields & Search Fields
- Navigation Bars & App Bars
- Switches & Segmented Controls
- And more...

🎨 **Apple Design System**
- iOS color palette with light/dark mode support
- San Francisco-inspired typography hierarchy
- Adaptive themes that respond to system settings

📱 **iOS-First Design**
- Pixel-perfect components matching iOS standards
- Smooth animations and transitions
- Native-feeling interactions

## Installation

The UI Kit is included in this project. Simply import it:

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';
```

## Quick Start

### 1. Apply Apple Theme

Update your `MaterialApp` to use the Apple theme:

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: AppleTheme.lightTheme(),
      darkTheme: AppleTheme.darkTheme(),
      themeMode: ThemeMode.system, // Responds to system theme
      home: MyHomePage(),
    );
  }
}
```

### 2. Use Components

```dart
import 'package:boilerplate/ui_kit/apple_ui_kit.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppleAppBar(
        titleText: 'My Screen',
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          AppleButton(
            text: 'Get Started',
            onPressed: () {},
          ),
          SizedBox(height: 16),
          AppleTextField(
            label: 'Email',
            placeholder: 'Enter your email',
            prefixIcon: Icons.email,
          ),
        ],
      ),
    );
  }
}
```

## Components

### Buttons

5 button styles with 3 sizes (small, medium, large):

```dart
// Filled Button (Primary)
AppleButton(
  text: 'Continue',
  onPressed: () {},
  style: AppleButtonStyle.filled,
  color: AppleColors.systemBlue,
)

// Tinted Button
AppleButton(
  text: 'Cancel',
  onPressed: () {},
  style: AppleButtonStyle.tinted,
  color: AppleColors.systemRed,
)

// Gray Button
AppleButton(
  text: 'Maybe Later',
  onPressed: () {},
  style: AppleButtonStyle.gray,
)

// Bordered Button
AppleButton(
  text: 'Learn More',
  onPressed: () {},
  style: AppleButtonStyle.bordered,
)

// Plain Button
AppleButton(
  text: 'Skip',
  onPressed: () {},
  style: AppleButtonStyle.plain,
)

// With Icon
AppleButton(
  text: 'Add to Favorites',
  icon: Icons.favorite,
  onPressed: () {},
  style: AppleButtonStyle.filled,
  color: AppleColors.systemPink,
)

// Different Sizes
AppleButton(
  text: 'Small',
  onPressed: () {},
  size: AppleButtonSize.small,
)

AppleButton(
  text: 'Medium',
  onPressed: () {},
  size: AppleButtonSize.medium, // Default
)

AppleButton(
  text: 'Large',
  onPressed: () {},
  size: AppleButtonSize.large,
)

// Loading State
AppleButton(
  text: 'Processing...',
  onPressed: () {},
  loading: true,
)

// Disabled
AppleButton(
  text: 'Disabled',
  onPressed: null, // or disabled: true
)
```

### Text Fields

```dart
// Basic Text Field
AppleTextField(
  label: 'Username',
  placeholder: 'Enter username',
)

// With Icons
AppleTextField(
  label: 'Email',
  placeholder: 'you@example.com',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
)

// Password Field
AppleTextField(
  label: 'Password',
  placeholder: 'Enter password',
  prefixIcon: Icons.lock,
  obscureText: true, // Auto shows visibility toggle
)

// With Clear Button
AppleTextField(
  placeholder: 'Search...',
  clearButtonMode: true,
)

// Search Field
AppleSearchField(
  placeholder: 'Search products...',
  onChanged: (value) => print(value),
)

// Multi-line
AppleTextField(
  label: 'Message',
  placeholder: 'Type your message',
  maxLines: 5,
)

// With Error
AppleTextField(
  placeholder: 'Required field',
  errorText: 'This field cannot be empty',
)
```

### Cards

```dart
// Simple Card
AppleCard(
  child: Text('Card Content'),
)

// Tappable Card
AppleCard(
  onTap: () => print('Card tapped'),
  child: Column(
    children: [
      Text('Tap me', style: AppleTypography.headline),
      Text('Subtitle', style: AppleTypography.body),
    ],
  ),
)

// Grouped Card with List Items
AppleGroupedCard(
  children: [
    AppleListTile(
      leading: Icon(Icons.person),
      title: Text('Profile'),
      subtitle: Text('View your profile'),
      showChevron: true,
      onTap: () {},
    ),
    AppleListTile(
      leading: Icon(Icons.settings),
      title: Text('Settings'),
      showChevron: true,
      onTap: () {},
    ),
  ],
)

// Custom Styling
AppleCard(
  backgroundColor: AppleColors.systemBlue.withOpacity(0.1),
  borderRadius: 16,
  padding: EdgeInsets.all(24),
  child: Text('Custom Card'),
)
```

### Navigation

```dart
// Bottom Navigation Bar
AppleNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
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
)

// Standard App Bar
AppleAppBar(
  titleText: 'My Screen',
  actions: [
    IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
  ],
)

// Large Title App Bar
AppleLargeTitleAppBar(
  title: 'Settings',
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
  ],
)
```

### Switches

```dart
// Basic Switch
AppleSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
)

// Switch List Tile
AppleSwitchTile(
  title: Text('Enable Notifications'),
  subtitle: Text('Receive push notifications'),
  leading: Icon(Icons.notifications),
  value: _notificationsEnabled,
  onChanged: (value) => setState(() => _notificationsEnabled = value),
)

// Custom Color
AppleSwitch(
  value: _value,
  onChanged: (value) => setState(() => _value = value),
  activeColor: AppleColors.systemOrange,
)
```

### Segmented Control

```dart
AppleSegmentedControl<String>(
  segments: {
    'all': 'All',
    'active': 'Active',
    'completed': 'Completed',
  },
  selectedValue: _selectedFilter,
  onValueChanged: (value) => setState(() => _selectedFilter = value),
)

// With Enums
enum TaskFilter { all, active, completed }

AppleSegmentedControl<TaskFilter>(
  segments: {
    TaskFilter.all: 'All',
    TaskFilter.active: 'Active',
    TaskFilter.completed: 'Completed',
  },
  selectedValue: _filter,
  onValueChanged: (value) => setState(() => _filter = value),
)
```

## Typography

Apple UI Kit provides a complete iOS typography hierarchy:

```dart
// Large Titles
Text('Large Title', style: AppleTypography.largeTitle)
Text('Large Title Bold', style: AppleTypography.largeTitleEmphasized)

// Titles
Text('Title 1', style: AppleTypography.title1)
Text('Title 2', style: AppleTypography.title2)
Text('Title 3', style: AppleTypography.title3)

// Headlines & Body
Text('Headline', style: AppleTypography.headline)
Text('Body Text', style: AppleTypography.body)
Text('Body Emphasized', style: AppleTypography.bodyEmphasized)

// Smaller Text
Text('Callout', style: AppleTypography.callout)
Text('Subheadline', style: AppleTypography.subheadline)
Text('Footnote', style: AppleTypography.footnote)
Text('Caption 1', style: AppleTypography.caption1)
Text('Caption 2', style: AppleTypography.caption2)

// Custom Colors
final isDark = Theme.of(context).brightness == Brightness.dark;
Text(
  'Adaptive Text',
  style: AppleTypography.body.copyWith(
    color: isDark ? AppleColors.labelDark : AppleColors.label,
  ),
)
```

## Colors

### System Colors

```dart
// Primary Colors
AppleColors.systemBlue
AppleColors.systemGreen
AppleColors.systemIndigo
AppleColors.systemOrange
AppleColors.systemPink
AppleColors.systemPurple
AppleColors.systemRed
AppleColors.systemTeal
AppleColors.systemYellow

// Gray Scale
AppleColors.systemGray
AppleColors.systemGray2
AppleColors.systemGray3
AppleColors.systemGray4
AppleColors.systemGray5
AppleColors.systemGray6

// Labels (Light Mode)
AppleColors.label              // Primary text
AppleColors.secondaryLabel     // Secondary text (60% opacity)
AppleColors.tertiaryLabel      // Tertiary text (30% opacity)
AppleColors.quaternaryLabel    // Quaternary text (18% opacity)

// Backgrounds (Light Mode)
AppleColors.systemBackground
AppleColors.secondarySystemBackground
AppleColors.tertiarySystemBackground

// Dark Mode Variants
AppleColors.systemBlueDark
AppleColors.labelDark
AppleColors.systemBackgroundDark
// ... etc
```

### Adaptive Colors

Use adaptive colors to automatically switch between light and dark mode:

```dart
// Method 1: Using helper method
final color = AppleColors.adaptiveColor(
  context,
  light: AppleColors.systemBlue,
  dark: AppleColors.systemBlueDark,
);

// Method 2: Using system color enum
final color = AppleColors.adaptiveSystemColor(
  context,
  AppleSystemColor.blue,
);

// Method 3: Manual check
final isDark = Theme.of(context).brightness == Brightness.dark;
final color = isDark ? AppleColors.systemBlueDark : AppleColors.systemBlue;
```

## Example Screen

Check out the complete example:

```dart
import 'package:boilerplate/ui_kit/examples/ui_kit_example_screen.dart';

// Use in your app
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => UIKitExampleScreen()),
);
```

## Best Practices

### 1. Use Adaptive Colors

Always use adaptive colors that respond to light/dark mode:

```dart
// ✅ Good
final textColor = isDark ? AppleColors.labelDark : AppleColors.label;

// ❌ Avoid
final textColor = Colors.black; // Won't work in dark mode
```

### 2. Follow Typography Hierarchy

Use the appropriate text style for the content:

```dart
// ✅ Good
Text('Section Title', style: AppleTypography.title2Emphasized)
Text('Body content goes here', style: AppleTypography.body)
Text('Additional info', style: AppleTypography.footnote)

// ❌ Avoid
Text('Title', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
```

### 3. Consistent Spacing

Use consistent spacing values (multiples of 4 or 8):

```dart
// ✅ Good
SizedBox(height: 16)
EdgeInsets.all(16)
EdgeInsets.symmetric(horizontal: 16, vertical: 12)

// ❌ Avoid
SizedBox(height: 13)
EdgeInsets.all(17)
```

### 4. Button Styles

Choose the right button style for the action:

- **Filled**: Primary actions (Submit, Continue, Save)
- **Tinted**: Secondary actions (Cancel, Edit)
- **Gray**: Tertiary actions (Maybe Later, Not Now)
- **Bordered**: Alternative actions (Learn More)
- **Plain**: Low-priority actions (Skip, Dismiss)

### 5. Cards for Grouping

Use cards to group related content:

```dart
// ✅ Good
AppleGroupedCard(
  children: [
    // Related settings items
  ],
)

// For lists of options
AppleCard(
  child: Column(
    children: [
      // Related content
    ],
  ),
)
```

## Customization

### Custom Theme

You can extend or customize the Apple theme:

```dart
ThemeData customTheme = AppleTheme.lightTheme().copyWith(
  // Your customizations
  colorScheme: AppleTheme.lightTheme().colorScheme.copyWith(
    primary: AppleColors.systemPurple,
  ),
);
```

### Custom Button Colors

```dart
AppleButton(
  text: 'Custom Color',
  onPressed: () {},
  color: Color(0xFF123456), // Your custom color
)
```

### Custom Component Styling

All components support extensive customization:

```dart
AppleCard(
  backgroundColor: Colors.blue.withOpacity(0.1),
  padding: EdgeInsets.all(24),
  margin: EdgeInsets.all(16),
  borderRadius: 20,
  child: YourContent(),
)
```

## Dark Mode Support

All components automatically support dark mode. The theme will switch based on system settings.

To manually control theme mode:

```dart
MaterialApp(
  theme: AppleTheme.lightTheme(),
  darkTheme: AppleTheme.darkTheme(),
  themeMode: ThemeMode.system,  // Auto (default)
  // themeMode: ThemeMode.light,   // Always light
  // themeMode: ThemeMode.dark,    // Always dark
)
```

## Component Reference

| Component | Description | Key Features |
|-----------|-------------|--------------|
| `AppleButton` | Multi-style button | 5 styles, 3 sizes, loading state |
| `AppleTextField` | Text input field | Auto-clear, password toggle, validation |
| `AppleSearchField` | Search input | Auto-clear, search icon |
| `AppleCard` | Container card | Tappable, customizable |
| `AppleGroupedCard` | Grouped list card | Auto dividers, iOS-style |
| `AppleListTile` | List item | Leading/trailing, chevron |
| `AppleSwitch` | Toggle switch | iOS-style animation |
| `AppleSwitchTile` | Switch list item | Full-width tappable |
| `AppleSegmentedControl` | Segmented picker | Smooth animations |
| `AppleNavigationBar` | Bottom nav bar | Active states, badges |
| `AppleAppBar` | Standard app bar | Centered title, actions |
| `AppleLargeTitleAppBar` | Large title bar | iOS 11+ style |

## Resources

- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [iOS Color Palette](https://developer.apple.com/design/human-interface-guidelines/color)

## License

This UI Kit is part of the Flutter Boilerplate project.

---

**Built with ❤️ following Apple's design principles**
