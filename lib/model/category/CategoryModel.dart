import 'Categories.dart';

class CategoryModel {
  CategoryModel({
    this.categories,
  });

  CategoryModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'CategoryModel{categories: $categories}';
  }
}
