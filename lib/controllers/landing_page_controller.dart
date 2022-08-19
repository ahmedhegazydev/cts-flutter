
import 'package:get/get.dart';


import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'document_controller.dart';

class LandingPageController extends GetxController{
  final SecureStorage _secureStorage=Get.find<SecureStorage>();

  Map <String,dynamic>?_logindata;
  LoginModel? data ;
  @override
  void onReady() {
    super.onReady();
    _logindata  =_secureStorage.readSecureJsonData(AllStringConst.LogInData)  ;
    data=LoginModel.fromJson(_logindata!);
   // getFindRecipientData();



   // Get.find<SearchController>().getAllData();
Get.find<DocumentController>().getFindRecipientData();
  }

  String userName(){
    String? name=_secureStorage.readSecureData(AllStringConst.FirstName);
return name??"";
  }
}