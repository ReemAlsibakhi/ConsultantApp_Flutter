import 'package:consultant_app/model/mail/MailData.dart';

class SearchMailModel {
  SearchMailModel({
    this.mails,
  });

  SearchMailModel.fromJson(dynamic json) {
    if (json['mails'] != null) {
      mails = [];
      json['mails'].forEach((v) {
        mails!.add(MailData.fromJson(v));
      });
    }
  }
  List<MailData>? mails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mails != null) {
      map['mails'] = mails!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
