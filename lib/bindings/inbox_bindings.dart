import 'package:get/get.dart';

import '../controllers/inbox_controller.dart';
 

class InboxBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(  InboxController(),permanent: true) ;
  }
}
