import 'TagModel.dart';

class TagMailsModel {
  TagMailsModel({
    this.tags,
  });

  TagMailsModel.fromJson(dynamic json) {
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
  }
  List<TagModel>? tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tags != null) {
      map['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
