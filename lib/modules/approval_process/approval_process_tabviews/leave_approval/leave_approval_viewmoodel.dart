import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clock_in_demo/models/all_department_model.dart';
import 'package:clock_in_demo/models/all_employee_model.dart';
import 'package:clock_in_demo/models/all_leave_type_model.dart';
import 'package:clock_in_demo/models/all_status_model.dart';
import 'package:clock_in_demo/models/leave_approval_list_model.dart';

final leaveApprovalProvider = StateNotifierProvider.autoDispose<LeaveApprovalViewModel, LeaveApprovalState>((ref) => LeaveApprovalViewModel());

final class LeaveApprovalViewModel extends StateNotifier<LeaveApprovalState> {
  LeaveApprovalViewModel() : super(LeaveApprovalState.initial()) {
    _getData();
  }

  List<LeaveApprovalListDataItemModel> originalApprovalList = [];

  void _getData() {
    List<AllEmployeeDataModel> newEmployeeList = AllEmployeeResponseModel.mock(10);
    newEmployeeList.insert(0, AllEmployeeDataModel(id: -1, name: '全部員工', employeeCode: '-1'));

    List<AllDepartmentDataModel> newDepartmentList = AllDepartmentResponseModel.mock(10);
    newDepartmentList.insert(0, AllDepartmentDataModel(id: -1, code: '', title: '全部部門', parentId: -1, order: -1, userName: '', updateAt: ''));

    List<AllLeaveTypeDataModel> newLeaveTypeList = AllLeaveTypeResponseModel.mock(10);
    newLeaveTypeList.insert(0, AllLeaveTypeDataModel(id: -1, name: '全部假別'));

    List<AllStatusDataModel> newStatusList = AllStatusResponseModel.mock();
    newStatusList.insert(0, AllStatusDataModel(number: -1, status: '全部狀態'));

    // List<LeaveApprovalListDataItemModel> newApprovalList = LeaveApprovalListDataModel.mock(10);
    originalApprovalList = LeaveApprovalListDataModel.mock(10);

    state = state.copyWith(
        allEmployeeList: newEmployeeList,
        allDepartmentList: newDepartmentList,
        allLeaveTypeList: newLeaveTypeList,
        allStatusList: newStatusList,
        approvalList: originalApprovalList,
    );
  }

  void onKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
    _filterApprovalList();
  }

  void onMonth(String month) {
    state = state.copyWith(month: month);
    _filterApprovalList();
  }

  void onEmployee(String employeeId) {
    if (employeeId == '-1') {
      state = state.copyWith(leaveType: '');
    } else {
      state = state.copyWith(employee: employeeId);
    }
    _filterApprovalList();
  }

  void onDepartment(String department) {
    if (department == '-1') {
      state = state.copyWith(department: '');
    } else {
      state = state.copyWith(department: department);
    }
    _filterApprovalList();
  }

  void onLeaveType(String leaveType) {
    if (leaveType == '-1') {
      state = state.copyWith(leaveType: '');
    } else {
      state = state.copyWith(leaveType: leaveType);
    }
    _filterApprovalList();
  }

  void onStatus(String status) {

    print('status: $status');

    if (status == '-1') {
      state = state.copyWith(status: '');
    } else {
      state = state.copyWith(status: status);
    }
    _filterApprovalList();
  }

  void onType(String type) {
    state = state.copyWith(type: type);
    _filterApprovalList();
  }

  void onClear() {
    state = state.copyWith(
      keyword: '',
      month: '',
      employee: '',
      department: '',
      leaveType: '',
      status: '',
      approvalList: originalApprovalList,
    );
  }

  void _filterApprovalList() {
    List<LeaveApprovalListDataItemModel> filteredList = originalApprovalList;
    if (state.keyword.isNotEmpty) {
      filteredList = filteredList
        .where((model) =>
          model.employee.name.toLowerCase().contains(state.keyword.toLowerCase()) ||
          model.employee.employeeCode.toLowerCase().contains(state.keyword.toLowerCase())
        ).toList();
    }
    if (state.month.isNotEmpty) {
      filteredList = filteredList
        .where((model) =>
          model.startTime.contains(state.month) ||
          model.endTime.contains(state.month)
        ).toList();
    }
    if (state.employee.isNotEmpty) {
      filteredList = filteredList
        .where((model) => model.employee.employeeCode == state.employee)
        .toList();
    }
    if (state.department.isNotEmpty) {
      filteredList = filteredList
        .where((model) => model.departments[0].code == state.department)
        .toList();
    }
    if (state.leaveType.isNotEmpty) {
      filteredList = filteredList
        .where((model) => model.leaveType.name == state.leaveType)
        .toList();
    }
    if (state.status.isNotEmpty) {
      filteredList = filteredList
      .where((model) {
          print('model.status: ${model.status}');
          return model.status.number.toString() == state.status;
      }).toList();
        // .where((model) => model.status == state.status)
        // .toList();
    }
    state = state.copyWith(approvalList: filteredList);
  }
}

