import '../../../controllers/constants.dart';
import '../../../data/services/api_services.dart';

class UserApi {
  ApiServices service = ApiServices();
  getAllUsers(){
    final String url = "$baseUrl" "/" "users";
  var json =service.getData(url);
  return json;
  }

  getSingleUser(int id){
    final String url = "$baseUrl" "/" "$createNewUser" "/" "$id";
    var json = service.getSingleRecourse(url);
    return json;
  }

  createNewUSer(String email, String password,String name) async{

      Map data ={
       "name":name,
        "email":email,
        "password":password,
        "password_confirmation":password,
        "role_id":1 // default value for guest user
      };
      String url = "$baseUrl" "/" "users";
      var json = await service.authPostData(url,data: data);
      if(json.toString().isNotEmpty){
        print ("Razan Response $json");
        return json;
      }
    }

    deleteUser(int id){
      final String url = "$baseUrl" "/" "$createNewUser" "/" "$id";
       var json= service.deleteData(url);
       print(json);
       return json;
    }
    updateUser(String name) async{
      final String url = "$baseUrl" "/" "user" "/" "update";
      Map data = {
        "name" :name
      };
      var json = await  service.updateData(url, data);
      return json;
    }
  }
