import 'package:clock_in_demo/models/ui_models/approval_progress_uimodel.dart';
import 'dart:math';

/// Approval Status List Response Model
final class LeaveApprovalListResponseModel {
  final bool success;
  final String msg;
  final LeaveApprovalListDataModel data;

  LeaveApprovalListResponseModel({
    required this.success,
    required this.msg,
    required this.data,
  });

  factory LeaveApprovalListResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListResponseModel(
      success: json['success'],
      msg: json['msg'],
      data: LeaveApprovalListDataModel.fromJson(json['data']),
    );
  }
}

final class LeaveApprovalListDataModel {
  final List<LeaveApprovalListDataItemModel> dataList;
  final int total;
  final int lastPage;
  final int currentPage;

  LeaveApprovalListDataModel({
    required this.dataList,
    required this.total,
    required this.lastPage,
    required this.currentPage,
  });

  factory LeaveApprovalListDataModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataModel(
      dataList: List<LeaveApprovalListDataItemModel>
          .from(json['data']
          .map((i) => LeaveApprovalListDataItemModel.fromJson(i))),
      total: json['total'],
      lastPage: json['last_page'],
      currentPage: json['current_page'],
    );
  }

  static List<LeaveApprovalListDataItemModel> mock(int count) {
    return List.generate(count, (index) {
      return LeaveApprovalListDataItemModel(
        id: index + 1,
        applicationCode: 'APP-${index + 1}',
        status: LeaveApprovalListDataStatusModel(
          status: getRandomString(),
          number: index,
        ),
        employee: LeaveApprovalListDataEmployeeModel(
          name: 'Employee $index',
          employeeCode: 'E${1000 + index}',
        ),
        departments: [
          LeaveApprovalListDataDepartmentsModel(
            id: index,
            code: '${index + 1}',
            title: '部門 $index',
          )
        ],
        leaveType: LeaveApprovalListDataLeaveTypeModel(
          name: 'Leave Type $index',
        ),
        startTime: '2024-11-01 09:00',
        endTime: '2024-11-01 18:00',
        hours: 8,
        description: 'Leave description for request $index',
        appendix: LeaveApprovalListDataAppendixModel(
          id: index,
          name: 'Appendix $index',
          path: '/path/to/appendix/$index',
        ),
        applyTime: '2024-10-31 08:00',
        allowReversReviewStatus: index % 2 == 0,
        warningMsg: index % 2 == 0 ? 'Warning message $index' : '',
        warningStatus: index % 2 == 0,
        progress: LeaveApprovalListDataItemModel.generateRandomProgressData(8),
      );
    });
  }

  static String getRandomString() {
    List<String> list = ['通過', '不通過', '中途抽單', '已銷單', '已銷單'];
    final random = Random();
    final index = random.nextInt(list.length);
    return list[index];
  }
}

final class LeaveApprovalListDataItemModel {
  final int id;
  final String? applicationCode;
  final LeaveApprovalListDataStatusModel status;
  final LeaveApprovalListDataEmployeeModel employee;
  final List<LeaveApprovalListDataDepartmentsModel> departments;
  final LeaveApprovalListDataLeaveTypeModel leaveType;
  final String startTime;
  final String endTime;
  final dynamic hours;
  final String description;
  final LeaveApprovalListDataAppendixModel? appendix;
  final String applyTime;
  final bool allowReversReviewStatus; /// 是否可重簽核
  final String warningMsg;
  final bool warningStatus;
  final List<LeaveApprovalListDataProgressModel> progress;

  LeaveApprovalListDataItemModel({
    required this.id,
    required this.applicationCode,
    required this.status,
    required this.employee,
    required this.departments,
    required this.leaveType,
    required this.startTime,
    required this.endTime,
    required this.hours,
    required this.description,
    required this.appendix,
    required this.applyTime,
    required this.allowReversReviewStatus,
    required this.warningMsg,
    required this.warningStatus,
    required this.progress,
  });

  factory LeaveApprovalListDataItemModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataItemModel(
      id: json['id'],
      applicationCode:(json['application_code'] != null) ? json['application_code'] : null,
      status: json['status'],
      employee: LeaveApprovalListDataEmployeeModel.fromJson(json['employee']),
      departments: List<LeaveApprovalListDataDepartmentsModel>.from(json['departments'].map((i) => LeaveApprovalListDataDepartmentsModel.fromJson(i))),
      leaveType: LeaveApprovalListDataLeaveTypeModel.fromJson(json['leave_type']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      hours: (json['hours'] is double) ? json['hours'].toDouble() : json['hours'],
      description: json['description'],
      appendix: (json['appendix'] != null) ? LeaveApprovalListDataAppendixModel.fromJson(json['appendix']) : null,
      applyTime: json['apply_time'],
      allowReversReviewStatus: json['allow_revers_review_status'],
      warningMsg: (json['warning_msg'] != null) ? json['warning_msg'] : '',
      warningStatus: json['warning_status'],
      progress: List<LeaveApprovalListDataProgressModel>.from(json['progress'].map((i) => LeaveApprovalListDataProgressModel.fromJson(i))),
    );
  }

  static List<LeaveApprovalListDataProgressModel> generateRandomProgressData(int maxCount) {
    final random = Random();
    final count = random.nextInt(maxCount) + 1;
    return List.generate(count, (index) {
      return LeaveApprovalListDataProgressModel(
        status: random.nextBool() ? 'Approved' : 'Rejected',
        staff: List.generate(
          random.nextInt(3) + 1,
              (i) => 'Staff ${index * 10 + i + 1}',
        ),
        time: '2024-11-${random.nextInt(30) + 1} ${random.nextInt(24).toString().padLeft(2, '0')}:${(random.nextInt(60)).toString().padLeft(2, '0')}',
        description: 'Progress description for step ${index + 1}',
        pass: random.nextInt(3),
      );
    });
  }
}

final class LeaveApprovalListDataStatusModel {
  final String status;
  final int number;

  LeaveApprovalListDataStatusModel({
    required this.status,
    required this.number,
  });

  factory LeaveApprovalListDataStatusModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataStatusModel(
      status: json['status'],
      number: json['number'],
    );
  }

  // Map<String, dynamic> toDropMenuList() {
  //   return {
  //     'label': status,
  //     'value': number.toString(),
  //   };
  // }
}

final class LeaveApprovalListDataEmployeeModel {
  final String name;
  final String employeeCode;

  LeaveApprovalListDataEmployeeModel({
    required this.name,
    required this.employeeCode,
  });

  factory LeaveApprovalListDataEmployeeModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataEmployeeModel(
      name: json['name'],
      employeeCode: json['employee_code'],
    );
  }
}

final class LeaveApprovalListDataDepartmentsModel {
  final int id;
  final String code;
  final String title;

  LeaveApprovalListDataDepartmentsModel({
    required this.id,
    required this.code,
    required this.title,
  });

  factory LeaveApprovalListDataDepartmentsModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataDepartmentsModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
    );
  }
}

final class LeaveApprovalListDataLeaveTypeModel {
  final String name;

  LeaveApprovalListDataLeaveTypeModel({
    required this.name,
  });

  factory LeaveApprovalListDataLeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataLeaveTypeModel(
      name: json['name'],
    );
  }
}

final class LeaveApprovalListDataAppendixModel {
  final int? id;
  final String? name;
  final String? path;

  LeaveApprovalListDataAppendixModel({
    required this.id,
    required this.name,
    required this.path,
  });

  factory LeaveApprovalListDataAppendixModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataAppendixModel(
      id: (json['id'] != null) ? json['id'] : null,
      name: (json['name'] != null) ? json['name'] : null,
      path: (json['path'] != null) ? json['path'] : null,
    );
  }
}

final class LeaveApprovalListDataProgressModel {
  final String status;
  final List<String> staff;
  final String time;
  final String description;
  final int pass; /// 顯示狀態(0:無 1:勾 2:叉)

  LeaveApprovalListDataProgressModel({
    required this.status,
    required this.staff,
    required this.time,
    required this.description,
    required this.pass,
  });

  factory LeaveApprovalListDataProgressModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalListDataProgressModel(
      status: json['status'],
      staff: List<String>.from(json['staff']),
      time: json['time'],
      description: (json['description'] != null) ? json['description'] : '',
      pass: json['pass'],
    );
  }

  ApprovalProgressUiModel toUiModel() {
    return ApprovalProgressUiModel(
      status: status,
      staff: staff,
      time: time,
      description: description,
      pass: pass,
    );
  }
}