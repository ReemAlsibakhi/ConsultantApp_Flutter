import 'Mails.dart';

class MailModel {
  MailModel({
    this.mails,
  });

  MailModel.fromJson(dynamic json) {
    mails = json['mails'] != null ? Mails.fromJson(json['mails']) : null;
  }
  Mails? mails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mails != null) {
      map['mails'] = mails!.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'MailModel{mails: $mails}';
  }
}
