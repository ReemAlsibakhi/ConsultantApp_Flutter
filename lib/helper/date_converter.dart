import 'package:intl/intl.dart';

class DateConverter {
  // String getArchDate(String date) {
  //   var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  //   var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format
  //
  //   var outputFormat = DateFormat('MM/dd/yyyy');
  //   var outputDate = outputFormat.format(inputDate);
  //   return outputDate;
  // }
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('MM/dd/yyyy')
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }
}
