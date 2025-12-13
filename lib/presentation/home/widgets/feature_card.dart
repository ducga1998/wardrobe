import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isLarge;

  const FeatureCard({
    Key? key,
    required this.title,
    required this.icon,
    this.backgroundColor,
    this.onTap,
    this.isLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? const Color(0xFFF5F6FA),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () {},
        hoverColor: Colors.black.withOpacity(0.05),
        splashColor: Colors.black.withOpacity(0.1),
        highlightColor: Colors.black.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isLarge) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: icon,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ] else ...[
                Align(
                  alignment: Alignment.center,
                  child: icon,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
