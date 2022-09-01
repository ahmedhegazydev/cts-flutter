import 'package:get/get.dart';

import '../controllers/landing_page_controller.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(  LoginController()) ;
  }
}
