/// All Leave Type Response Model
final class AllLeaveTypeResponseModel {
  final bool success;
  final String msg;
  final List<AllLeaveTypeDataModel> dataList;

  AllLeaveTypeResponseModel({
    required this.success,
    required this.msg,
    required this.dataList,
  });

  factory AllLeaveTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return AllLeaveTypeResponseModel(
      success: json['success'],
      msg: json['msg'],
      dataList: List<AllLeaveTypeDataModel>.from(json['data'].map((x) => AllLeaveTypeDataModel.fromJson(x))),
    );
  }

  static List<AllLeaveTypeDataModel> mock(int count) {
    return List.generate(
      count,
      (index) => AllLeaveTypeDataModel(
        id: index,
        name: 'Leave Type $index',
      )
    );
  }
}

final class AllLeaveTypeDataModel {
  final int id;
  final String name;

  AllLeaveTypeDataModel({
    required this.id,
    required this.name,
  });

  factory AllLeaveTypeDataModel.fromJson(Map<String, dynamic> json) {
    return AllLeaveTypeDataModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toDropMenuList() {
    return {
      'label': name,
      'value': id.toString(),
    };
  }
}