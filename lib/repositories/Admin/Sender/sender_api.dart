import 'package:consultant_app/data/services/api_services.dart';

import '../../../utils/Constants.dart';

class SenderApi {
  ApiServices service = ApiServices();
  getAllSenders() {
    final String url = "$baseUrl" "/" "senders";
    var json = service.getData(url);
    return json;
  }
}
