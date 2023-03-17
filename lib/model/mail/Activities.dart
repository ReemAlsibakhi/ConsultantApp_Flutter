import 'User.dart';

class Activities {
  Activities({
    this.id,
    this.body,
    this.userId,
    this.mailId,
    this.sendNumber,
    this.sendDate,
    this.sendDestination,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Activities.fromJson(dynamic json) {
    id = json['id'];
    body = json['body'];
    userId = json['user_id'];
    mailId = json['mail_id'];
    sendNumber = json['send_number'];
    sendDate = json['send_date'];
    sendDestination = json['send_destination'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? id;
  String? body;
  String? userId;
  String? mailId;
  dynamic sendNumber;
  String? sendDate;
  dynamic sendDestination;
  String? createdAt;
  String? updatedAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['body'] = body;
    map['user_id'] = userId;
    map['mail_id'] = mailId;
    map['send_number'] = sendNumber;
    map['send_date'] = sendDate;
    map['send_destination'] = sendDestination;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }
}
