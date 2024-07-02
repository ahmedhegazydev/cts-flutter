import 'package:get/get.dart';

import '../controllers/basket_controller.dart';

class BasketPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BasketController(), fenix: true);
  }
}
