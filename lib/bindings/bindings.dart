

import 'dart:developer';
import 'dart:ffi';

import 'package:cts/data/controllers/login_controller.dart';
import 'package:get/get.dart';


class AllBindings extends Bindings{
  @override
  void dependencies()async {
    // Get.put(() =>  );
Get.lazyPut(() =>LoginController());
    // Get.putAsync<SecureStorage>(()async => await SecureStorage());

  }

}