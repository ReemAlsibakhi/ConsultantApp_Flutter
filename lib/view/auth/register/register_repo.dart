import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';
import '../../../model/user/UserModel.dart';

class RegisterRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<UserModel?> register(String email, String pass, String name) async {
    try {
      Map data = {
        'email': email,
        'password': pass,
        'password_confirmation': pass,
        'name': name
      };
      dynamic response =
          await _apiService.postResponse(ApiEndPoints().register, data);
      print("register $response");
      UserModel jsonData = UserModel.fromJson(response);
      print("register $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
