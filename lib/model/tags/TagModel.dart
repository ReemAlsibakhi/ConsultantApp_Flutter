import 'package:consultant_app/model/mail/MailData.dart';

class TagModel {
  TagModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.mails,
  });

  TagModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['mails'] != null) {
      mails = [];
      json['mails'].forEach((v) {
        mails!.add(MailData.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<MailData>? mails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (mails != null) {
      map['mails'] = mails!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
