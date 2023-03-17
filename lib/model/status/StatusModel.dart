import 'StatusMail.dart';

class StatusModel {
  StatusModel({
    this.status,
  });

  StatusModel.fromJson(dynamic json) {
    if (json['statuses'] != null) {
      status = [];
      json['statuses'].forEach((v) {
        status!.add(StatusMail.fromJson(v));
      });
    }
  }
  List<StatusMail>? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (status != null) {
      map['statuses'] = status!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'StatusModel{status: $status}';
  }
}
