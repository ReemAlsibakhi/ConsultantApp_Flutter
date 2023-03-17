import 'Role.dart';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }
  int? id;
  String? name;
  String? email;
  dynamic image;
  dynamic emailVerifiedAt;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  Role? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['image'] = image;
    map['email_verified_at'] = emailVerifiedAt;
    map['role_id'] = roleId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (role != null) {
      map['role'] = role!.toJson();
    }
    return map;
  }
}
