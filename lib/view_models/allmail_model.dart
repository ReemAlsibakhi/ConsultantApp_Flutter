
class Mail {
  late int id;
  late String subject;
  late String description;
  late  String senderId;
  late String archiveNumber;
  late  String archiveDate;
  late String decision;
  late String statusId;
  late  String finalDecision;
  late String createdAt;
  late String updatedAt;
  late Sender sender;
  late Status status;
  late List<Tag> tags;
  late List<dynamic> attachments;
  late List<Activity> activities;

  Mail({
    required this.id,
    required this.subject,
    required this.description,
    required this.senderId,
    required this.archiveNumber,
    required this.archiveDate,
    required this.decision,
    required this.statusId,
    required this.finalDecision,
    required this.createdAt,
    required this.updatedAt,
    required this.sender,
    required this.status,
    required this.tags,
    required this.attachments,
    required this.activities,
  });
  Mail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    description = json['description'];
    senderId = json['sender_id'];
    archiveNumber = json['archive_number'];
    archiveDate = json['archive_date'];
    decision = json['decision'];
    statusId = json['status_id'];
    finalDecision = json['final_decision'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender = Sender.fromJson(json['sender']);
    status = Status.fromJson(json['status']);
    tags = List<Tag>.from(json['tags'].map((tag) => Tag.fromJson(tag)));
    attachments = json['attachments'];
    activities = List<Activity>.from(json['activities'].map((activity) => Activity.fromJson(activity)));
  }
}

class Sender {
  late int id;
  late String name;
  late String mobile;
  late String address;
  late String categoryId;
  late String createdAt;
  late String updatedAt;
  late Category category;

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = Category.fromJson(json['category']);
  }
}

class Category {
  late int id;
  late String name;
  late  String createdAt;
  late String updatedAt;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Status {
  late int id;
  late  String name;
  late String color;

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }
}

class Tag {
  late int id;
  late String name;
  late  String createdAt;
  late String updatedAt;

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Activity {
  late int id;
  late String body;
  late String userId;
  late String mailId;
  late String sendNumber;
  late String sendDate;
  late String sendDestination;
  late String createdAt;
  late String updatedAt;
  late  User user;

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userId = json['user_id'];
    mailId = json['mail_id'];
    sendNumber = json['send_number'];
    sendDate = json['send_date'];
    sendDestination = json['send_destination'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = User.fromJson(json['user']);
  }
}

class User {
  late int id;
  late String name;
  late String email;
  late String image;
  late String emailVerifiedAt;
  late String roleId;
  late String createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      emailVerifiedAt: json['email_verified_at'],
      roleId: json['role_id'],
      createdAt: json['created_at'],
    );
  }
}
