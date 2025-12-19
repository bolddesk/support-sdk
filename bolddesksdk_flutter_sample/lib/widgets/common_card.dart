import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Border? border;

  const CommonCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.onTap,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDark ? 30 : 5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
