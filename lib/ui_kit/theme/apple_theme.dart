import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apple_colors.dart';
import 'apple_typography.dart';

/// Apple-inspired theme configuration
class AppleTheme {
  AppleTheme._();

  // MARK: - Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppleColors.systemBlue,
        onPrimary: Colors.white,
        secondary: AppleColors.systemGreen,
        onSecondary: Colors.white,
        error: AppleColors.systemRed,
        onError: Colors.white,
        surface: AppleColors.systemBackground,
        onSurface: AppleColors.label,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppleColors.systemBackground,

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppleColors.systemBackground,
        foregroundColor: AppleColors.label,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: AppleColors.label,
          fontSize: 17,
          fontWeight: AppleTypography.semibold,
          letterSpacing: -0.408,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppleColors.secondarySystemGroupedBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppleColors.systemBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: AppleTypography.body.copyWith(
            fontWeight: AppleTypography.semibold,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppleColors.systemBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppleTypography.body,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppleColors.systemBlue,
          side: const BorderSide(color: AppleColors.systemBlue, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: AppleTypography.body.copyWith(
            fontWeight: AppleTypography.semibold,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppleColors.tertiarySystemFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppleColors.systemBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppleColors.systemRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppleColors.systemRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: AppleTypography.body.copyWith(
          color: AppleColors.tertiaryLabel,
        ),
        labelStyle: AppleTypography.body.copyWith(
          color: AppleColors.secondaryLabel,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppleColors.separator,
        thickness: 0.5,
        space: 1,
      ),

      // List Tile
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tileColor: AppleColors.secondarySystemGroupedBackground,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppleColors.systemGreen;
          }
          return AppleColors.systemGray5;
        }),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppleColors.systemBackground,
        selectedItemColor: AppleColors.systemBlue,
        unselectedItemColor: AppleColors.systemGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  // MARK: - Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppleColors.systemBlueDark,
        onPrimary: Colors.white,
        secondary: AppleColors.systemGreenDark,
        onSecondary: Colors.white,
        error: AppleColors.systemRedDark,
        onError: Colors.white,
        surface: AppleColors.systemBackgroundDark,
        onSurface: AppleColors.labelDark,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppleColors.systemBackgroundDark,

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppleColors.systemBackgroundDark,
        foregroundColor: AppleColors.labelDark,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: AppleColors.labelDark,
          fontSize: 17,
          fontWeight: AppleTypography.semibold,
          letterSpacing: -0.408,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppleColors.secondarySystemGroupedBackgroundDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppleColors.systemBlueDark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: AppleTypography.body.copyWith(
            fontWeight: AppleTypography.semibold,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppleColors.systemBlueDark,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppleTypography.body,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppleColors.systemBlueDark,
          side: const BorderSide(color: AppleColors.systemBlueDark, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: AppleTypography.body.copyWith(
            fontWeight: AppleTypography.semibold,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppleColors.tertiarySystemFillDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppleColors.systemBlueDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppleColors.systemRedDark, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppleColors.systemRedDark, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: AppleTypography.body.copyWith(
          color: AppleColors.tertiaryLabelDark,
        ),
        labelStyle: AppleTypography.body.copyWith(
          color: AppleColors.secondaryLabelDark,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppleColors.separatorDark,
        thickness: 0.5,
        space: 1,
      ),

      // List Tile
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tileColor: AppleColors.secondarySystemGroupedBackgroundDark,
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppleColors.systemGreenDark;
          }
          return AppleColors.systemGray;
        }),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppleColors.systemBackgroundDark,
        selectedItemColor: AppleColors.systemBlueDark,
        unselectedItemColor: AppleColors.systemGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
