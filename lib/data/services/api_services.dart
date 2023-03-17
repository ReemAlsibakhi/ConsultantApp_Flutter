import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../controllers/constants.dart';

class ApiServices {
  getSingleRecourse(String url) async {
    final Uri apiUrl = Uri.parse(url);
    http.Response response = await http.get(apiUrl, headers: authHeaders);
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        print("all Users response 200");
        var json = jsonDecode(response.body);
        print(json);
        return json;
      }
      if (response.statusCode == 400) {
        print("Unauthenticated");
        var json = jsonDecode(response.body);
        return json["message"];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getData(String url) async {
    final Uri apiUrl = Uri.parse(url);
    http.Response response = await http.get(apiUrl, headers: authHeaders);
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        print("all Users response 200");
        var json = jsonDecode(response.body);
        print(json);
        return json;
      }
      if (response.statusCode == 401) {
        // print("Unauthenticated");
        var json = jsonDecode(response.body);
        print(json);
        // return json["message"];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future authPostData(String url, {Map? data}) async {
    final Uri apiUrl = Uri.parse(url);
    http.Response response =
        await http.post(apiUrl, headers: authHeaders, body: jsonEncode(data));
    print("status Code of request ${response.statusCode}");
    print(response.body);
    try {
      if (response.statusCode == 200) {
        print(200);
        var json = jsonDecode(response.body);
        return json;
      }
      if (response.statusCode == 400) {
        print("Unauthenticated");
        var json = jsonDecode(response.body);
        return json["message"];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String url, Map data) async {
    final Uri apiUrl = Uri.parse(url);
    http.Response response =
        await http.post(apiUrl, headers: headers, body: jsonEncode(data));
    print("response login status code${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print("success response ${json["token"]}");
        //  return json["token"];
        return json;
        print(json);
      }
      if (response.statusCode == 400) {
        var json = jsonDecode(response.body);
        print("Failed Message : ${json["message"]} ${response.statusCode}");
        //return json["message"];
        //return error message response in class (that handles the api response)
        return json;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  deleteData(String url) async {
    final Uri apiUrl = Uri.parse(url);
    http.Response response = await http.delete(apiUrl, headers: authHeaders);
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        print(200);
        var json = jsonDecode(response.body);
        print(json);
        return json;
      }
      if (response.statusCode == 400) {
        print("Unauthenticated");
        var json = jsonDecode(response.body);
        return json["message"];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateData(String url, Map data) async {
    final Uri apiUrl = Uri.parse(url);
    http.Response response =
        await http.post(apiUrl, headers: authHeaders, body: jsonEncode(data));
    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        print(200);
        var json = jsonDecode(response.body);
        print(json);
        return json;
      }
      if (response.statusCode == 400) {
        print("Unauthenticated");
        var json = jsonDecode(response.body);
        return json["message"];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
