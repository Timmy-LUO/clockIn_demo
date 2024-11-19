import 'package:flutter/material.dart';
import 'package:clock_in_demo/Utility/app_color.dart';

final class IconTextButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final IconData icon;
  final bool isIconRight;
  final Color? iconColor;
  final VoidCallback onPressed;

  const IconTextButton({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.icon = Icons.keyboard_arrow_down,
    this.isIconRight = true,
    this.iconColor = AppColor.textGrey_0xFF6B6C71,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(0, 40),
      ),
      child: (isIconRight)
        ? Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: AppColor.textGrey_0xFF6B6C71,
                  fontSize: fontSize,
                ),
              ),
              Icon(icon, color: iconColor),
            ],
          )
        : Row(
            children: [
              Icon(icon, color: iconColor),
              Text(
                text,
                style: TextStyle(
                  color: AppColor.textGrey_0xFF6B6C71,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
    );
  }
}