import '../mail/Tags.dart';

class TagsModel {
  TagsModel({
    this.tags,
  });

  TagsModel.fromJson(dynamic json) {
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
  }
  List<Tags>? tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tags != null) {
      map['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
