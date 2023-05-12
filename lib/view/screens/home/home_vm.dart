import 'package:consultant_app/model/category/CategoryModel.dart';
import 'package:consultant_app/model/mail/MailModel.dart';
import 'package:consultant_app/model/status/StatusModel.dart';
import 'package:consultant_app/utils/app_constants.dart';
import 'package:consultant_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../model/tags/TagsModel.dart';
import '../../../utils/colors.dart';
import '../../base/custom_loading_dialog.dart';
import '../auth/tab_bar_screen.dart';
import 'home_repo.dart';

class HomeVM extends ChangeNotifier {
  ApiResponse<CategoryModel> catMain = ApiResponse.loading();
  ApiResponse<StatusModel> statusMain = ApiResponse.loading();
  ApiResponse<MailModel> mailMain = ApiResponse.loading();
  ApiResponse<TagsModel> tagsMain = ApiResponse.loading();

  final HomeRepo repo = HomeRepo();

  HomeVM() {
    fetchStatus();
    fetchCategory();
    fetchMails();
    fetchTags();
  }
  //status
  void _setStatusMain(ApiResponse<StatusModel> response) {
    statusMain = response;
    notifyListeners();
  }

  Future<void> fetchStatus() async {
    _setStatusMain(ApiResponse.loading());
    repo
        .getStatus()
        .then((value) => _setStatusMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setStatusMain(ApiResponse.error(error.toString())));
  }

  //category
  void _setCategoryMain(ApiResponse<CategoryModel> response) {
    catMain = response;
    notifyListeners();
  }

  Future<void> fetchCategory() async {
    _setCategoryMain(ApiResponse.loading());
    repo
        .getCategory()
        .then((value) => _setCategoryMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setCategoryMain(ApiResponse.error(error.toString())));
  }

  //mails
  void _setMailsMain(ApiResponse<MailModel> response) {
    mailMain = response;
    notifyListeners();
  }

  Future<void> fetchMails() async {
    _setMailsMain(ApiResponse.loading());
    repo
        .getMails()
        .then((value) => _setMailsMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMailsMain(ApiResponse.error(error.toString())));
  }

  //tags
  void _setTagsMain(ApiResponse<TagsModel> response) {
    tagsMain = response;
    notifyListeners();
  }

  Future<void> fetchTags() async {
    _setTagsMain(ApiResponse.loading());
    repo
        .getTags()
        .then((value) => _setTagsMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setTagsMain(ApiResponse.error(error.toString())));
  }

  Future<void> logOut(BuildContext context) async {
    showLoadingDialog(context);

    await repo.logout().then((value) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Success Logout'),
        backgroundColor: kLightPrimaryColor,
      ));

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return TabBarScreen();
      }), (r) {
        return false;
      });
      SharedPref.inst.setBool(AppConstants.ISLogged, false);
      SharedPref.inst.clear();
    }).onError((error, stackTrace) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red.shade300,
      ));
    });
  }
}
