/// Approval Progress UiModel
final class ApprovalProgressUiModel {
  final String status;
  final List<String> staff;
  final String time;
  final String description;
  final int pass; /// 顯示狀態(0:無 1:勾 2:叉)

  ApprovalProgressUiModel({
    required this.status,
    required this.staff,
    required this.time,
    required this.description,
    required this.pass,
  });
}

/// Approval Progress Confirm UiModel
final class ApprovalProgressConfirmUiModel {
  final int status;
  final String name;
  final String time;

  ApprovalProgressConfirmUiModel({
    required this.status,
    required this.name,
    required this.time,
  });
}