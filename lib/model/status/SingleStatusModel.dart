import 'StatusMail.dart';

class SingleStatusModel {
  SingleStatusModel({
    this.status,
  });

  SingleStatusModel.fromJson(dynamic json) {
    status =
        json['status'] != null ? StatusMail.fromJson(json['status']) : null;
  }
  StatusMail? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (status != null) {
      map['status'] = status!.toJson();
    }
    return map;
  }
}
