import 'package:flutter/material.dart';
import 'package:clock_in_demo/Utility/app_color.dart';
import 'package:clock_in_demo/models/ui_models/approval_progress_uimodel.dart';

final class ApprovalProgressView extends StatelessWidget {
  final List<ApprovalProgressUiModel> progressList;

  const ApprovalProgressView({
    super.key,
    required this.progressList,
  });

  Widget handleIcon(int pass) {
    switch (pass) {
      case 1:
        return const Icon(Icons.check_circle, color: AppColor.green_0xFF3D9A51);
      case 2:
        return const Icon(Icons.cancel, color: AppColor.textRed_0xFFE03845);
      default:
        return const Icon(Icons.check_circle, color: AppColor.grey_0xFFDFE0E0);
    }
  }

  Color handleTextColor(int pass) {
    switch (pass) {
      case 1:
        return AppColor.green_0xFF3D9A51;
      case 2:
        return AppColor.textRed_0xFFE03845;
      default:
        return AppColor.textGrey_0xFF6B6C71;
    }
  }

  String handleStaffStr(List<String> staffList) {
    var handledStr = '';
    for (var staff in staffList) {
      handledStr += '$staff\n';
    }
    if (handledStr.endsWith('\n')) {
      handledStr = handledStr.substring(0, handledStr.length - 1);
    }
    return handledStr;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...progressList.asMap().entries.map((entry) {

          int index = entry.key;
          var item = entry.value;
          bool isLast = index == (progressList.length - 1);

          return Row(
            children: [
              Column(
                children: [
                  handleIcon(item.pass),
                  Text(
                    item.status,
                    style: TextStyle(
                        color: handleTextColor(item.pass)
                    ),
                  ),
                  Text(handleStaffStr(item.staff)),
                  if (item.time != '')
                    Text(item.time),
                  if (item.description != '')
                    Text('原因: ${item.description}'),
                ],
              ),
              if (!isLast)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10), // 線條左右的間距
                  width: 50,
                  height: 2,
                  color: AppColor.grey_0xFFDFE0E0,
                ),
            ],
          );
        }),
      ],
    );
  }
}