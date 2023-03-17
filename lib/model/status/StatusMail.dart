import '../mail/MailData.dart';

class StatusMail {
  StatusMail({
    this.id,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
    this.mails,
  });

  StatusMail.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mailsCount = json['mails_count'];
    if (json['mails'] != null) {
      mails = [];
      json['mails'].forEach((v) {
        mails!.add(MailData.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? color;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  List<MailData>? mails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['color'] = color;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['mails_count'] = mailsCount;
    if (mails != null) {
      map['mails'] = mails!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'StatusMail{id: $id, name: $name, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, mailsCount: $mailsCount, mails: $mails}';
  }
}
