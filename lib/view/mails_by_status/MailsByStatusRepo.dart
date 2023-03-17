import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';
import '../../model/status/SingleStatusModel.dart';

class MailsByStatusRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<SingleStatusModel> getStatus(int index) async {
    try {
      dynamic response = await _apiService
          .getResponse('${ApiEndPoints().getMailStatuses}$index?mail=true');
      print("status $response");
      SingleStatusModel jsonData = SingleStatusModel.fromJson(response);
      print("status-reem $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
