import 'package:get/get.dart';

import '../controllers/landing_page_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(  SearchController()) ;
  }
}
