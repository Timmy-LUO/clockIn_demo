
/// AllStatus Response Model
final class AllStatusResponseModel {
  final bool success;
  final String msg;
  final List<AllStatusDataModel> dataList;

  AllStatusResponseModel({
    required this.success,
    required this.msg,
    required this.dataList,
  });

  factory AllStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return AllStatusResponseModel(
      success: json['success'],
      msg: json['msg'],
      dataList: List<AllStatusDataModel>.from(json['data'].map((x) => AllStatusDataModel.fromJson(x))),
    );
  }

  static List<AllStatusDataModel> mock() {
    const count = 5;
    List<AllStatusDataModel> list = [];
    for (var i = 0; i < count; i++) {
      list.add(
        AllStatusDataModel(
          status: getRandomString(i),
          number: i,
        )
      );
    }
    return list;
  }

  static String getRandomString(int index) {
    List<String> list = ['通過', '不通過', '中途抽單', '已銷單', '已銷單'];
    return list[index];
  }
}

final class AllStatusDataModel {
  final String status;
  final int number;

  AllStatusDataModel({
    required this.status,
    required this.number,
  });

  factory AllStatusDataModel.fromJson(Map<String, dynamic> json) {
    return AllStatusDataModel(
      status: json['status'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toDropMenuList() {
    return {
      'label': status,
      'value': number.toString(),
    };
  }
}