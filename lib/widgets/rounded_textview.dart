import 'package:flutter/material.dart';
import 'package:clock_in_demo/Utility/app_color.dart';

final class RoundedTextView extends StatelessWidget {
  final String statusType;

  const RoundedTextView({
    super.key,
    required this.statusType,
  });

  Color handleBgColor() {
    switch (statusType) {
      case '通過':
        return AppColor.green_0xFF3D9A51;
      case '不通過':
        return AppColor.textRed_0xFFE03845;
      case '中途抽單':
      case '已銷單':
        return AppColor.textGrey_0xFF6B6C71;
      default:
        return AppColor.grey_0xFFDDDDDD;
    }
  }

  Color handleTextColor() {
    switch (statusType) {
      case '通過':
      case '不通過':
        return AppColor.white_0xFFFFFFFF;
      case '已銷單':
        return AppColor.grey_0xFFDDDDDD;
      default:
        return AppColor.textBlack_0xFF333333;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
      decoration: BoxDecoration(
        color: handleBgColor(),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: Text(
        statusType,
        style: TextStyle(
            color: handleTextColor(),
            fontSize: 16
        ),
      ),
    );
  }
}