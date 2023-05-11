import 'package:consultant_app/model/mail/MailData.dart';

class CreateMailResponse {
  CreateMailResponse({
    this.message,
    this.mail,
  });

  CreateMailResponse.fromJson(dynamic json) {
    message = json['message'];
    mail = (json['mail'] != null ? MailData.fromJson(json['mail']) : null)!;
  }
  String? message;
  MailData? mail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (mail != null) {
      map['mail'] = mail!.toJson();
    }
    return map;
  }
}
