import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  bool isAddBorder = false,
  TextAlign titleTextAlign = TextAlign.start,
  required String title,
  Color titleColor = Colors.black,
  double titleSize = 20,
  TextAlign contentTextAlign = TextAlign.start,
  FontWeight titleFontWeight = FontWeight.normal,
  required String content,
  Color contentColor = Colors.black,
  double contentSize = 15,
  String confirmButtonText = "確認",
  VoidCallback? onConfirm,
  Function(String)? onConfirmWithText,
  bool showCancelButton = false,
  String cancelButtonText = "取消",
  VoidCallback? onCancel,
  bool showTextField = false,
}) {
  final TextEditingController controller = TextEditingController();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: titleTextAlign,
          style: TextStyle(
              color: titleColor,
              fontSize: titleSize,
              fontWeight: titleFontWeight
          ),
        ),
        shape: (isAddBorder)
            ? const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(
            color: Colors.red, // 设置边框颜色
            width: 5, // 设置边框宽度
          ),
        )
            : null,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                content,
                textAlign: contentTextAlign,
                style: TextStyle(color: contentColor, fontSize: contentSize),
              ),
              const SizedBox(height: 20),
              if (showTextField)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          (!showCancelButton) ? Container()
              : TextButton(
            child: Text(
              cancelButtonText,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) {
                onCancel();
              }
            },
          ),
          TextButton(
            child: Text(
              confirmButtonText,
              style: const TextStyle(color: Color(0xFF2F2D6C), fontSize: 18),
            ),
            onPressed: () {
              if (onConfirmWithText != null) {
                if (title != '通過' && controller.text.isEmpty) { return; }
                Navigator.of(context).pop();
                onConfirmWithText(controller.text);
                return;
              }
              Navigator.of(context).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
          ),
        ],
      );
    },
  );
}