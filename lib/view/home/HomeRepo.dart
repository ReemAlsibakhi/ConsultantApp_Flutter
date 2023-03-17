import 'package:consultant_app/model/mail/MailModel.dart';
import 'package:consultant_app/model/tags/TagsModel.dart';

import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';
import '../../model/category/CategoryModel.dart';
import '../../model/status/StatusModel.dart';

class HomeRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<StatusModel> getStatus() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().getStatuses);
      print("status $response");
      StatusModel jsonData = StatusModel.fromJson(response);
      print("status-reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }

  Future<CategoryModel> getCategory() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().categories);
      print("category PhotoListVM $response");
      CategoryModel jsonData = CategoryModel.fromJson(response);
      print("category PhotoListVM -reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }

  Future<MailModel> getMails() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().getAllMails);
      print("MailModel  $response");
      MailModel jsonData = MailModel.fromJson(response);
      print("MailModel -reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }

  Future<TagsModel> getTags() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints().getTags);
      print("getTags  $response");
      TagsModel jsonData = TagsModel.fromJson(response);
      print("getTags -reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
