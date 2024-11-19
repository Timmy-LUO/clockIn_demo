import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

final class Calendar extends StatefulWidget {
  final bool useButtonOpen;
  final String? title;
  final Function(DateTime?, DateTime?) onSelectedDateRange;

  const Calendar({
    super.key,
    this.useButtonOpen = false,
    this.title,
    required this.onSelectedDateRange,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

final class _CalendarState extends State<Calendar> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  DateTime _focusedDay = DateTime.now();
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  Future<void> _selectDateTime(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      // locale: const Locale('zh', 'TW'),
    );
    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
        widget.onSelectedDateRange(_selectedStartDate, null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useButtonOpen) {
      return ElevatedButton(
          onPressed: () => _selectDateTime(context),
          child: Text(widget.title ?? '')
      );
    } else {
      return Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: _focusedDay,
            locale: 'zh_TW',
            // calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedStartDate, day) ||
                  isSameDay(_selectedEndDate, day);
            },
            rangeStartDay: _selectedStartDate,
            rangeEndDay: _selectedEndDate,
            // onDaySelected: _onDaySelected,
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedStartDate = start;
                _selectedEndDate = end;
                _focusedDay = focusedDay;
                widget.onSelectedDateRange(_selectedStartDate, _selectedEndDate);
              });
            },
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
          ),
          if (_selectedStartDate != null && _selectedEndDate != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '選擇的時段: ${DateFormat('yyyy/MM/dd').format(_selectedStartDate!)} - ${DateFormat('yyyy/MM/dd').format(_selectedEndDate!)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      );
    }
  }
}