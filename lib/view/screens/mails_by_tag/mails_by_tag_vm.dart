import 'package:flutter/cupertino.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../model/tags/TagMailsModel.dart';
import '../../../model/tags/TagsModel.dart';
import 'mails_by_tag_repo.dart';

class MailsByTagVM extends ChangeNotifier {
  MailsByTagRepo repo = MailsByTagRepo();
  ApiResponse<TagMailsModel> mailsByTag = ApiResponse.loading();
  ApiResponse<TagsModel> tagsMain = ApiResponse.loading();

  List<int> _selectedItems = [];
  List<int> getSelectedItem() => _selectedItems;

  //tag
  void _setMailByTag(ApiResponse<TagMailsModel> response) {
    print("_setStatusMain :: $response");
    mailsByTag = response;
    notifyListeners();
  }

  Future<TagMailsModel?> getMailsByTag() async {
    _setMailByTag(ApiResponse.loading());
    repo
        .getMailsByTag(_selectedItems)
        .then((value) => _setMailByTag(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMailByTag(ApiResponse.error(error.toString())));
  }

  void addItem(int item) {
    _selectedItems.add(item);
    print('_selectedItems $_selectedItems');
    getMailsByTag();
    notifyListeners();
  }

  void deleteItem(int index) {
    _selectedItems.remove(index);
    print('_selectedItems $_selectedItems');
    getMailsByTag();
    notifyListeners();
  }
}
