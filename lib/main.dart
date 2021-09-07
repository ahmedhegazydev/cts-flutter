import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/Inbox.dart';
import 'Login.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CTS',
        theme: ThemeData(
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
              headline3: TextStyle(fontSize: 14, fontStyle: FontStyle.normal),
            ).apply(
                bodyColor: createMaterialColor(Color.fromRGBO(96, 175, 189, 1)),
                displayColor:
                    createMaterialColor(Color.fromRGBO(96, 175, 189, 1))),
            fontFamily: "Bahij",
            primarySwatch:
                createMaterialColor(Color.fromRGBO(96, 175, 189, 1))),
        home: LoginPage(), //InboxPage(),
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
        locale: Locale("ar", "AR"));
    // locale: Locale("en", "US"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
