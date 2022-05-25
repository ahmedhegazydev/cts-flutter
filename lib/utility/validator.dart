import 'package:get/get.dart';

class Validators{
String?  passWordValidator(String? v){
    if(v==null||v.isEmpty){
      return "loginInfo".tr;
    }
    return null;
  }
String?  userNameValidator(String? v){
  if(v==null||v.isEmpty){
    return "loginInfo".tr;
  }
  return null;
}

}