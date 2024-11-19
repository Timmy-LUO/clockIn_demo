/// All Department Response Model
final class AllDepartmentResponseModel {
  final bool success;
  final String msg;
  final List<AllDepartmentDataModel> dataList;

  AllDepartmentResponseModel({
    required this.success,
    required this.msg,
    required this.dataList,
  });

  factory AllDepartmentResponseModel.fromJson(Map<String, dynamic> json) {
    return AllDepartmentResponseModel(
      success: json['success'],
      msg: json['msg'],
      dataList: List<AllDepartmentDataModel>
          .from(json['data'].map((x) => AllDepartmentDataModel.fromJson(x))),
    );
  }

  static List<AllDepartmentDataModel> mock(int count) {
    return List.generate(
      count,
      (index) => AllDepartmentDataModel(
        id: index,
        code: '${index + 1}',
        title: '部門 $index',
        parentId: -1,
        order: index,
        userName: 'userName $index',
        updateAt: 'updateAt $index',
      )
    );
  }
}

final class AllDepartmentDataModel {
  final int id;
  final String code;
  final String title;
  final int parentId;
  final int order;
  final String userName;
  final String updateAt;

  AllDepartmentDataModel({
    required this.id,
    required this.code,
    required this.title,
    required this.parentId,
    required this.order,
    required this.userName,
    required this.updateAt,
  });

  factory AllDepartmentDataModel.fromJson(Map<String, dynamic> json) {
    return AllDepartmentDataModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      parentId: json['parent_id'],
      order: json['order'],
      userName: json['user_name'],
      updateAt: json['update_at'],
    );
  }

  Map<String, dynamic> toDropMenuList() {
    return {
      'label': (id != -1) ? '[$code]$title' : '全部部門',
      'value': id.toString(),
    };
  }
}