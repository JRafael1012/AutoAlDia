import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum StatusBadgeType {
  /// Verde: Al día / Correcto
  success,

  /// Amarillo: Próximo a vencer / Advertencia
  warning,

  /// Rojo: Vencido / Requiere atención
  danger,

  /// Gris: Histórico o inactivo
  inactive,
}

/// Chip indicador con el semáforo visual oficial de AutoAlDía.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    required this.type,
    this.icon,
    super.key,
  });

  final String label;
  final StatusBadgeType type;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (textColor, bgColor) = switch (type) {
      StatusBadgeType.success => (
          AppColors.statusSuccess,
          AppColors.statusSuccessContainer,
        ),
      StatusBadgeType.warning => (
          AppColors.statusWarning,
          AppColors.statusWarningContainer,
        ),
      StatusBadgeType.danger => (
          AppColors.statusDanger,
          AppColors.statusDangerContainer,
        ),
      StatusBadgeType.inactive => (
          AppColors.statusInactive,
          AppColors.statusInactiveContainer,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withAlpha(50), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
