



import 'package:flutter/material.dart';

import '../data/remote/network/NetworkApiService.dart';
import '../view_models/allmail_model.dart';

class ProviderMail extends ChangeNotifier {
  NetworkApiService networkApiService = NetworkApiService();
  List<Mail> temp = [];
  Future<List<Mail>> getMails() async {

    var data = await networkApiService.getResponse(
        'mails');

    print(data);
    if(data.toString().contains("mails")){
      for (var item in data["mails"]['data']) {
        temp.add(
            Mail(id:item['id'], subject:item['subject'], description: item['description'],
              senderId:item['senderId'], archiveNumber: item['archiveNumber'],
              archiveDate:item['archiveDate'], decision: item['decision'],
              statusId: item['statusId'], finalDecision: item['finalDecision'],
              createdAt: item['createdAt'], updatedAt:item['updatedAt'],
              sender:item['sender'] , status: item['status'],
              tags: [], attachments: [],
              activities: [],

            )
        );
      }
    }
    print(temp.length);
    notifyListeners();
    return temp;
  }
}
