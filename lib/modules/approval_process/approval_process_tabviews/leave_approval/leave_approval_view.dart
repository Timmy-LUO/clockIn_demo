import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clock_in_demo/utility/app_color.dart';
import 'package:clock_in_demo/widgets/icon_textbutton.dart';
import 'package:clock_in_demo/widgets/bottom_sheet_utils.dart';
import 'package:clock_in_demo/widgets/drop_menu_widget.dart';
import 'package:clock_in_demo/widgets/toggle_switch_widget.dart';
import 'package:clock_in_demo/widgets/Info_view.dart';
import 'package:clock_in_demo/widgets/fill_color_button.dart';
import 'package:clock_in_demo/widgets/rounded_textview.dart';
import 'package:clock_in_demo/widgets/approval_progress_view.dart';
import 'package:clock_in_demo/utility/extensions.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:clock_in_demo/models/leave_approval_list_model.dart';
import 'package:clock_in_demo/modules/approval_process/approval_process_tabviews/leave_approval/leave_approval_viewmoodel.dart';

final class LeaveApprovalView extends ConsumerStatefulWidget {
  const LeaveApprovalView({super.key});

  @override
  ConsumerState<LeaveApprovalView> createState() => _LeaveApprovalViewState();
}

final class _LeaveApprovalViewState extends ConsumerState<LeaveApprovalView> {

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(leaveApprovalProvider);
    final notifier = ref.read(leaveApprovalProvider.notifier);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const LeaveApprovalProcessView(),
        ),

        if (state.isLoading)
          Container(
              color: Colors.black54.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator())
          ),
      ],
    );
  }
}

final class LeaveApprovalProcessView extends ConsumerStatefulWidget {

  const LeaveApprovalProcessView({super.key});

  @override
  ConsumerState<LeaveApprovalProcessView> createState() => _LeaveApprovalProcessViewState();
}

final class _LeaveApprovalProcessViewState extends ConsumerState<LeaveApprovalProcessView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(leaveApprovalProvider);
    final notifier = ref.read(leaveApprovalProvider.notifier);

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    IconTextButton(
                      text: (state.keyword != '') ? '關鍵字: ${state.keyword}' : '關鍵字',
                      fontSize: 20,
                      onPressed: () {
                        BottomSheetUtils(context).showSearchKeyword(
                          '搜尋關鍵字',
                          (onKeyword) {
                            notifier.onKeyword(onKeyword);
                          });
                      },
                    ),
                    IconTextButton(
                      text: (state.month != '') ? state.month : '選擇月份',
                      fontSize: 20,
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          initialDate: DateTime.now(),
                        ).then((date) {
                          if (date != null) {
                            notifier.onMonth(date.to('yyyy-MM'));
                          }
                        });
                      },
                    ),
                    DropMenuWidget(
                      dataList: state.allEmployeeList
                          .map((item) => item.toDropMenuList())
                          .toList(),
                      selectCallBack: (value) {
                        notifier.onEmployee(value);
                      },
                      offset: const Offset(0, 40),
                      selectedValue: '-1',
                    ),
                    DropMenuWidget(
                      dataList: state.allDepartmentList
                          .map((item) => item.toDropMenuList())
                          .toList(),
                      selectCallBack: (value) {
                        notifier.onDepartment(value);
                      },
                      offset: const Offset(0, 40),
                      selectedValue: '-1',
                    ),
                    DropMenuWidget(
                      dataList: state.allLeaveTypeList
                          .map((item) => item.toDropMenuList())
                          .toList(),
                      selectCallBack: (value) {
                        notifier.onLeaveType(value);
                      },
                      offset: const Offset(0, 40),
                      selectedValue: '-1',
                    ),
                    DropMenuWidget(
                      dataList: state.allStatusList
                          .map((item) => item.toDropMenuList())
                          .toList(),
                      selectCallBack: (value) {
                        notifier.onStatus(value);
                      },
                      offset: const Offset(0, 40),
                      selectedValue: '-1',
                    ),
                    (state.keyword != '' ||
                     state.month != '' ||
                     state.employee != '' ||
                     state.department != '' ||
                     state.leaveType != '' ||
                     state.status != '')
                        ? TextButton(
                          onPressed: () {
                            notifier.onClear();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            minimumSize: const Size(0, 40),
                          ),
                          child: const Text(
                            '清除條件',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                        : Container(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ToggleSwitch(
                    minWidth: 80,
                    cornerRadius: 20,
                    activeBgColors: [
                      [Colors.red[800]!],
                      [Colors.green[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    radiusStyle: true,
                    onToggle: (index) {
                      if (index == 0) {
                        notifier.onType('待簽核');
                      } else {
                        notifier.onType('已簽核');
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    (state.type == '待簽核') ? '待簽核' : '已簽核',
                    style: TextStyle(
                      fontSize: 20,
                      color: (state.type == '待簽核') ? Colors.red[800]
                          : Colors.green[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.approvalList.length,
                itemBuilder: (context, index) {
                  return LeaveApprovalCardView(
                    type: state.type,
                    approvalModel: state.approvalList[index],
                  );
                },
              ),
            ],
          ),
        ),
        if (state.approvalList.length > 4)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.publish),
            ),
          ),
      ],
    );
  }
}

