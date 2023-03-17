class Attachments {
  Attachments({
    this.id,
    this.title,
    this.image,
    this.mailId,
    this.createdAt,
    this.updatedAt,
  });

  Attachments.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    mailId = json['mail_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? title;
  String? image;
  String? mailId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['mail_id'] = mailId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
