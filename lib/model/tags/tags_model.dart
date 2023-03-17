class Tag {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  Tag({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
