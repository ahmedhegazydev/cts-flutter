import 'package:get/get.dart';

import '../controllers/search_controller.dart';
import '../controllers/search_page_result_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
    Get.put(SearchPageResultController());
  }
}
