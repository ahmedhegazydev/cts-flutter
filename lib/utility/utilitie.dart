// import 'package:flutter/material.dart';
//
// const Color backgroundColor=Color(0xffF4F4F4);
// const Color buttonColor=Color(0xffef7d25);
// const Color textbuttonColor=Color(0xffffffff);
// const Color menubackground=Color(0xffEDEDED);
// const Color backmenubackground=Color(0xffffffff);
// const Color textcolor=Color(0xff1381CA);
// const Color appBarcolors=Color(0xff1381CA);
// const Color blackcolore=Color(0xff000000);
// const Color framColor=Color(0xffef7d25);

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

String getCurrentYearString() {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  var formatter = DateFormat("yyyy", "en");
  String date = formatter.format(now);
  return date;
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

String getLocaleCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}

bool isDirectionRTLForBackArrow(BuildContext context) {
  return Bidi.isRtlLanguage(
      // Localizations.localeOf(context).languageCode
      Get.locale?.languageCode == "en" ? "ar" : "en"
      // Get.locale?.languageCode
      );
}

bool isDirectionRTL(BuildContext context) {
  return Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode
      // Get.locale?.languageCode == "en" ? "ar" : "en"
      // Get.locale?.languageCode
      );
}

String returnImageNameBasedOnDirection(
    String imageName, BuildContext context, String extension) {
  if (isDirectionRTL(context)) {
    //"_R."
    return imageName + "_L." + extension;
  } //_L.
  return imageName + "_R." + extension;
}

String returnImageNameBasedOnOppositeDirection(
    String imageName, BuildContext context, String extension) {
  if (isDirectionRTLForBackArrow(context)) {
    return imageName + "_R." + extension;
  }
  return imageName + "_L." + extension;
}

double calculateHeight(double nb, BuildContext context) {
  //the development was done on ipad 12 pro, the height in landscape is 1024
  double height = MediaQuery.of(context).size.height;
  return (height * nb) / 1024;
}

double calculateWidth(double nb, BuildContext context) {
  //the development was done on ipad 12 pro, the width in landscape is 1366
  double width = MediaQuery.of(context).size.width;
  return (width * nb) / 1366;
}

double calculateFontSize(double nb, BuildContext context) {
  //the development was done on ipad 12 pro, the width in landscape is 1366
  double width = MediaQuery.of(context).size.width;
  return (width * nb) / 1366;
}

String calculateDate(String dateFormat, String locale) {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  var formatter = DateFormat(dateFormat, locale);
  String date = formatter.format(now);
  return date;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String? base64String) {
  return base64Decode(base64String!);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

Future<String?> audiobase64String({File? file}) async {
  String? fileString;
  List<int>? fileBytes = file?.readAsBytesSync();
  if (fileBytes != null) {
    //String base64String = base64Encode(fileBytes);
    String base64String = base64.encode(fileBytes);
    // fileString = 'data:audio/mp4;base64,$base64String';
    fileString = base64String;
  }

  return fileString;
}

Future<String> createFileFromString(data) async {
  final encodedStr = data;
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File("$dir/" + "voice" + ".aac");
  await file.writeAsBytes(bytes);
  return file.path;
}

//
// Future<String?>  audiobase64String({  File? file})async{
//   String? fileString;
// Uint8List audio=await file!.readAsBytes();
// String b64=base64.encode(audio);
// fileString=b64;
//
//
//   return fileString;
// }

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 7), child: Text("Loading...".tr)),
      ],
    ),
  );
  showDialog(
    // barrierDismissible: true,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
