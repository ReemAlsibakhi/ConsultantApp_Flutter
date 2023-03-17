import 'package:consultant_app/model/mail/Sender.dart';

class Categories {
  Categories({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.sendersCount,
    this.senders,
  });

  Categories.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sendersCount = json['senders_count'];
    if (json['senders'] != null) {
      senders = [];
      json['senders'].forEach((v) {
        senders!.add(Sender.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? sendersCount;
  List<Sender>? senders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['senders_count'] = sendersCount;
    if (senders != null) {
      map['senders'] = senders!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'Categories{id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, sendersCount: $sendersCount, senders: $senders}';
  }
}
