import 'package:flutter/material.dart';
import 'package:clock_in_demo/Utility/app_color.dart';

final class InfoView extends StatelessWidget {
  final String title;
  final String? content;
  final double? textSize;
  final Widget? trailingWidget;
  final Widget? trailingIcon;
  final bool isBottom;

  const InfoView({
    super.key,
    required this.title,
    this.content,
    this.textSize,
    this.trailingWidget,
    this.trailingIcon,
    this.isBottom = false
  });

  @override
  Widget build(BuildContext context) {
    return (!isBottom)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: (textSize != null) ? textSize : 18,
                  color: AppColor.textGrey_0xFF6B6C71
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: (trailingWidget != null)
                  ? trailingWidget!
                  : Text(
                      content ?? '',
                      style: TextStyle(
                          fontSize: (textSize != null) ? textSize : 18,
                          color: AppColor.textBlack_0xFF333333
                      ),
                    ),
              ),
              (trailingIcon != null)
                ? trailingIcon!
                : Container(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: (textSize != null) ? textSize : 18,
                  color: AppColor.textGrey_0xFF6B6C71
                ),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 15),
                child: Text(
                  content ?? '',
                  style: TextStyle(
                    fontSize: (textSize != null) ? textSize : 18,
                    color: AppColor.textBlack_0xFF333333
                  ),
                ),
              ),
            ],
          );
  }
}