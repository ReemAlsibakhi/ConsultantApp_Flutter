import 'package:consultant_app/model/mail/CreateMailResponse.dart';
import 'package:consultant_app/model/mail/MailData.dart';
import 'package:consultant_app/model/mail/Sender.dart';
import 'package:consultant_app/model/sender/CreateSenderResponse.dart';

import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';

class NewInboxRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<CreateMailResponse> createMail(MailData mailData) async {
    try {
      Map data = {
        'subject': mailData.subject,
        'description': mailData.description,
        'sender_id': mailData.senderId,
        'archive_number': mailData.archiveNumber,
        'archive_date': mailData.archiveDate,
        'decision': mailData.decision,
        'status_id': mailData.statusId,
        'final_decision': mailData.decision,
        //  'tags': mailData.tags,
        // 'activities': mailData.activities,
      };
      dynamic response =
          await _apiService.postResponse(ApiEndPoints.createMail, data);
      print("createMail $response");
      CreateMailResponse jsonData = CreateMailResponse.fromJson(response);
      print("createMail $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error createMail' + e.toString());
      throw e;
    }
  }

  Future<CreateSenderResponse> createSender(Sender sender) async {
    try {
      Map data = {
        'name': sender.name,
        'mobile': sender.mobile,
        'address': sender.address ?? '',
        'category_id': sender.categoryId,
      };
      dynamic response =
          await _apiService.postResponse(ApiEndPoints.createSender, data);
      print("createSender $response");
      CreateSenderResponse jsonData = CreateSenderResponse.fromJson(response);
      print("createSender $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error createSender' + e.toString());
      throw e;
    }
  }
}
