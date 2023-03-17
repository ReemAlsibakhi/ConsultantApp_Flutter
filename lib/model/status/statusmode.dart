

class Inbox {
  final int id;
 // final bool isSelected;
  final String name;
  final String color;
  final  String createdAt;
  final  String updatedAt;
  final  String mailsCount;

  Inbox({
   // this.isSelected=false,
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.mailsCount,
  });

  factory Inbox.fromJson(Map<String, dynamic> json) {
    return Inbox(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      mailsCount: json['mails_count'],
      //isSelected: json['isSelected']
    );
  }

}














