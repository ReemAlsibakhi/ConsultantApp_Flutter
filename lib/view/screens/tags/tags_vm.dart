import 'package:consultant_app/view/screens/tags/tags_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../model/tags/TagsModel.dart';

class TagsVM extends ChangeNotifier {
  TagsRepo repo = TagsRepo();
  ApiResponse<TagsModel> tagsMain = ApiResponse.loading();

  List<int> _selectedItems = [];
  List<int> get selectedItem => _selectedItems;

  List<int>? _data;
  List<int>? get data => _data;

  void setData(List<int> data) {
    _data = data;
    notifyListeners();
  }

  void addItem(int item) {
    _selectedItems.add(item);
    print('_selectedItems $_selectedItems');
    notifyListeners();
  }

  void deleteItem(int index) {
    _selectedItems.remove(index);
    print('_selectedItems $_selectedItems');
    notifyListeners();
  }

  TagsVM() {
    fetchTags();
  }

  //status
  void _setTagsMain(ApiResponse<TagsModel> response) {
    print("_setStatusMain :: $response");
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
}
