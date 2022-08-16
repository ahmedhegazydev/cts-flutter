import 'dart:developer';

import 'package:cts/controllers/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../services/apis/basket/add_edit_basket_result _api.dart';
import '../services/apis/basket/remove_basket_api.dart';
import '../services/apis/basket/reorder_baskets_result _api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/get_correspondences_api.dart';
import '../services/json_model/basket/add_edit_basket_flag_model.dart';
import '../services/json_model/basket/remove_basket_request_model.dart';
import '../services/json_model/basket/reorder_baskets_request_model.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'document_controller.dart';

class LandingPageController extends GetxController{
  final SecureStorage _secureStorage=Get.find<SecureStorage>();


  TextEditingController textEditingControllerEnglishName=TextEditingController();
  TextEditingController textEditingControllerArabicName=TextEditingController();


  AddEditBasketFlagApi _addEditBasketFlagApi = AddEditBasketFlagApi();
  // AddEditBasketFlagModel? addEditBasketFlagModel;

  PostRemoveBasketApi _postRemoveBasketApi = PostRemoveBasketApi();
  // RemoveBasketRequest? removeBasketRequest;

  ReOrderBasketsApi _postReorderBasketsApi = ReOrderBasketsApi();

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

  Future addEditBasket({color, nameEn, nameAr}) async {
    AddEditBasketFlagModel addEditBasketFlagModel =
    AddEditBasketFlagModel(
        Color: color,
        Name: nameEn,
        NameAr: nameAr,
      ID: 0,
    );
    await _addEditBasketFlagApi
        .post(addEditBasketFlagModel.toMap())
        .then((value) {
      print(value);
      print("_addEditBasketFlagApi");
    });
  }

  Future reOrderBaskets({baskets }) async {
    ReorderBasketsRequest reorderBasketsRequest =
    ReorderBasketsRequest(
      baskets: baskets,
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: _secureStorage.token()!,
    );
    await _postReorderBasketsApi
        .post(reorderBasketsRequest.toMap())
        .then((value) {
      print(value);
      print("_postReorderBasketsApi");
    });
  }

  Future removeBasket({basketId }) async {
    RemoveBasketRequest removeBasketRequest =
    RemoveBasketRequest(
      basketId: basketId,
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: _secureStorage.token()!,
    );
    await _postRemoveBasketApi
        .post(removeBasketRequest.toMap())
        .then((value) {
      print(value);
      print("_postRemoveBasketApi");
    });
  }

}