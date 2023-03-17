class Status {
  Status({
    this.id,
    this.name,
    this.color,
  });

  Status.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }
  int? id;
  String? name;
  String? color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['color'] = color;
    return map;
  }
}
