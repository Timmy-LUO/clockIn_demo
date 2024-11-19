import 'package:flutter/material.dart';
import 'package:clock_in_demo/utility/app_color.dart';

final class PunchButton extends StatelessWidget {
  final String title;
  final String time;
  final bool isClockedIn;
  final VoidCallback? onPressed;

  const PunchButton({
    super.key,
    required this.title,
    required this.time,
    required this.isClockedIn,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 180,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              (isClockedIn) ? AppColor.grey_0xFFDDDDDD : AppColor.yellow_0xFFFAE145
          ),
          foregroundColor: WidgetStateProperty.all(Colors.black),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // 去掉圆角
            ),
          ),
          side: WidgetStateProperty.all(BorderSide.none),
        ),
        child: Center(
          child: (isClockedIn)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: AppColor.black_0xFF000000, fontSize: 25),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: AppColor.black_0xFF000000, fontSize: 25),
                  ),
                ],
              )
            : Center(
                child: Text(
                  title,
                  style: const TextStyle(color: AppColor.black_0xFF000000, fontSize: 25),
                ),
              )
        ),
      )
    );
  }
}