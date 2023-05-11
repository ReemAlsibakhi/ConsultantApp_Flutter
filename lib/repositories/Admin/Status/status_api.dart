import 'package:consultant_app/data/services/api_services.dart';

import '../../../utils/Constants.dart';

class ApiStatus {
  ApiServices service = ApiServices();
  getAllStatus() async {
    String url = "$baseUrl" "/" "statuses";
    var json = await service.getData(url);
    return json;
  }
}
