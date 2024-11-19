import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class OvertimeApprovalView extends ConsumerStatefulWidget {
  const OvertimeApprovalView({super.key});

  @override
  ConsumerState<OvertimeApprovalView> createState() => _OvertimeApprovalViewState();
}

final class _OvertimeApprovalViewState extends ConsumerState<OvertimeApprovalView> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('加班簽核'),
      ),
    );
  }
}