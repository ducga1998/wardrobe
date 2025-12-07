import 'package:flutter/material.dart';

/// Apple-inspired color palette
/// Based on iOS Human Interface Guidelines
class AppleColors {
  AppleColors._();

  // MARK: - System Colors (Light Mode)
  static const Color systemBlue = Color(0xFF007AFF);
  static const Color systemGreen = Color(0xFF34C759);
  static const Color systemIndigo = Color(0xFF5856D6);
  static const Color systemOrange = Color(0xFFFF9500);
  static const Color systemPink = Color(0xFFFF2D55);
  static const Color systemPurple = Color(0xFFAF52DE);
  static const Color systemRed = Color(0xFFFF3B30);
  static const Color systemTeal = Color(0xFF5AC8FA);
  static const Color systemYellow = Color(0xFFFFCC00);

  // MARK: - System Gray Colors
  static const Color systemGray = Color(0xFF8E8E93);
  static const Color systemGray2 = Color(0xFFAEAEB2);
  static const Color systemGray3 = Color(0xFFC7C7CC);
  static const Color systemGray4 = Color(0xFFD1D1D6);
  static const Color systemGray5 = Color(0xFFE5E5EA);
  static const Color systemGray6 = Color(0xFFF2F2F7);

  // MARK: - Label Colors (Light Mode)
  static const Color label = Color(0xFF000000);
  static const Color secondaryLabel = Color(0x99000000); // 60% opacity
  static const Color tertiaryLabel = Color(0x4D000000); // 30% opacity
  static const Color quaternaryLabel = Color(0x2D000000); // 18% opacity

  // MARK: - Background Colors (Light Mode)
  static const Color systemBackground = Color(0xFFFFFFFF);
  static const Color secondarySystemBackground = Color(0xFFF2F2F7);
  static const Color tertiarySystemBackground = Color(0xFFFFFFFF);

  // MARK: - Grouped Background Colors (Light Mode)
  static const Color systemGroupedBackground = Color(0xFFF2F2F7);
  static const Color secondarySystemGroupedBackground = Color(0xFFFFFFFF);
  static const Color tertiarySystemGroupedBackground = Color(0xFFF2F2F7);

  // MARK: - Fill Colors (Light Mode)
  static const Color systemFill = Color(0x33787880); // 20% opacity
  static const Color secondarySystemFill = Color(0x28787880); // 16% opacity
  static const Color tertiarySystemFill = Color(0x1E787880); // 12% opacity
  static const Color quaternarySystemFill = Color(0x14787880); // 8% opacity

  // MARK: - Separator Colors
  static const Color separator = Color(0x493C3C43); // 29% opacity
  static const Color opaqueSeparator = Color(0xFFC6C6C8);

  // MARK: - Dark Mode Colors
  static const Color systemBlueDark = Color(0xFF0A84FF);
  static const Color systemGreenDark = Color(0xFF30D158);
  static const Color systemIndigoDark = Color(0xFF5E5CE6);
  static const Color systemOrangeDark = Color(0xFFFF9F0A);
  static const Color systemPinkDark = Color(0xFFFF375F);
  static const Color systemPurpleDark = Color(0xFFBF5AF2);
  static const Color systemRedDark = Color(0xFFFF453A);
  static const Color systemTealDark = Color(0xFF64D2FF);
  static const Color systemYellowDark = Color(0xFFFFD60A);

  // MARK: - Label Colors (Dark Mode)
  static const Color labelDark = Color(0xFFFFFFFF);
  static const Color secondaryLabelDark = Color(0x99FFFFFF); // 60% opacity
  static const Color tertiaryLabelDark = Color(0x4DFFFFFF); // 30% opacity
  static const Color quaternaryLabelDark = Color(0x2DFFFFFF); // 18% opacity

  // MARK: - Background Colors (Dark Mode)
  static const Color systemBackgroundDark = Color(0xFF000000);
  static const Color secondarySystemBackgroundDark = Color(0xFF1C1C1E);
  static const Color tertiarySystemBackgroundDark = Color(0xFF2C2C2E);

  // MARK: - Grouped Background Colors (Dark Mode)
  static const Color systemGroupedBackgroundDark = Color(0xFF000000);
  static const Color secondarySystemGroupedBackgroundDark = Color(0xFF1C1C1E);
  static const Color tertiarySystemGroupedBackgroundDark = Color(0xFF2C2C2E);

  // MARK: - Fill Colors (Dark Mode)
  static const Color systemFillDark = Color(0x5C787880); // 36% opacity
  static const Color secondarySystemFillDark = Color(0x51787880); // 32% opacity
  static const Color tertiarySystemFillDark = Color(0x3D787880); // 24% opacity
  static const Color quaternarySystemFillDark = Color(0x2E787880); // 18% opacity

  // MARK: - Separator Colors (Dark Mode)
  static const Color separatorDark = Color(0x99545458); // 60% opacity
  static const Color opaqueSeparatorDark = Color(0xFF38383A);

  // MARK: - Helper Methods
  static Color adaptiveColor(BuildContext context, {
    required Color light,
    required Color dark,
  }) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }

  static Color adaptiveSystemColor(BuildContext context, AppleSystemColor color) {
    final brightness = Theme.of(context).brightness;
    switch (color) {
      case AppleSystemColor.blue:
        return brightness == Brightness.dark ? systemBlueDark : systemBlue;
      case AppleSystemColor.green:
        return brightness == Brightness.dark ? systemGreenDark : systemGreen;
      case AppleSystemColor.indigo:
        return brightness == Brightness.dark ? systemIndigoDark : systemIndigo;
      case AppleSystemColor.orange:
        return brightness == Brightness.dark ? systemOrangeDark : systemOrange;
      case AppleSystemColor.pink:
        return brightness == Brightness.dark ? systemPinkDark : systemPink;
      case AppleSystemColor.purple:
        return brightness == Brightness.dark ? systemPurpleDark : systemPurple;
      case AppleSystemColor.red:
        return brightness == Brightness.dark ? systemRedDark : systemRed;
      case AppleSystemColor.teal:
        return brightness == Brightness.dark ? systemTealDark : systemTeal;
      case AppleSystemColor.yellow:
        return brightness == Brightness.dark ? systemYellowDark : systemYellow;
    }
  }
}

enum AppleSystemColor {
  blue,
  green,
  indigo,
  orange,
  pink,
  purple,
  red,
  teal,
  yellow,
}
