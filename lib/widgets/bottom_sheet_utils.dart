import 'package:flutter/material.dart';
import 'package:clock_in_demo/widgets/alert_dialog.dart';
import 'package:clock_in_demo/Utility/app_color.dart';
import 'package:clock_in_demo/widgets/calendar_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final class BottomSheetUtils {
  final BuildContext context;

  BottomSheetUtils(this.context);

  void _showDialog(String content) {
    showAlertDialog(
        context: context,
        title: '通知',
        content: content
    );
  }

  void showSelectLocale(
      String title,
      Function(Locale) onLocale,
  ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onLocale(const Locale('zh'));
                      },
                      child: const Text('中文'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onLocale(const Locale('en'));
                      },
                      child: const Text('English'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onLocale(const Locale('vi'));
                      },
                      child: const Text('Tiếng Việt'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void showSearchKeyword(
    String title,
    Function(String) onKeyword,
  ) {
    TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: '搜尋',
                      suffixIcon: (searchController.text.isEmpty) ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () { searchController.clear(); },
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                  SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            if (searchController.text.isNotEmpty) {
                              onKeyword(searchController.text);
                              Navigator.pop(context);
                            } else {
                              _showDialog('請輸入關鍵字');
                            }
                          },
                          child: const Text(
                              '確認',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.black_0xFF000000
                              )
                          )
                      )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void showCalendar(
    String title,
    Function(DateTime, DateTime) onDateRange
  ) {
    DateTime? startDate;
    DateTime? endDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  Calendar(onSelectedDateRange: (start, end) {
                    if (start != null && end != null) {
                      startDate = start;
                      endDate = end;
                    }
                  }),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (startDate != null && endDate != null) {
                            onDateRange(startDate!, endDate!);
                            Navigator.pop(context);
                          } else {
                            _showDialog('請選擇一個日期區間');
                          }
                        },
                        child: const Text(
                            '確認',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColor.black_0xFF000000
                            )
                        )
                    )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Future<void> _pickImage(Function(File) onImageFile) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImageFile(File(image.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> _pickFile(Function(File) onPickFile) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result != null) {
      onPickFile(File(result.files.single.path!));
    } else {
      print('No file selected.');
    }
  }

  void showUseAppendix(Function(File) onAppendix) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: const Icon(Icons.attach_file, size: 50),
                      onPressed: () {
                        _pickFile((onFile) {
                          onAppendix(onFile);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: const Icon(Icons.image_outlined, size: 50),
                      onPressed: () {
                        _pickImage((onFile) {
                          onAppendix(onFile);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}