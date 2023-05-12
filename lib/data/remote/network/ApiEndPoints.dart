class ApiEndPoints {
  static String baseUrl = 'https://palmail.betweenltd.com/api/';
  //auth
  static final String login = "${baseUrl}login";
  static final String register = "${baseUrl}register";
  static final String logout = "${baseUrl}logout";
  //mails
  static final String getAllMails = "${baseUrl}mails";
  static final String createMail = "${baseUrl}mails";
  static final String updateMail = "${baseUrl}mails/";
  //status
  static final String getStatuses = "${baseUrl}statuses";
  static final String getMailStatuses = "${baseUrl}statuses/";
  //category
  static final String categories = "${baseUrl}categories";
  //tags
  static final String getTags = "${baseUrl}tags";
  static final String getMailByTag = "${baseUrl}tags?tags=";
  //search
  static final String search = "${baseUrl}search?";
  //Sender
  static final String createSender = "${baseUrl}senders";
  //headers
  static final Map<String, String> headers = {
    "Content-Type": "application/json",
    "accept": "application/json",
    "Access-Control-Allow-Origin": "*",
  };

  static final Map<String, String> authHeaders = {
    "Content-Type": "application/json",
    "accept": "application/json",
    "Access-Control-Allow-Origin": "*",
    // 'Authorization': 'Bearer ${ms.readFromHiveBox("token")}'
  };
}
