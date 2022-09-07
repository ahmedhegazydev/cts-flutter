import 'package:get/get.dart';

import '../controllers/landing_page_controller.dart';
import '../controllers/my_cart/create_basket_controller.dart';
import '../controllers/web_view_controller.dart';

class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
     Get.put( LandingPageController(),permanent: true) ;
     Get.put(CreateBasketController(),permanent: true);

     Get.put(WebViewPageController());

  }
}
