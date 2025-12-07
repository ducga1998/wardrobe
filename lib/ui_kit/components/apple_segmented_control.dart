import 'package:flutter/material.dart';
import '../theme/apple_colors.dart';
import '../theme/apple_typography.dart';

/// Apple-style segmented control
class AppleSegmentedControl<T> extends StatelessWidget {
  final Map<T, String> segments;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double height;

  const AppleSegmentedControl({
    Key? key,
    required this.segments,
    required this.selectedValue,
    required this.onValueChanged,
    this.padding,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.height = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor = backgroundColor ??
        (isDark ? AppleColors.tertiarySystemFillDark : AppleColors.tertiarySystemFill);
    final effectiveSelectedColor = selectedColor ??
        (isDark ? AppleColors.secondarySystemGroupedBackgroundDark : Colors.white);
    final effectiveUnselectedColor = unselectedColor ?? Colors.transparent;

    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: segments.entries.map((entry) {
          final isSelected = entry.key == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: () => onValueChanged(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected ? effectiveSelectedColor : effectiveUnselectedColor,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: AppleTypography.subheadline.copyWith(
                      color: isSelected
                          ? (isDark ? AppleColors.labelDark : AppleColors.label)
                          : (isDark ? AppleColors.secondaryLabelDark : AppleColors.secondaryLabel),
                      fontWeight: isSelected ? AppleTypography.semibold : AppleTypography.regular,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
