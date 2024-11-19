import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class MissedPunchApprovalView extends ConsumerStatefulWidget {
  const MissedPunchApprovalView({super.key});

  @override
  ConsumerState<MissedPunchApprovalView> createState() => _MissedPunchApprovalViewState();
}

final class _MissedPunchApprovalViewState extends ConsumerState<MissedPunchApprovalView> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('補打卡簽核'),
      ),
    );
  }
}