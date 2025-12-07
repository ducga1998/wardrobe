import 'package:flutter/material.dart';
import '../theme/apple_colors.dart';
import '../theme/apple_typography.dart';

/// Apple-style navigation bar item
class AppleNavigationBarItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const AppleNavigationBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

/// Apple-style bottom navigation bar
class AppleNavigationBar extends StatelessWidget {
  final List<AppleNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double height;

  const AppleNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor = backgroundColor ??
        (isDark ? AppleColors.systemBackgroundDark : AppleColors.systemBackground);
    final effectiveSelectedColor = selectedItemColor ??
        (isDark ? AppleColors.systemBlueDark : AppleColors.systemBlue);
    final effectiveUnselectedColor = unselectedItemColor ?? AppleColors.systemGray;
    final separatorColor = isDark ? AppleColors.separatorDark : AppleColors.separator;

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          top: BorderSide(
            color: separatorColor,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected && item.activeIcon != null
                            ? item.activeIcon
                            : item.icon,
                        color: isSelected
                            ? effectiveSelectedColor
                            : effectiveUnselectedColor,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: AppleTypography.caption2.copyWith(
                          color: isSelected
                              ? effectiveSelectedColor
                              : effectiveUnselectedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Apple-style app bar
class AppleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  const AppleAppBar({
    Key? key,
    this.title,
    this.titleText,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.centerTitle = true,
    this.bottom,
  })  : assert(title != null || titleText != null, 'Either title or titleText must be provided'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor = backgroundColor ??
        (isDark ? AppleColors.systemBackgroundDark : AppleColors.systemBackground);
    final effectiveForegroundColor = foregroundColor ??
        (isDark ? AppleColors.labelDark : AppleColors.label);

    return AppBar(
      title: title ??
          Text(
            titleText!,
            style: AppleTypography.headline.copyWith(color: effectiveForegroundColor),
          ),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}

/// Apple-style large title app bar
class AppleLargeTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;

  const AppleLargeTitleAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor = backgroundColor ??
        (isDark ? AppleColors.systemBackgroundDark : AppleColors.systemBackground);
    final effectiveForegroundColor = foregroundColor ??
        (isDark ? AppleColors.labelDark : AppleColors.label);

    return AppBar(
      title: Text(
        title,
        style: AppleTypography.largeTitleEmphasized.copyWith(
          color: effectiveForegroundColor,
        ),
      ),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 96,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        96 + (bottom?.preferredSize.height ?? 0.0),
      );
}
