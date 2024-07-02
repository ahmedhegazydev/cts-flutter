import 'package:get/get.dart';

import '../controllers/signature_Controller.dart';
 

class  SignaturePageBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(  SignaturePageController(),permanent: true) ;
  }
}
