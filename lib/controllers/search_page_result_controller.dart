import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/can_open_document.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class SearchPageResultController extends GetxController{
  ScrollController scrollController = ScrollController();
  final SecureStorage _secureStorage = SecureStorage();
  Map <String,dynamic>?logindata;
  CanOpenDocumentApi canOpenDocumentApi = CanOpenDocumentApi();
  List<Correspondences> correspondences = [];
  List<CustomActions>? customActions=[];




  onDismissed(DismissDirection direction ) {




  }



  Future<void> onRefresh() async {

  }






  canOpenDoc({required correspondenceId, required transferId}) {
    canOpenDocumentApi.data =
    "Token=${_secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    canOpenDocumentApi.getData().then((value) {



      FindRecipientModel findRecipientModel = value as FindRecipientModel;

    });
  }
  @override
  void onReady() {
    super.onReady();




    logindata=_secureStorage.readSecureJsonData(AllStringConst.LogInData) ;
    if(logindata!=null){
      LoginModel data=LoginModel.fromJson(logindata!);
      customActions=data.customActions;
    }


  }
}