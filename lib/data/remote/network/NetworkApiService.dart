import 'dart:convert';
import 'dart:io';

import 'package:consultant_app/utils/app_constants.dart';
import 'package:consultant_app/utils/shared_pref.dart';
import 'package:http/http.dart' as http;

import '../AppException.dart';
import 'BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  static const id = 'NetworkApiService';
  dynamic responseJson;

  @override
  Future getResponse(String url) async {
    String? token = await SharedPref.inst.getString(AppConstants.TOKEN);
    print('token getResponse $token');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = returnResponse(response);
      print('NetworkApiService - reem');
    } on SocketException {
      print('${id}No Internet Connection');
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future putResponse(String url, Map<String, dynamic> jsonBody) async {
    String? token = await SharedPref.inst.getString(AppConstants.TOKEN);
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonBody,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map JsonBody) async {
    String? token = await SharedPref.inst.getString(AppConstants.TOKEN);
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: JsonBody,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    print('status code ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        responseJson = jsonDecode(response.body);
        print('responseJson  $responseJson');
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
