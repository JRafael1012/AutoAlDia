import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Tarjeta estilizada base para AutoAlDía.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
    this.color,
    this.borderColor,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderColor =
        borderColor ?? theme.colorScheme.outlineVariant.withAlpha(120);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? theme.cardTheme.color ?? AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: effectiveBorderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
