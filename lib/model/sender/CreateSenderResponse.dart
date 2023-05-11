import '../mail/Sender.dart';

class CreateSenderResponse {
  CreateSenderResponse({
    this.message,
    this.sender,
  });

  CreateSenderResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['sender'] != null) {
      sender = [];
      json['sender'].forEach((v) {
        sender!.add(Sender.fromJson(v));
      });
    }
  }
  String? message;
  List<Sender>? sender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (sender != null) {
      map['sender'] = sender!.map((v) => v!.toJson()).toList();
    }
    return map;
  }
}
