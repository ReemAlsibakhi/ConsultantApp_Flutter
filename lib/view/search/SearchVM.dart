import 'package:flutter/cupertino.dart';

import '../../data/remote/response/ApiResponse.dart';
import '../../model/filter/SearchMailModel.dart';
import 'SearchRepo.dart';

class SearchVM extends ChangeNotifier {
  ApiResponse<SearchMailModel> mailsByFilter = ApiResponse.stop();
  SearchRepo repo = SearchRepo();
  String _text = "", dateStart = "", dateEnd = "";
  int _statusId = -1;
  int _listLength = 0;

  void _setMailByFilter(ApiResponse<SearchMailModel> response) {
    print("_setMailByFilter:: $response");
    mailsByFilter = response;
    notifyListeners();
  }

  Future<SearchMailModel?> getMailsByFilter() async {
    print("getMailByFilter $_text");
    _setMailByFilter(ApiResponse.loading());
    repo
        .getMailByFilter(_text, _statusId)
        .then((value) => _setMailByFilter(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMailByFilter(ApiResponse.error(error.toString())));
  }

  void setText(String val) {
    _text = val;
    print('_text : $_text');
    getMailsByFilter();
    notifyListeners();
  }

  void setStatusId(int val) {
    _statusId = val;
    print('statusId : $_text');
    getMailsByFilter();
    notifyListeners();
  }

  void setLength(int l) {
    _listLength = l;
    print('listLength : $_listLength');

    notifyListeners();
  }

  int getLength() {
    print('getLength : $_listLength');
    return _listLength;
  }
}
