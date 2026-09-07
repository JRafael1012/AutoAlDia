import 'package:flutter/material.dart';

/// Campo de texto unificado para formularios de AutoAlDía.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
    super.key,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final bool enabled;
  final int? maxLength;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        helperText: helperText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
