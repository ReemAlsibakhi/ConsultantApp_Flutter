String baseUrl = "https://palmail.betweenltd.com/api";
String loginEndPoint = "login";
String registerEndpoint = "register";
String logOutEndPoint = "logout";
String createNewUser = "users";

String createCategoryEndPoint = "mails";
Map<String, String>? headers = {
  "Content-Type": "application/json",
  "accept": "application/json",
  "Access-Control-Allow-Origin": "*",
};

Map<String, String>? authHeaders = {
  "Content-Type": "application/json",
  "accept": "application/json",
  "Access-Control-Allow-Origin": "*",
  // 'Authorization': 'Bearer ${ms.readFromHiveBox("token")}'
};