/// TODO: Leave Approval State
final class LeaveApprovalState {
  final bool isLoading;
  final bool success;
  final String message;
  final bool isLoadingMore;
  final List<AllEmployeeDataModel> allEmployeeList;
  final List<AllDepartmentDataModel> allDepartmentList;
  final List<AllLeaveTypeDataModel> allLeaveTypeList;
  final List<AllStatusDataModel> allStatusList;
  final String type;
  final String keyword;
  final String month;
  final String employee;
  final String department;
  final String leaveType;
  final String status;
  final List<LeaveApprovalListDataItemModel> approvalList;
  final String appendixFile;

  LeaveApprovalState({
    required this.isLoading,
    required this.success,
    required this.message,
    required this.isLoadingMore,
    required this.allEmployeeList,
    required this.allDepartmentList,
    required this.allLeaveTypeList,
    required this.allStatusList,
    required this.type,
    required this.keyword,
    required this.month,
    required this.employee,
    required this.department,
    required this.leaveType,
    required this.status,
    required this.approvalList,
    required this.appendixFile,
  });

  LeaveApprovalState.initial()
      : isLoading = false,
        success = false,
        message = '',
        isLoadingMore = false,
        allEmployeeList = [],
        allDepartmentList = [],
        allLeaveTypeList = [],
        allStatusList = [],
        type = '待簽核',
        keyword = '',
        month = '',
        employee = '',
        department = '',
        leaveType = '',
        status = '',
        approvalList = [],
        appendixFile = '';

  LeaveApprovalState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? success,
    String? message,
    List<AllEmployeeDataModel>? allEmployeeList,
    List<AllDepartmentDataModel>? allDepartmentList,
    List<AllLeaveTypeDataModel>? allLeaveTypeList,
    List<AllStatusDataModel>? allStatusList,
    String? type,
    String? keyword,
    String? month,
    String? employee,
    String? department,
    String? leaveType,
    String? status,
    List<LeaveApprovalListDataItemModel>? approvalList,
    String? appendixFile,
  }) {
    return LeaveApprovalState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      success: success ?? this.success,
      message: message ?? this.message,
      allEmployeeList: allEmployeeList ?? this.allEmployeeList,
      allDepartmentList: allDepartmentList ?? this.allDepartmentList,
      allLeaveTypeList: allLeaveTypeList ?? this.allLeaveTypeList,
      allStatusList: allStatusList ?? this.allStatusList,
      type: type ?? this.type,
      keyword: keyword ?? this.keyword,
      month: month ?? this.month,
      employee: employee ?? this.employee,
      department: department ?? this.department,
      leaveType: leaveType ?? this.leaveType,
      status: status ?? this.status,
      approvalList: approvalList ?? this.approvalList,
      appendixFile: appendixFile ?? this.appendixFile,
    );
  }
}