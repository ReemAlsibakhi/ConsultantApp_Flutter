import 'package:consultant_app/data/remote/network/ApiEndPoints.dart';

import '../../../../data/remote/network/BaseApiService.dart';
import '../../../../data/remote/network/NetworkApiService.dart';
import '../../../../model/user/UserModel.dart';

class LoginRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<UserModel> login(String email, String pass) async {
    try {
      Map data = {
        'email': email,
        'password': pass,
      };
      dynamic response =
          await _apiService.postResponse(ApiEndPoints.login, data);
      print("loginRequest $response");
      UserModel jsonData = UserModel.fromJson(response);
      print("loginRequest $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
