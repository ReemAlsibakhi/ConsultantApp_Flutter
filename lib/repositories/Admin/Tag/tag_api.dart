import '../../../controllers/constants.dart';
import '../../../data/services/api_services.dart';

class TagApi {
  ApiServices service = ApiServices();

  getAllTags(){
    final String url = "$baseUrl" "/" "tags";
    var json =service.getData(url);
    return json;
  }


}