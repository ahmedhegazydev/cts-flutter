import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cts/presentation/widgets/app_routes.dart';
import 'presentation/screens/Login.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(
    MyApp(
      appRoutes: AppRoutes(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRoutes appRoutes;

  const MyApp({Key? key, required this.appRoutes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultLocale = ui.window.locale.languageCode;
    return MaterialApp(
      title: 'CTS',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.generateRoutes,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 14, fontStyle: FontStyle.normal),
        ).apply(
          bodyColor: createMaterialColor(
            Color.fromRGBO(96, 175, 189, 1),
          ),
          displayColor: createMaterialColor(
            Color.fromRGBO(96, 175, 189, 1),
          ),
        ),
        fontFamily: "Bahij",
        primarySwatch: createMaterialColor(
          Color.fromRGBO(96, 175, 189, 1),
        ),
      ),
      home: LoginPage(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
        Locale("en", "US"),
      ],
      locale: defaultLocale == "en" ? Locale("en", "US") : Locale("ar", "AR"),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

String getLocaleCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}

bool isDirectionRTL(BuildContext context) {
  return intl.Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);
}

String returnImageNameBasedOnDirection(
    String imageName, BuildContext context, String extension) {
  if (isDirectionRTL(context)) {
    return imageName + "_R." + extension;
  }
  return imageName + "_L." + extension;
}

String returnImageNameBasedOnOppositeDirection(
    String imageName, BuildContext context, String extension) {
  if (isDirectionRTL(context)) {
    return imageName + "_L." + extension;
  }
  return imageName + "_R." + extension;
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
