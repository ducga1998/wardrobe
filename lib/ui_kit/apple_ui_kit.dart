/// Apple UI Kit - A comprehensive Apple-inspired UI component library
///
/// This library provides a complete set of Apple-style UI components
/// following iOS Human Interface Guidelines.
///
/// ## Features
/// - Apple-style color system with light/dark mode support
/// - iOS typography hierarchy
/// - Pre-built components (buttons, cards, inputs, navigation)
/// - Adaptive themes
///
/// ## Usage
/// ```dart
/// import 'package:boilerplate/ui_kit/apple_ui_kit.dart';
///
/// // Use in your app
/// MaterialApp(
///   theme: AppleTheme.lightTheme(),
///   darkTheme: AppleTheme.darkTheme(),
///   // ...
/// );
/// ```

library apple_ui_kit;

// Theme
export 'theme/apple_colors.dart';
export 'theme/apple_typography.dart';
export 'theme/apple_theme.dart';

// Components
export 'components/apple_button.dart';
export 'components/apple_card.dart';
export 'components/apple_text_field.dart';
export 'components/apple_segmented_control.dart';
export 'components/apple_switch.dart';
export 'components/apple_navigation_bar.dart';
