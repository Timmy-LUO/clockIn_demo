import 'package:flutter/material.dart';

final class FillColorButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback onTap;

  const FillColorButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        side: (borderColor != null) ? BorderSide(color: borderColor!) : null,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
      ),
    );
  }
}