import 'package:flutter/material.dart';
import '../theme/apple_colors.dart';
import '../theme/apple_typography.dart';

/// Apple-style button variants
enum AppleButtonStyle {
  filled,
  tinted,
  gray,
  plain,
  bordered,
}

enum AppleButtonSize {
  small,
  medium,
  large,
}

/// Apple-inspired button component
class AppleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppleButtonStyle style;
  final AppleButtonSize size;
  final Color? color;
  final IconData? icon;
  final bool loading;
  final double? width;
  final bool disabled;

  const AppleButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.style = AppleButtonStyle.filled,
    this.size = AppleButtonSize.medium,
    this.color,
    this.icon,
    this.loading = false,
    this.width,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppleColors.systemBlue;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = disabled || onPressed == null;

    return SizedBox(
      width: width,
      height: _getHeight(),
      child: _buildButton(context, effectiveColor, isDark, isDisabled),
    );
  }

  Widget _buildButton(BuildContext context, Color color, bool isDark, bool isDisabled) {
    switch (style) {
      case AppleButtonStyle.filled:
        return _buildFilledButton(context, color, isDisabled);
      case AppleButtonStyle.tinted:
        return _buildTintedButton(context, color, isDisabled);
      case AppleButtonStyle.gray:
        return _buildGrayButton(context, isDark, isDisabled);
      case AppleButtonStyle.plain:
        return _buildPlainButton(context, color, isDisabled);
      case AppleButtonStyle.bordered:
        return _buildBorderedButton(context, color, isDisabled);
    }
  }

  Widget _buildFilledButton(BuildContext context, Color color, bool isDisabled) {
    return ElevatedButton(
      onPressed: isDisabled || loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? AppleColors.systemGray4 : color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        disabledBackgroundColor: AppleColors.systemGray5,
        disabledForegroundColor: AppleColors.systemGray3,
      ),
      child: _buildButtonContent(Colors.white),
    );
  }

  Widget _buildTintedButton(BuildContext context, Color color, bool isDisabled) {
    final tintColor = color.withValues(alpha: 0.15);
    return ElevatedButton(
      onPressed: isDisabled || loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? AppleColors.systemGray5 : tintColor,
        foregroundColor: isDisabled ? AppleColors.systemGray3 : color,
        elevation: 0,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
      ),
      child: _buildButtonContent(isDisabled ? AppleColors.systemGray3 : color),
    );
  }

  Widget _buildGrayButton(BuildContext context, bool isDark, bool isDisabled) {
    final bgColor = isDark ? AppleColors.systemGray4.withValues(alpha: 0.3) : AppleColors.systemGray5;
    final fgColor = isDark ? AppleColors.labelDark : AppleColors.label;

    return ElevatedButton(
      onPressed: isDisabled || loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? AppleColors.systemGray6 : bgColor,
        foregroundColor: isDisabled ? AppleColors.systemGray3 : fgColor,
        elevation: 0,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
      ),
      child: _buildButtonContent(isDisabled ? AppleColors.systemGray3 : fgColor),
    );
  }

  Widget _buildPlainButton(BuildContext context, Color color, bool isDisabled) {
    return TextButton(
      onPressed: isDisabled || loading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: isDisabled ? AppleColors.systemGray3 : color,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
      ),
      child: _buildButtonContent(isDisabled ? AppleColors.systemGray3 : color),
    );
  }

  Widget _buildBorderedButton(BuildContext context, Color color, bool isDisabled) {
    return OutlinedButton(
      onPressed: isDisabled || loading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: isDisabled ? AppleColors.systemGray3 : color,
        side: BorderSide(
          color: isDisabled ? AppleColors.systemGray4 : color,
          width: 1,
        ),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
      ),
      child: _buildButtonContent(isDisabled ? AppleColors.systemGray3 : color),
    );
  }

  Widget _buildButtonContent(Color textColor) {
    if (loading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    final textWidget = Text(
      text,
      style: _getTextStyle().copyWith(color: textColor),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: _getIconSize(), color: textColor),
          const SizedBox(width: 8),
          textWidget,
        ],
      );
    }

    return textWidget;
  }

  double _getHeight() {
    switch (size) {
      case AppleButtonSize.small:
        return 32;
      case AppleButtonSize.medium:
        return 44;
      case AppleButtonSize.large:
        return 56;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppleButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case AppleButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case AppleButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppleButtonSize.small:
        return 8;
      case AppleButtonSize.medium:
        return 10;
      case AppleButtonSize.large:
        return 12;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppleButtonSize.small:
        return AppleTypography.footnote.copyWith(fontWeight: AppleTypography.semibold);
      case AppleButtonSize.medium:
        return AppleTypography.body.copyWith(fontWeight: AppleTypography.semibold);
      case AppleButtonSize.large:
        return AppleTypography.headline;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppleButtonSize.small:
        return 14;
      case AppleButtonSize.medium:
        return 17;
      case AppleButtonSize.large:
        return 20;
    }
  }
}
