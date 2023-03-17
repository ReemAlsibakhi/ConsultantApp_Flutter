import 'package:consultant_app/model/status/StatusMail.dart';
import 'package:flutter/cupertino.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/status/StatusModel.dart';
import 'StatusRepo.dart';

class StatusVM extends ChangeNotifier {
  StatusRepo repo = StatusRepo();
  ApiResponse<StatusModel> statusMain = ApiResponse.loading();
  int clickedItem = 0;
  StatusMail? _data;
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

  void updateSelectedItem(int index) {
    clickedItem = index;
    notifyListeners();
  }

  void setData(StatusMail data) {
    _data = data;
    notifyListeners();
  }

  int getSelectedItem() => clickedItem;
  StatusMail? getData() => _data;

  // @override
  // void dispose() {
  //   _disposed = true;
  //   print('LocalNotifier was disposed.');
  //   super.dispose();
  // }
  //
  // @override
  // void notifyListeners() {
  //   if (!_disposed) {
  //     super.notifyListeners();
  //   }
  // }
}
