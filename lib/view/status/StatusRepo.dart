import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';
import '../../model/status/StatusModel.dart';

class StatusRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<StatusModel> getStatus() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().getStatuses);
      print("status $response");
      StatusModel jsonData = StatusModel.fromJson(response);
      print("status-reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
