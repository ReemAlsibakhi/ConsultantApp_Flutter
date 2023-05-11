import 'package:consultant_app/model/tags/TagMailsModel.dart';

import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';

class MailsByTagRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<TagMailsModel> getMailsByTag(List<int> list) async {
    try {
      dynamic response =
          await _apiService.getResponse('${ApiEndPoints().getMailByTag}+$list');
      print("getMailsByTag $response");
      TagMailsModel jsonData = TagMailsModel.fromJson(response);
      print("getMailsByTag-reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
