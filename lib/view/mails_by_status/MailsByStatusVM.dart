import 'package:flutter/cupertino.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/status/SingleStatusModel.dart';
import 'MailsByStatusRepo.dart';

class MailsByStatusVM extends ChangeNotifier {
  ApiResponse<SingleStatusModel> mailsByStatus = ApiResponse.loading();
  MailsByStatusRepo repo = MailsByStatusRepo();

  //status
  void _setStatusMain(ApiResponse<SingleStatusModel> response) {
    print("_setStatusMain :: $response");
    mailsByStatus = response;
    notifyListeners();
  }

  Future<SingleStatusModel?> fetchMailsByStatus(int index) async {
    _setStatusMain(ApiResponse.loading());
    repo
        .getStatus(index)
        .then((value) => _setStatusMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setStatusMain(ApiResponse.error(error.toString())));
  }
}
