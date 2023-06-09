import 'package:consultant_app/model/tags/TagsModel.dart';

import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';
import '../../../model/tags/TagMailsModel.dart';

class TagsRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<TagsModel> getTags() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints.getTags);
      print("tag response $response");
      TagsModel jsonData = TagsModel.fromJson(response);
      print("tag jsonData $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }

  Future<TagMailsModel> getMailsByTag(List<int> list) async {
    try {
      dynamic response =
          await _apiService.getResponse('${ApiEndPoints.getMailByTag}+$list');
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