/// TODO: LeaveApproval Card View
final class LeaveApprovalCardView extends ConsumerWidget {
  final String type;
  final LeaveApprovalListDataItemModel approvalModel;

  const LeaveApprovalCardView({
    super.key,
    required this.type,
    required this.approvalModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextView(statusType: approvalModel.status.status),
            const SizedBox(height: 10),
            Row(
              children: [
                FillColorButton(
                  text: (type == '待簽核') ? '通過' : '重簽',
                  textColor: (type == '待簽核') ? AppColor.white_0xFFFFFFFF : AppColor.textBlue_0xFF0072E3,
                  backgroundColor: (type == '待簽核') ? AppColor.green_0xFF3D9A51 : null,
                  borderColor: (type == '待簽核') ? null : AppColor.textBlue_0xFF0072E3,
                  onTap: () {
                    if (type == '待簽核') {
                      // showAlertDialog(
                      //   context: context,
                      //   title: context.i18n.approval_passed,
                      //   content: context.i18n.approval_enter_reason,
                      //   showCancelButton: true,
                      //   showTextField: true,
                      //   onConfirmWithText: (text) {
                      //     notifier.onReviewLeave(
                      //       id: approvalModel.id,
                      //       approve: true,
                      //       description: (text.isNotEmpty) ? text : null,
                      //     );
                      //   },
                      // );
                    } else {
                      // showAlertDialog(
                      //   context: context,
                      //   title: context.i18n.approval_sure_re_sign,
                      //   content: context.i18n.approval_back_pending,
                      //   showCancelButton: true,
                      //   onConfirm: () {
                      //     notifier.onReverseReviewLeave(approvalModel.id);
                      //   },
                      // );
                    }
                  },
                ),
                const SizedBox(width: 8),
                if (type == '待簽核')
                  FillColorButton(
                    text: '不通過',
                    textColor: AppColor.textRed_0xFFE03845,
                    backgroundColor: null,
                    borderColor: AppColor.textRed_0xFFE03845,
                    onTap: () {
                      // showAlertDialog(
                      //   context: context,
                      //   title: context.i18n.approval_no_passed,
                      //   content: context.i18n.approval_enter_reason,
                      //   showCancelButton: true,
                      //   showTextField: true,
                      //   onConfirmWithText: (text) {
                      //     notifier.onReviewLeave(
                      //       id: approvalModel.id,
                      //       approve: false,
                      //       description: text,
                      //     );
                      //   },
                      // );
                    },
                  )
              ],
            ),
            const SizedBox(height: 10),
            InfoView(title: '員工', content: '${approvalModel.employee.employeeCode} ${approvalModel.employee.name}'),
            InfoView(title: '假別', content: approvalModel.leaveType.name),
            InfoView(title: '總時數', content: approvalModel.hours.toString()),
            InfoView(title: '開始時間', content: approvalModel.startTime),
            InfoView(title: '結束時間', content: approvalModel.endTime),
            InfoView(title: '事由', content: approvalModel.description),

            Container(
              padding: const EdgeInsets.all(0),
              child: ExpandablePanel(
                header: const Text(''),
                collapsed: Container(),
                expanded: Column(
                  children: [
                    InfoView(title: '單據號碼', content: approvalModel.applicationCode),
                    InfoView(title: '部門', content: approvalModel.departments.map((item) => '[${item.code}]${item.title}').join(', ')),
                    InfoView(title: '申請時間', content: approvalModel.applyTime),
                    InfoView(
                      title: '附件',
                      trailingWidget: Transform.scale(
                        scale: 0.8,
                        child: GestureDetector(
                            onTap: () {
                              if (approvalModel.appendix != null) {
                                // notifier.getAppendixFile(
                                //   path: approvalModel.appendix?.path ?? '',
                                //   filename: approvalModel.appendix?.name ?? '',
                                // );
                              }
                            },
                            child: Text(
                              (approvalModel.appendix == null) ? ''
                                  : approvalModel.appendix?.name ?? '',
                              style: const TextStyle(
                                  color: AppColor.textBlue_0xFF4470B1,
                                  fontSize: 20
                              ),
                            )
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ApprovalProgressView(
                            progressList: approvalModel.progress
                                .map((item) => item.toUiModel())
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(
                      crossFadePoint: 0,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
