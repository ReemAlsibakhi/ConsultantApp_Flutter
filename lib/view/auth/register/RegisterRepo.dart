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

  // Future<UserModel> register(String email, String password, String name) async {
  //   print('email: $email, password: $password');
  //   final response = await http.post(Uri.parse(ApiEndPoints().register),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(<String, String>{
  //         'email': email,
  //         'password': password,
  //         'password_confirmation': password,
  //         'name': name
  //       }));
  //   print('responce ${response.body}');
  //   if (response.statusCode == 200) {
  //     print('success');
  //     return UserModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }
}
