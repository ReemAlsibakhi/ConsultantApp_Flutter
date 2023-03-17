import 'package:flutter/cupertino.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/mail/MailModel.dart';
import 'DetailsRepo.dart';

class DetailsVM extends ChangeNotifier {
  ApiResponse<MailModel> updateMail = ApiResponse.loading();

  DetailsRepo repo = DetailsRepo();
  //details
  void _setUpdate(ApiResponse<MailModel> response) {
    print("_setUpdate :: $response");
    updateMail = response;
    notifyListeners();
  }

  Future<MailModel?> fetchStatus(Map<String, String> jsonBody) async {
    _setUpdate(ApiResponse.loading());
    repo
        .updateMail(jsonBody)
        .then((value) => _setUpdate(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setUpdate(ApiResponse.error(error.toString())));
  }
}
