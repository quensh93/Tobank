import 'package:flutter/material.dart';

// Design tokens for consistent spacing, radii, and durations
class Spacing extends ThemeExtension<Spacing> {
  const Spacing({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 48.0,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  ThemeExtension<Spacing> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return Spacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<Spacing> lerp(ThemeExtension<Spacing>? other, double t) {
    if (other is! Spacing) return this;
    return Spacing(
      xs: xs + (other.xs - xs) * t,
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      xxl: xxl + (other.xxl - xxl) * t,
    );
  }
}

class Radii extends ThemeExtension<Radii> {
  const Radii({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 12.0,
    this.lg = 16.0,
    this.xl = 20.0,
    this.xxl = 24.0,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  ThemeExtension<Radii> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return Radii(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<Radii> lerp(ThemeExtension<Radii>? other, double t) {
    if (other is! Radii) return this;
    return Radii(
      xs: xs + (other.xs - xs) * t,
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      xxl: xxl + (other.xxl - xxl) * t,
    );
  }
}

class Durations extends ThemeExtension<Durations> {
  const Durations({
    this.fast = 150,
    this.normal = 300,
    this.slow = 500,
  });

  final int fast;
  final int normal;
  final int slow;

  @override
  ThemeExtension<Durations> copyWith({
    int? fast,
    int? normal,
    int? slow,
  }) {
    return Durations(
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
    );
  }

  @override
  ThemeExtension<Durations> lerp(ThemeExtension<Durations>? other, double t) {
    if (other is! Durations) return this;
    return Durations(
      fast: ((fast + (other.fast - fast) * t).round()),
      normal: ((normal + (other.normal - normal) * t).round()),
      slow: ((slow + (other.slow - slow) * t).round()),
    );
  }
}
