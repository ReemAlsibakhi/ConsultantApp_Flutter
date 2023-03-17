import 'Category.dart';

class Sender {
  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  Sender.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['address'] = address;
    map['category_id'] = categoryId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (category != null) {
      map['category'] = category!.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'Sender{id: $id, name: $name, mobile: $mobile, address: $address, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, category: $category}';
  }
}
