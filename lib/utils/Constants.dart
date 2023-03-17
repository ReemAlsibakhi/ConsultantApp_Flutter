import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const kPrimaryColor = Color(0xFF003AFC);
const kLightPrimaryColor = Color(0xFF6589FF);
const kGreyColor = Color(0xFFEAEAF5);
const kHintGreyColor = Color(0xFFB2B2B2);
const kLightGreyColor = Color(0xFFE6E6E6);
const kDarkGreyColor = Color(0xFF7C7C7C);
const kLightWhiteColor = Color(0xFFF7F6FF);
const kNavBottomColor = Color(0xFFD0D0D0);
const kBlackColor = Color(0xFF272727);
const kLightBlackColor = Color(0xFF898989);
const kDividerColor = Color(0xFFD0D0D0);
const kDarkGreyColor2 = Color(0xFF707070);
const kDarkGreyColor3 = Color(0xFF959595);
const kLightGreyColor2 = Color(0xFFEEEEF6);
const kRedColor = Color(0xFFFF2E2E);

const kGradientColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [kPrimaryColor, kLightPrimaryColor],
  ),
);
String getDate(String date) {
  var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

String getArchDate(String date) {
  var inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}
