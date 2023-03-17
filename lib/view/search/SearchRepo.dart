import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';
import '../../model/filter/SearchMailModel.dart';

class SearchRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<SearchMailModel> getMailByFilter(String text, int statusId) async {
    print('status_id SearchRepo $statusId');
    String url =
        '${ApiEndPoints().search}text=$text${statusId != -1 ? '&status_id=$statusId' : ''}';
    try {
      dynamic response = await _apiService.getResponse(url);
      print("getMailByFilter ${response}");
      SearchMailModel jsonData = SearchMailModel.fromJson(response);
      print("getMailByFilter-reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
