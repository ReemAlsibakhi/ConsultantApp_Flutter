class ApiEndPoints {
  static String baseUrl = 'https://palmail.betweenltd.com/api/';
  //auth
  final String login = "${baseUrl}login";
  final String register = "${baseUrl}register";
  final String logout = "${baseUrl}logout";
  //mails
  final String getAllMails = "${baseUrl}mails";
  final String createMail = "${baseUrl}mails";
  final String updateMail = "${baseUrl}mails/";
  //status
  final String getStatuses = "${baseUrl}statuses";
  final String getMailStatuses = "${baseUrl}statuses/";
  //category
  final String categories = "${baseUrl}categories";
  //tags
  final String getTags = "${baseUrl}tags";
  final String getMailByTag = "${baseUrl}tags?tags=";
  //search
  final String search = "${baseUrl}search?";
  //Sender
  final String createSender = "${baseUrl}senders";
}
