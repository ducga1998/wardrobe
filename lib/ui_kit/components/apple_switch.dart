import 'package:flutter/material.dart';
import '../theme/apple_colors.dart';

/// Apple-style switch component
class AppleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveTrackColor;
  final bool disabled;

  const AppleSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveActiveColor = activeColor ??
        (isDark ? AppleColors.systemGreenDark : AppleColors.systemGreen);
    final effectiveInactiveColor = inactiveTrackColor ??
        (isDark ? AppleColors.systemGray : AppleColors.systemGray5);

    return Switch(
      value: value,
      onChanged: disabled ? null : onChanged,
      thumbColor: WidgetStateProperty.all(Colors.white),
      activeThumbColor: Colors.white,
      activeTrackColor: effectiveActiveColor,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: effectiveInactiveColor,
    );
  }
}

/// Apple-style switch list tile
class AppleSwitchTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool disabled;

  const AppleSwitchTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.contentPadding,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    subtitle!,
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            AppleSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              disabled: disabled,
            ),
          ],
        ),
      ),
    );
  }
}
