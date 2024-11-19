/// AllEmployee Response Model
final class AllEmployeeResponseModel {
  final bool success;
  final String msg;
  final List<AllEmployeeDataModel> dataList;

  AllEmployeeResponseModel({
    required this.success,
    required this.msg,
    required this.dataList,
  });

  factory AllEmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    return AllEmployeeResponseModel(
      success: json['success'],
      msg: json['msg'],
      dataList: List<AllEmployeeDataModel>.from(json['data'].map((x) => AllEmployeeDataModel.fromJson(x))),
    );
  }

  static List<AllEmployeeDataModel> mock(int count) {
    return List.generate(
      count,
      (index) => AllEmployeeDataModel(
        id: index,
        name: 'Employee$index',
        employeeCode: 'E${1000 + index}',
      )
    );
  }
}

final class AllEmployeeDataModel {
  final int id;
  final String name;
  final String employeeCode;

  AllEmployeeDataModel({
    required this.id,
    required this.name,
    required this.employeeCode,
  });

  factory AllEmployeeDataModel.fromJson(Map<String, dynamic> json) {
    return AllEmployeeDataModel(
      id: json['id'],
      name: json['name'],
      employeeCode: (json['employee_code'] == null) ? null : json['employee_code'],
    );
  }

  Map<String, dynamic> toDropMenuList() {
    return {
      'label': name,
      'value': employeeCode,
    };
  }
}