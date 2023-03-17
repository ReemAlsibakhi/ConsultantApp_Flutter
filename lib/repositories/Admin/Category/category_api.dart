import 'package:consultant_app/data/services/api_services.dart';
import 'package:hive/hive.dart';

import '../../../controllers/constants.dart';

class CatApi {
  ApiServices service = ApiServices();
  createCategory(String name) async{
    Map data = {
    "name":name
    };
    String url = "$baseUrl" "/" "categories";
    var json = await service.authPostData(url, data: data);

    return json;

  }
  Box box =Hive.box("myBox");

  getAllCategories() async{
    print(box.get("token"));
    String url = "$baseUrl" "/" "categories";
    var json = await service.getData(url);
    return json;
  }

  getSingleCategory(int id)async{
    String url = "$baseUrl" "/" "categories/$id";
    var json = await service.getData(url);
    return json;
  }
}