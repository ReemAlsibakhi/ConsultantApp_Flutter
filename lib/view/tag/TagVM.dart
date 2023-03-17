import 'dart:convert';

import 'package:consultant_app/data/remote/network/ApiEndPoints.dart';
import 'package:consultant_app/model/status/statusmode.dart';
import 'package:flutter/cupertino.dart';

import '../../data/remote/network/NetworkApiService.dart';
import '../../model/tags/tags_model.dart';

class ProviderTags extends ChangeNotifier {
  NetworkApiService networkApiService = NetworkApiService();
  List<Tag> temp = [];
  String previousData = "";

  Future<List<Tag>> getTags() async {
    var data = await networkApiService.getResponse(ApiEndPoints().getTags);

    if (data.toString() == previousData) {
      // Data has not changed, don't print anything
      return temp;
    }

    previousData = data.toString(); // Update previous data

    print(data);

    temp.clear(); // Clear the previous data
    if (data.toString().contains("tags")) {
      for (var item in data["tags"]) {
        temp.add(Tag(
          id: item['id'].toString(),
          name: item['name'],
          createdAt: item['created_at'],
          updatedAt: item['updated_at'],
        ));
      }
    }

    notifyListeners();
    return temp;
  }

  Future<Inbox> getSingleTag(index) async {
    var data =
        await networkApiService.getResponse('statuses/index?mail=false}');
    late Inbox selectedStatus;
    print(data);
    if (data.toString().contains("statuses")) {
      var item = data;
      selectedStatus = Inbox(
        id: item['id'],
        name: item['name'],
        color: item['color'],
        createdAt: item['created_at'],
        updatedAt: item['updated_at'],
        mailsCount: item['mails_count'],
      );
    }
    return selectedStatus;
  }

  void postSingleTag(Tag tag) async {
    var tagJson = json.encode(tag.toJson());
    var data =
        await networkApiService.postResponse('tags', json.decode(tagJson));
    notifyListeners();
  }
}
