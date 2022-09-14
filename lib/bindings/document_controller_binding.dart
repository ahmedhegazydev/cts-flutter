

import 'package:get/get.dart';

import '../controllers/document_controller.dart';

class DocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(  DocumentController(), permanent: true) ;
  }
}
