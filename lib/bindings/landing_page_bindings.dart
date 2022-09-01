import 'package:get/get.dart';

import '../controllers/landing_page_controller.dart';
import '../controllers/my_cart/create_basket_controller.dart';

class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
     Get.put( LandingPageController()) ;
     Get.put(CreateBasketController());
  }
}
