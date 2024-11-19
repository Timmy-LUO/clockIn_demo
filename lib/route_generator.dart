import 'package:flutter/material.dart';
import 'package:clock_in_demo/modules/punch/punch_view.dart';
import 'package:clock_in_demo/modules/approval_process/approval_process_view.dart';

final class RoutePaths {
  static const String punch = '/';
  static const String approvalProcess = '/approvalProcess';
}

final class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.punch:
        return MaterialPageRoute(builder: (_) => const PunchView());

      case RoutePaths.approvalProcess:
        return MaterialPageRoute(builder: (_) => const ApprovalProcessView());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}