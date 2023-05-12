import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';
import '../../../model/category/CategoryModel.dart';

class CategoryRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<CategoryModel> getCategory() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints.categories);
      print("getCategory response $response");
      CategoryModel jsonData = CategoryModel.fromJson(response);
      print("getCategory jsonData $jsonData");
      return jsonData;
    } catch (e) {
      print('exeption error ' + e.toString());
      throw e;
    }
  }
}
