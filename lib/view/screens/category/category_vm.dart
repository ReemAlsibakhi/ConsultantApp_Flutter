import 'package:consultant_app/model/category/Categories.dart';
import 'package:consultant_app/model/category/CategoryModel.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/remote/response/ApiResponse.dart';
import 'category_repo.dart';

class CategoryVM with ChangeNotifier {
  CategoryRepo repo = CategoryRepo();
  ApiResponse<CategoryModel> categoryMain = ApiResponse.loading();
  Categories? _data;
  Categories? get data => _data;

  int clickedItem = 0;
  int get selectedItem => clickedItem;

  int _clickedId = 0;
  int get selectedId => _clickedId;

  void setData(Categories data) {
    _data = data;
    notifyListeners();
  }

  void updateSelectedItem(int index, int id) {
    _clickedId = id;
    clickedItem = index;
    notifyListeners();
  }

  CategoryVM() {
    fetchCategory();
  }

  //status
  void _setCategoryMain(ApiResponse<CategoryModel> response) {
    print("_setCategoryMain :: $response");
    categoryMain = response;
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
}
