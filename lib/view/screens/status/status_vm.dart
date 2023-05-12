import 'package:consultant_app/model/status/StatusMail.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../model/status/StatusModel.dart';
import 'status_repo.dart';

class StatusVM with ChangeNotifier {
  StatusRepo repo = StatusRepo();
  ApiResponse<StatusModel> statusMain = ApiResponse.loading();
  StatusMail? _data;
  StatusMail? get data => _data;

  int clickedItem = 0;
  int get selectedItem => clickedItem;

  int _clickedId = 0;
  int get selectedId => _clickedId;
  void setData(StatusMail data) {
    _data = data;
    notifyListeners();
  }

  void updateSelectedItem(int index, int id) {
    _clickedId = id;
    clickedItem = index;
    notifyListeners();
  }

  StatusVM() {
    fetchStatus();
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
}
