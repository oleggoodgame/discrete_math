import 'package:discrete_math/shared/theme/style/primary_button_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final PrimaryButtonStyle style;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.style = const PrimaryButtonStyle(
      backgroundColor: Colors.blueGrey,
      borderRadius: 12,
      elevation: 2,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: style.backgroundColor,
          elevation: style.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(style.borderRadius),
          ),
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }
}
