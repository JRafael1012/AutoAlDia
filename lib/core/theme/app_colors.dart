import 'package:flutter/material.dart';

/// Paleta de colores oficial de AutoAlDía según las especificaciones de diseño
/// (Secciones 52 y 53 del requerimiento).
abstract class AppColors {
  // Color primario e institucional
  static const Color primaryBlue = Color(0xFF1565C0);
  static const Color primaryBlueDark = Color(0xFF0D47A1);
  static const Color primaryBlueLight = Color(0xFF1E88E5);

  // Fondos y superficies
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Textos y neutros
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color dividerLight = Color(0xFFEEEEEE);

  // Estados visuales (Semáforo de AutoAlDía)
  /// Verde: Información correcta o al día
  static const Color statusSuccess = Color(0xFF2E7D32);
  static const Color statusSuccessContainer = Color(0xFFE8F5E9);

  /// Amarillo / Ámbar: Próximo a vencer / advertencia
  static const Color statusWarning = Color(0xFFF57F17);
  static const Color statusWarningContainer = Color(0xFFFFF8E1);

  /// Rojo: Vencido o requiere atención inmediata
  static const Color statusDanger = Color(0xFFC62828);
  static const Color statusDangerContainer = Color(0xFFFFEBEE);

  /// Gris: Información histórica o inactiva
  static const Color statusInactive = Color(0xFF9E9E9E);
  static const Color statusInactiveContainer = Color(0xFFF5F5F5);
}
