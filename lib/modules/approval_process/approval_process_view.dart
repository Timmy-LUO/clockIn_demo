import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clock_in_demo/utility/app_color.dart';
import 'package:clock_in_demo/modules/approval_process/approval_process_tabviews/leave_approval/leave_approval_view.dart';
import 'package:clock_in_demo/modules/approval_process/approval_process_tabviews/missed_punch_approval/missed_punch_approval_view.dart';
import 'package:clock_in_demo/modules/approval_process/approval_process_tabviews/overtime_approval/overtime_approval_view.dart';

final class ApprovalProcessView extends ConsumerStatefulWidget {
  const ApprovalProcessView({super.key});

  @override
  ConsumerState<ApprovalProcessView> createState() => _ApprovalProcessViewState();
}

final class _ApprovalProcessViewState
    extends ConsumerState<ApprovalProcessView>
    with SingleTickerProviderStateMixin
{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '簽核作業',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: AppColor.white_0xFFFFFFFF,
                    child: TabBar(
                      isScrollable: false,
                      controller: _tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      tabs: [
                        Tab(
                          child: Stack(
                            children: [
                              const Center(child: Text('請假簽核')),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: _buildNotificationBadge(99),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Stack(
                            children: [
                              const Center(child: Text('補打卡簽核')),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: _buildNotificationBadge(999),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Stack(
                            children: [
                              const Center(child: Text('加班簽核')),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: _buildNotificationBadge(1000),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: const [
                        LeaveApprovalView(),
                        MissedPunchApprovalView(),
                        OvertimeApprovalView(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      )
    );
  }

  /// TODO: Methods
  Widget _buildNotificationBadge(int count) {
    bool isLarge = count > 9;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(isLarge ? 12 : 8),
      ),
      child: Center(
        child: (count == 0) ? null
          : Text(
              (count > 999) ? '999+' : count.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12
              ),
            ),
      ),
    );
  }
}