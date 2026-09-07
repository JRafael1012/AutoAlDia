import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Pantalla temporal informativa mientras se implementa cada pantalla definitiva.
class FeaturePlaceholderScreen extends StatelessWidget {
  const FeaturePlaceholderScreen({
    required this.title,
    required this.icon,
    this.description,
    super.key,
  });

  final String title;
  final IconData icon;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              if (description != null) ...[
                const SizedBox(height: 12),
                Text(
                  description!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
