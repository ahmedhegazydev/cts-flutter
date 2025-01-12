import 'package:cts/screens/Login_page.dart';
import 'package:cts/screens/my_cart/MyPocketsScreen.dart';
import 'package:cts/screens/web_view_page.dart';
import 'package:cts/screens/filter/FilterSideScreen.dart';
import 'package:cts/utility/Extenstions.dart';
import 'package:cts/utility/all_string_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/document_controller.dart';
import 'translation/trans.dart';
import 'bindings/busket_bindings.dart';
import 'bindings/inbox_bindings.dart';
import 'bindings/landing_page_bindings.dart';
import 'bindings/login_bindings.dart';
import 'bindings/search_bindings.dart';
import 'bindings/signatuer_bindings.dart';
import 'controllers/main_controller.dart';
import 'data/SettingsFields.dart';
import 'db/cts_database.dart';
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
import 'viewer/controllers/viewerController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  // SecureStorage secureStorage = SecureStorage();

  Get.put(MController());
  if (isPhone()) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((value) => runApp(MyApp()));
  }
  runApp(MyApp());
}

bool isPhone() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put<ViewerController>(ViewerController());
    Get.put<SecureStorage>(SecureStorage());
    Get.put<DocumentController>(DocumentController());

    Color savedColor_ = Get.find<MController>().appcolor;
    getSavedColorFromDatabase()
        .then((savedColor) => {savedColor_ = savedColor});
    return GetBuilder<MController>(builder: (logic) {
      return GetMaterialApp(
        // navigatorKey: NavigationService.navigatorKey, // set property
        title: 'CTS',
        locale: getSavedLocale(),
        translations: LocalizationService(),
        // initialBinding: AllBindings(),
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
            // bodyColor: createMaterialColor(Get.find<MController>().appcolor) ,
            // displayColor: createMaterialColor(Get.find<MController>().appcolor) ,
            bodyColor: createMaterialColor(
                Get.find<MController>().changeColorImmediately
                    ? savedColor_
                    : Get.find<MController>().appcolor),
            displayColor: createMaterialColor(
                Get.find<MController>().changeColorImmediately
                    ? savedColor_
                    : Get.find<MController>().appcolor),
          ),
          fontFamily: "Bahij_light",
          // primarySwatch: createMaterialColor(Get.find<MController>().appcolor) ,
          primarySwatch: createMaterialColor(
              Get.find<MController>().changeColorImmediately
                  ? savedColor_
                  : Get.find<MController>().appcolor),
        ),
        //initialRoute: "/SearchPage",
        initialRoute: "/LoginPage",
        getPages: [
          GetPage(
            name: "/LoginPage",
            binding: LoginBinding(),
            page: () => LoginPage(),
            middlewares: [AuthMiddleWare()],
          ),

          //  binding: DetailsChallengesSubscriptionBinding()), //SearchPage
          GetPage(
              name: "/Landing", //SearchPage(),// LandingPage()
              page: () => LandingPage(),
              transition: Transition.rightToLeft,
              binding: LandingPageBinding()),
          GetPage(
              name: "/Filter", //
              page: () => FilterSlidePage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/InboxPage",
              page: () => InboxPage(),
              binding: InboxBinding(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/DocumentPage",
              page: () => DocumentPage(),
              //  binding: DocumentBinding(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/OpenPDFFile",
              page: () => OpenPDFFile(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/SignaturePage",
              page: () => SignaturePage(),
              binding: SignaturePageBinding(),
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
              binding: SearchBinding(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/MyPocketsScreen",
              page: () => MyPocketsScreen(),
              binding: BasketPageBinding(),
              transition: Transition.rightToLeft)
        ], //initialRoute:"/" ,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
    });
  }

  getSavedLocale() {
    SecureStorage secureStorage = SecureStorage();
    String? appLan = SecureStorage.to.readSecureData(AllStringConst.AppLan);
    if (appLan == null) {
      return LocalizationService.locale;
    } else {
      if (appLan == "ar") {
        return Locale('ar');
      } else {
        return Locale('en');
      }
    }
  }

  Future<Color> getSavedColorFromDatabase() async {
    List<SettingItem> settingItems =
        await CtsSettingsDatabase.instance.readAllNotes();
    Color? color;
    if (settingItems.isNotEmpty) {
      color = settingItems[0].color.toColor();
      Get.find<MController>().setChangeColorImmediately(true);
    } else {
      color = Get.find<MController>().appcolor;
    }
    // return createMaterialColor(color!);
    return color!;
  }
}
