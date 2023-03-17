class Pivot {
  Pivot({
    this.mailId,
    this.tagId,
  });

  Pivot.fromJson(dynamic json) {
    mailId = json['mail_id'];
    tagId = json['tag_id'];
  }
  String? mailId;
  String? tagId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mail_id'] = mailId;
    map['tag_id'] = tagId;
    return map;
  }
}
