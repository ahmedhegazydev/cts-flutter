import 'package:cts/controllers/my_cart/create_basket_controller.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/search_controller.dart';
import '../controllers/search_page_result_controller.dart';
import '../controllers/signature_Controller.dart';
import '../controllers/web_view_controller.dart';
import '../utility/storage.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SecureStorage());
    Get.lazyPut(() => LandingPageController());
    Get.put(DocumentController(), permanent: true);

    Get.put(LoginController());
    Get.put(InboxController(), permanent: true);
    Get.put(CreateBasketController());

    Get.lazyPut(() => SearchController(),fenix: true );

    Get.lazyPut(()=>  SignaturePageController(),fenix: true  );
    Get.lazyPut(()=>  WebViewPageController() ,fenix: true  );
    Get.lazyPut(()=>  SearchPageResultController() ,fenix: true  );

    Get.lazyPut(()=>  BasketController(),fenix: true  );
    //MyPocketsController
    // Get.putAsync<SecureStorage>(()async => await SecureStorage());

  }
}

