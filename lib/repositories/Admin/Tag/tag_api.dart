import '../../../data/services/api_services.dart';
import '../../../utils/Constants.dart';

class TagApi {
  ApiServices service = ApiServices();

  getAllTags() {
    final String url = "$baseUrl" "/" "tags";
    var json = service.getData(url);
    return json;
  }
}
