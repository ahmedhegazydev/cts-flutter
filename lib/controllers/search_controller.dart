import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/apis/get_lookups_api.dart';
import '../services/apis/search_correspondences_api.dart';
import '../services/json_model/get_lookups_model.dart';
//import '../services/json_model/login_model.dart'as userdata;
import '../services/json_model/search_correspondences_model.dart';
import '../services/models/LoginModel.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class SearchController extends GetxController {
  BuildContext? context;
  final GetLookupsApi _getLookupsApi = GetLookupsApi();
  final SearchCorrespondencesApi _searchCorrespondencesApi=SearchCorrespondencesApi();

  SearchCorrespondencesModel? searchCorrespondencesModel ;
  final SecureStorage _secureStorage = SecureStorage();
  late GetLookupsModel getLookupsModel;
   List<DocCountries>? countries = [];

  List<Classifications> classifications=[];

  List<PrimaryClassifications>? primaryClassifications=[];

String fromDocDate="From";
  String toDocDate="To";



  Map<String,dynamic>serachData={};

  List<Priorities?>? priorities;
  Priorities? prioritieVal;
  List< Privacies?>? privacies;
  Privacies? privacieVal;
  List<Statuses?>? statuses;
  Statuses?statuseVal;


  TextEditingController textEditingControllerReferenceNumber=TextEditingController();
  TextEditingController textEditingControllerSubject=TextEditingController();
  TextEditingController textEditingControllerFrom=TextEditingController();
  TextEditingController textEditingControllerTo=TextEditingController();
  TextEditingController textEditingControllerTransferFrom=TextEditingController();
  TextEditingController textEditingControllerTransferTo=TextEditingController();
  TextEditingController textEditingControllerDocData=TextEditingController();
  TextEditingController textEditingControllerdocCountrieVal=TextEditingController();
  TextEditingController textEditingControllerclassificationsVal=TextEditingController();
  TextEditingController textEditingControllerprimaryClassificationsVal=TextEditingController();
  setPrioritieVal(Priorities? prioritie){
    prioritieVal=prioritie;
    serachData["Priority"]=prioritie?.id;
    update();
  }

  setPrivacieVal(Privacies? privacie){
    privacieVal=privacie;
    serachData["Privacy"]=privacie?.id;
    update();
  }

  setStatuseVal(Statuses? statuse){
    statuseVal=statuse;

    serachData["Status"]=statuse?.id;
    update();
  }



formReset(){
  // setDocCountrieVal(null);
  // setClassificationsVal(null);
  // setprimaryClassificationsVal(null);

    fromDocDate="";
    toDocDate="";

    textEditingControllerReferenceNumber.clear();
   textEditingControllerSubject.clear();
   textEditingControllerFrom.clear();
   textEditingControllerTo.clear();
   textEditingControllerTransferFrom.clear();
   textEditingControllerTransferTo.clear();
   textEditingControllerDocData.clear();

      textEditingControllerdocCountrieVal.clear();
      textEditingControllerclassificationsVal.clear();
      textEditingControllerprimaryClassificationsVal.clear();
}



  Future<void> selectFromDocDate({required BuildContext context  }) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null ){
      fromDocDate = pickedDate.toString().substring(0, 10);
      serachData["FromDocumentDate"]=fromDocDate;
      update();
    }

  }




  Future<void> selectToDocDate({required BuildContext context  }) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null ){
      toDocDate = pickedDate.toString().substring(0, 10);
serachData["ToDocumentDate"]=toDocDate;
      update();
    }

  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onInit() {

    super.onInit();
    print("000000000000000000000000000000000000");

    Map <String,dynamic>?logindata=_secureStorage.readSecureJsonData(AllStringConst.LogInData) ;
    LoginModel data=LoginModel.fromJson(logindata!);
    statuses=data.transferData?.statuses ;
    privacies=data.transferData?.privacies ;
    priorities=data.transferData?.priorities ;
    getData();
  }

  getData() {

    _getLookupsApi.data =
        "Token=${_secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    _getLookupsApi.getData().then((value) {
print("this is data $value");
      getLookupsModel = value as GetLookupsModel;

      countries = getLookupsModel.docCountries ?? [];
      classifications = getLookupsModel.classifications ?? [];
      primaryClassifications = getLookupsModel.primaryClassifications ?? [];

      update();
    });
  }



  searchCorrespondences(){


    serachData["Language"]=Get.locale?.languageCode == "en" ? "en" : "ar";

if(textEditingControllerReferenceNumber.text.isNotEmpty){
  serachData["ReferenceNumber"]=textEditingControllerReferenceNumber.text;
}
    if(textEditingControllerSubject.text.isNotEmpty){
      serachData["Subject"]=textEditingControllerSubject.text;
    }
    if(textEditingControllerFrom.text.isNotEmpty){
      serachData["From"]=textEditingControllerFrom.text;
    }
    if(textEditingControllerTo.text.isNotEmpty){
      serachData["To"]=textEditingControllerTo.text;
    }
    if(textEditingControllerTransferFrom.text.isNotEmpty){
      serachData["TransferFrom"]=textEditingControllerTransferFrom.text;
    }
if(textEditingControllerTransferTo.text.isNotEmpty){
  serachData["TransferTo"]=textEditingControllerTransferTo.text;
}
    if(textEditingControllerDocData.text.isNotEmpty){
      serachData["           "]=textEditingControllerDocData.text;
    }
//print(serachData);


//String? token=    _secureStorage.token();
    print(_searchCorrespondencesApi.apiUrl());
   // serachData["Token"]=_secureStorage.token();

    String cr="";
    serachData.forEach((key, value) {
      cr=cr+key+":"+value+";%23";
    });
  _searchCorrespondencesApi.post(
      {"Token":"oeXQq9ZIRfAahZs9UpXg","Criteria":"ReferenceNumber:2021//;%23","IsAdvanced":1,"Language":"ar"}).then((value) {

    print("pp");
    print(value);
    print("pp");
  });
  }


}