import 'dart:ui';

class PrimaryButtonStyle {
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;

  const PrimaryButtonStyle({
    required this.backgroundColor,
    required this.borderRadius,
    required this.elevation,
  });

  PrimaryButtonStyle copyWith({
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
  }) {
    return PrimaryButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
    );
  }
}
