import 'package:consultant_app/model/mail/MailModel.dart';

import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';

class DetailsRepo {
  final BaseApiService _apiService = NetworkApiService();
  Future<MailModel> updateMail(Map<String, String> jsonBody) async {
    try {
      dynamic response =
          await _apiService.putResponse(ApiEndPoints().updateMail, jsonBody);
      print("status $response");
      MailModel jsonData = MailModel.fromJson(response);
      print("status-reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
