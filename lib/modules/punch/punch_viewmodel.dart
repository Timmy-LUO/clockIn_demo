import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:clock_in_demo/models/news_model.dart';

final punchProvider = StateNotifierProvider.autoDispose<PunchViewModel, PunchState>((ref) => PunchViewModel());

final class PunchViewModel extends StateNotifier<PunchState> {
  PunchViewModel() : super(PunchState.initial()) {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });

    _getNews();
  }

  Timer? _timer;

  void punch({required bool isWork}) {
    state = state.copyWith(isLoading: true, isButtonEnabled: false);
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(
        isLoading: false,
        success: true,
      );

      final DateTime now = DateTime.now();
      if (isWork) {
        state = state.copyWith(clockedIn: _formatTime(now));
      } else {
        state = state.copyWith(clockedOut: _formatTime(now));
      }
    });
    state = state.copyWith(isButtonEnabled: true);
  }

  void resetMsg() {
    state = state.copyWith(message: '');
  }

  void resetSuccess() {
    state = state.copyWith(success: false);
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    state = state.copyWith(
      currentDate: _formatDate(now),
      currentTime: _formatTime(now),
    );
  }

  String _formatDate(DateTime dateTime) {
    final String year = dateTime.year.toString();
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String weekDay = _getWeekDay(dateTime.weekday);

    return '$year 年 $month 月 $day 日 $weekDay';
  }

  String _getWeekDay(int weekday) {
    const weekDays = ['(日)', '(一)', '(二)', '(三)', '(四)', '(五)', '(六)'];
    return weekDays[weekday];
  }

  String _formatTime(DateTime dateTime) {
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final int plusOneSecond = dateTime.second + 1;
    final String second = plusOneSecond.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  /// request demo
  void _getNews() {
    NewsRequestModel().request(
      successCallBack: (data) {
        final model = NewsResponseModel.fromJson(data);
        if (model.total == 0) {
          print('No data');
          return;
        }
        print('Total: ${model.total}');
      },
      errorCallBack: (code, message) {
        print('Error: $code, $message');
      }
    );
  }
}

/// Punch State
final class PunchState {
  final bool isLoading;
  final bool success;
  final String message;
  final String currentDate;
  final String currentTime;
  final String clockedIn;
  final String clockedOut;
  final bool isButtonEnabled;

  PunchState({
    required this.isLoading,
    required this.success,
    required this.message,
    required this.currentDate,
    required this.currentTime,
    required this.clockedIn,
    required this.clockedOut,
    required this.isButtonEnabled,
  });

  PunchState.initial()
    : currentDate = '',
      currentTime = '',
      clockedIn = '',
      clockedOut = '',
      isButtonEnabled = true,
      isLoading = false,
      success = false,
      message = '';

  PunchState copyWith({
    bool? isLoading,
    bool? success,
    String? message,
    String? currentDate,
    String? currentTime,
    String? clockedIn,
    String? clockedOut,
    bool? isButtonEnabled,
  }) {
    return PunchState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      message: message ?? this.message,
      currentDate: currentDate ?? this.currentDate,
      currentTime: currentTime ?? this.currentTime,
      clockedIn: clockedIn ?? this.clockedIn,
      clockedOut: clockedOut ?? this.clockedOut,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}