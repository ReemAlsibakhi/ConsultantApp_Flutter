import 'package:consultant_app/model/category/CategoryModel.dart';
import 'package:consultant_app/model/mail/MailModel.dart';
import 'package:consultant_app/model/status/StatusModel.dart';
import 'package:flutter/cupertino.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/tags/TagsModel.dart';
import 'HomeRepo.dart';

class HomeVM extends ChangeNotifier {
  ApiResponse<CategoryModel> catMain = ApiResponse.loading();
  ApiResponse<StatusModel> statusMain = ApiResponse.loading();
  ApiResponse<MailModel> mailMain = ApiResponse.loading();
  ApiResponse<TagsModel> tagsMain = ApiResponse.loading();
  HomeRepo repo = HomeRepo();

  HomeVM() {
    fetchStatus();
    fetchCategory();
    fetchMails();
    fetchTags();
  }
  //status
  void _setStatusMain(ApiResponse<StatusModel> response) {
    print("_setStatusMain :: $response");
    statusMain = response;
    notifyListeners();
  }

  Future<StatusModel?> fetchStatus() async {
    _setStatusMain(ApiResponse.loading());
    repo
        .getStatus()
        .then((value) => _setStatusMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setStatusMain(ApiResponse.error(error.toString())));
  }

  //category
  void _setCategoryMain(ApiResponse<CategoryModel> response) {
    print("reem response :: $response");
    catMain = response;
    notifyListeners();
  }

  Future<CategoryModel?> fetchCategory() async {
    _setCategoryMain(ApiResponse.loading());
    repo
        .getCategory()
        .then((value) => _setCategoryMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setCategoryMain(ApiResponse.error(error.toString())));
  }

  //mails
  void _setMailsMain(ApiResponse<MailModel> response) {
    print("reem response :: $response");
    mailMain = response;
    notifyListeners();
  }

  Future<MailModel?> fetchMails() async {
    _setMailsMain(ApiResponse.loading());
    repo
        .getMails()
        .then((value) => _setMailsMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMailsMain(ApiResponse.error(error.toString())));
  }

  //tags
  void _setTagsMain(ApiResponse<TagsModel> response) {
    print("_setTagsMain response :: $response");
    tagsMain = response;
    notifyListeners();
  }

  Future<TagsModel?> fetchTags() async {
    _setTagsMain(ApiResponse.loading());
    repo
        .getTags()
        .then((value) => _setTagsMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setTagsMain(ApiResponse.error(error.toString())));
  }
}
