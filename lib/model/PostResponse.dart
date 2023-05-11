// import 'package:consultant_app/model/mail/MailData.dart';
//
// class PostResponse{
//   PostResponse({
//     this.message,
//     this.mail,
//   });
//
//   PostResponse.fromJson(dynamic json) {
//     message = json['message'];
//     obj = (json['mail'] != null ? MailData.fromJson(json['mail']) : null)!;
//   }
//   String? message;
//   dynamic? obj;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['message'] = message;
//     if (mail != null) {
//       map['mail'] = mail!.toJson();
//     }
//     return map;
//   }
// }
