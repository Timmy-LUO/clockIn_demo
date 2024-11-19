import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension JsonObjectExtensions on Object {
  dynamic get jsonEncode => json.encode(this);
}

extension DateTimeExtensions on DateTime {
  DateTime get firstDayOfMonth {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  DateTime get lastDayOfMonth {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0);
  }

  String to(String dateFormat) {
    DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }
}

extension StringToInt on String {

  dynamic get jsonDecode => json.decode(this);

  String toSnakeCase() => replaceAll('.', '_');

  int? toInt() {
    if (int.tryParse(this) != null) {
      return int.parse(this);
    }
    return null;
  }

  String toFormattedString(String dateFormat) {
    DateTime dateTime = DateTime.parse(this);
    String formattedDate = DateFormat(dateFormat).format(dateTime);
    return formattedDate;
  }
}

extension DoubleExtension on double {
  String toFormatStr() {
    int wholeHours = floor();
    int minutes = ((this - wholeHours) * 60).round();
    return '總時數 $wholeHours 小時 $minutes 分鐘';
  }
}

extension StringListExtension on List<String> {
  String joinWithNewLine() {
    String result = '';
    for (int i = 0; i < length; i++) {
      result += this[i];
      if (i != length - 1) {
        result += ', \n';
      }
    }
    return result;
  }
}