import 'package:flutter/material.dart';

// Semantic colors for consistent theming
class SemanticColors extends ThemeExtension<SemanticColors> {
  const SemanticColors({
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.surface,
    required this.surfaceVariant,
    required this.outline,
  });

  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color surface;
  final Color surfaceVariant;
  final Color outline;

  @override
  ThemeExtension<SemanticColors> copyWith({
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? surface,
    Color? surfaceVariant,
    Color? outline,
  }) {
    return SemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      outline: outline ?? this.outline,
    );
  }

  @override
  ThemeExtension<SemanticColors> lerp(ThemeExtension<SemanticColors>? other, double t) {
    if (other is! SemanticColors) return this;
    return SemanticColors(
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      error: Color.lerp(error, other.error, t) ?? error,
      info: Color.lerp(info, other.info, t) ?? info,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t) ?? surfaceVariant,
      outline: Color.lerp(outline, other.outline, t) ?? outline,
    );
  }
}

// Light semantic colors
const lightSemanticColors = SemanticColors(
  success: Color(0xFF2E7D32),
  warning: Color(0xFFF57C00),
  error: Color(0xFFD32F2F),
  info: Color(0xFF1976D2),
  surface: Color(0xFFFFFBFE),
  surfaceVariant: Color(0xFFE7E0EC),
  outline: Color(0xFF79747E),
);

// Dark semantic colors
const darkSemanticColors = SemanticColors(
  success: Color(0xFF4CAF50),
  warning: Color(0xFFFF9800),
  error: Color(0xFFF44336),
  info: Color(0xFF2196F3),
  surface: Color(0xFF1C1B1F),
  surfaceVariant: Color(0xFF49454F),
  outline: Color(0xFF938F99),
);
