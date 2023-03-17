import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/user/UserModel.dart';

class MainServices {
  DateTime getCurrentTime() {
    return DateTime.now();
  }

  void initHive() async {
    WidgetsFlutterBinding.ensureInitialized();
    final applicationDocDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(applicationDocDir.path);
    await Hive.openBox("myBox");
  }

  checkInternetConnection() {}

  writeToHiveBox(dynamic key, dynamic val) {
    var box = Hive.box("myBox");
    box.put(key, val);
  }

  dynamic readFromHiveBox(dynamic key) {
    var box = Hive.box("myBox");
    return box.get(key);
  }

  Future<bool> getLoggedInUserState() async {
    bool val = readFromHiveBox("loggedIn");
    //print(val);
    return val;
  }

  saveToken(String token) {
    writeToHiveBox("token", token.toString());
  }

  String getToken() {
    return readFromHiveBox("token");
  }

  saveUser(UserModel user) {
    writeToHiveBox("user", user.toJson());
  }

  UserModel getUser() {
    UserModel jsonData = UserModel.fromJson(readFromHiveBox("user"));
    return jsonData;
  }

// Test our function
}
