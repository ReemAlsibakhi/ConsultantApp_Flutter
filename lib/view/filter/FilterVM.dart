import 'package:flutter/cupertino.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/category/CategoryModel.dart';
import '../../model/status/StatusModel.dart';
import 'FilterRepo.dart';

class FilterVM extends ChangeNotifier {
  ApiResponse<CategoryModel> catMain = ApiResponse.loading();
  ApiResponse<StatusModel> statusMain = ApiResponse.loading();
  int _selectedStatus = 0;
  int _selectedCats = 0;
  FilterRepo repo = FilterRepo();
  FilterVM() {
    fetchStatus();
    fetchCategory();
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

  void updateSelectedStatus(int index) {
    _selectedStatus = index;
    print('updateSelectedStatus $index');
    notifyListeners();
  }

  int getSelectedStatus() => _selectedStatus;
  void updateSelectedCats(int index) {
    _selectedCats = index;
    notifyListeners();
  }

  int getSelectedCats() => _selectedCats;
  @override
  void dispose() {
    super.dispose();
  }
}
