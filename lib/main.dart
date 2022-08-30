import 'package:cts/screens/Login_page.dart';
import 'package:cts/screens/my_cart/MyPocketsScreen.dart';
import 'package:cts/screens/web_view_page.dart';
import 'package:cts/screens/filter/FilterSideScreen.dart';
import 'package:cts/utility/all_string_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Translation/Trans.dart';
import 'bindings/bindings.dart';
import 'controllers/main_controller.dart';
import 'middleware/auth_middleware.dart';
import 'screens/Inbox_page.dart';
import 'screens/Landing_page.dart';
import 'screens/document_page.dart';
import 'screens/open_file.dart';
import 'screens/search_page.dart';
import 'screens/search_page_result.dart';
import 'screens/signature_page.dart';
import 'utility/storage.dart';
import 'utility/utilitie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SecureStorage secureStorage = SecureStorage();
  // Map <dynamic,dynamic>?a=secureStorage.readSecureJsonData("p") ;
  // LoginModel data=LoginModel.fromJson(a!);
  // print("000000");
  // print(data.customActions );
  // print("000000");
  //var bb=json.decode(a.toString());
     secureStorage.deleteSecureData(AllStringConst.Token);
String? appLan=secureStorage.readSecureData(AllStringConst.AppLan);
if(appLan==null){
  print("theeeeeeeeeeeeeeeeeeeee=>  appLan");
  Get.updateLocale(Locale('ar', 'AR'));
}else{


  if(appLan=="ar"){
    print("================================>  arrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    Get.updateLocale(Locale('ar', 'AR'));
  }else{
    print("================================>  ennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    Get.updateLocale(Locale('en', 'US'));

  }
}

  //Get.put(SecureStorage());
  Get.put(MController());

  // runApp(
  //   Phoenix(
  //     child: MyApp(),
  //   ),
  // );

  runApp(
    RestartWidget(
      child: MyApp(),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MController>(builder: (logic) {
      return GetMaterialApp(
        title: 'CTS',
        locale: LocalizationService.locale,
        initialBinding: AllBindings(),
        translations: LocalizationService(),
        fallbackLocale: LocalizationService.fallbackLocale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            headline2: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
            headline3: TextStyle(fontSize: 14, fontStyle: FontStyle.normal),
          ).apply(
            bodyColor:
                createMaterialColor(Get.find<MController>().appcolor // AppColor
                    //Color.fromRGBO(96, 175, 189, 1),
                    ),
            displayColor: createMaterialColor(
                Get.find<MController>().appcolor //      AppColor
                ),
          ),
          fontFamily: "Bahij_light",
          primarySwatch:
              createMaterialColor(Get.find<MController>().appcolor //  AppColor
                  ),
        ),
        getPages: [
          GetPage(name: "/", page: () =>
              LoginPage(),
              // LandingPage(),
              // InboxPage(),
              middlewares: [AuthMiddleWare()]), //SearchPage
          GetPage(
              name: "/Landing", //SearchPage(),// LandingPage()
              page: () => LandingPage(),
              transition: Transition.rightToLeft),

          GetPage(
              name: "/Filter", //
              page: () => FilterSlidePage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/InboxPage",
              page: () => InboxPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/DocumentPage",
              page: () => DocumentPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/OpenPDFFile",
              page: () => OpenPDFFile(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/SignaturePage",
              page: () => SignaturePage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/SearchPageResult",
              page: () => SearchPageResult(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/WebViewPage",
              page: () => WebViewPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/SearchPage",
              page: () => SearchPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/MyPocketsScreen",
              page: () => MyPocketsScreen(),
              transition: Transition.rightToLeft)
        ], //initialRoute:"/" ,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
    });
  }
}
