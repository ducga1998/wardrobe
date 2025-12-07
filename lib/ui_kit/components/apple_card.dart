import 'package:flutter/material.dart';
import '../theme/apple_colors.dart';

/// Apple-style card component
class AppleCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double? elevation;
  final double borderRadius;
  final Border? border;
  final bool filled;

  const AppleCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.onTap,
    this.elevation,
    this.borderRadius = 10,
    this.border,
    this.filled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = filled
        ? (isDark
            ? AppleColors.secondarySystemGroupedBackgroundDark
            : AppleColors.secondarySystemGroupedBackground)
        : Colors.transparent;

    final effectiveBackgroundColor = backgroundColor ?? defaultBackgroundColor;

    final content = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      child: child,
    );

    if (onTap != null) {
      return Container(
        margin: margin,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: content,
          ),
        ),
      );
    }

    return Container(
      margin: margin,
      child: content,
    );
  }
}

/// Apple-style grouped list card
class AppleGroupedCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double borderRadius;
  final bool showDividers;

  const AppleGroupedCard({
    Key? key,
    required this.children,
    this.margin,
    this.backgroundColor,
    this.borderRadius = 10,
    this.showDividers = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBackgroundColor = isDark
        ? AppleColors.secondarySystemGroupedBackgroundDark
        : AppleColors.secondarySystemGroupedBackground;

    final effectiveBackgroundColor = backgroundColor ?? defaultBackgroundColor;
    final separatorColor = isDark ? AppleColors.separatorDark : AppleColors.separator;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Column(
          children: _buildChildrenWithDividers(separatorColor),
        ),
      ),
    );
  }

  List<Widget> _buildChildrenWithDividers(Color separatorColor) {
    if (!showDividers || children.isEmpty) {
      return children;
    }

    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(Divider(
          height: 0.5,
          thickness: 0.5,
          color: separatorColor,
          indent: 16,
        ));
      }
    }
    return result;
  }
}

/// Apple-style list tile for grouped cards
class AppleListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final bool showChevron;

  const AppleListTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.contentPadding,
    this.showChevron = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chevronColor = isDark ? AppleColors.systemGray : AppleColors.systemGray2;

    Widget? effectiveTrailing = trailing;
    if (showChevron && trailing == null) {
      effectiveTrailing = Icon(
        Icons.chevron_right,
        color: chevronColor,
        size: 20,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              if (effectiveTrailing != null) ...[
                const SizedBox(width: 12),
                effectiveTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
