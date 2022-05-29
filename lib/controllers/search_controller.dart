import 'package:cts/controllers/search_page_result_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/CorrespondencesModel.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/get_lookups_api.dart';
import '../services/apis/search_correspondences_api.dart';

import '../services/json_model/find_recipient_json.dart';
import '../services/json_model/get_lookups_model.dart';

import '../services/json_model/search_correspondences_model.dart';
import '../services/models/LoginModel.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class SearchController extends GetxController {
  FindRecipientModel? findRecipientModel;
  final FindRecipient _findRecipient = FindRecipient();

  List<Destination> users = [];
  List<Destination> usersWillSendTo = [];

  bool getSerchData = false;

  BuildContext? context;
  final GetLookupsApi _getLookupsApi = GetLookupsApi();
  final SearchCorrespondencesApi _searchCorrespondencesApi =
      SearchCorrespondencesApi();

  SearchCorrespondencesModel? searchCorrespondencesModel;

  final SecureStorage _secureStorage = SecureStorage();
  late GetLookupsModel getLookupsModel;
  List<DocCountries>? countries = [];

  List<Classifications> classifications = [];

  List<PrimaryClassifications>? primaryClassifications = [];

  // String fromDocDate = "";
  // String toDocDate = "";

  Map<String, dynamic> serachData = {};

  List<Priorities?>? priorities;
  Priorities? prioritieVal;
  List<Privacies?>? privacies;
  Privacies? privacieVal;
  List<Statuses?>? statuses;
  Statuses? statuseVal;

  TextEditingController textEditingControllerReferenceNumber1 =
      TextEditingController();
  TextEditingController textEditingControllerReferenceNumber2 =
      TextEditingController();
  TextEditingController textEditingControllerReferenceNumber3 =
      TextEditingController();
  TextEditingController textEditingControllerSubject = TextEditingController();
  TextEditingController textEditingControllerFrom = TextEditingController();
  TextEditingController textEditingControllerTo = TextEditingController();
  TextEditingController textEditingControllerTransferFrom =
      TextEditingController();
  TextEditingController textEditingControllerTransferTo =
      TextEditingController();

  TextEditingController textEditingControllerFromDocDate = TextEditingController();
  TextEditingController textEditingControllerToDocDate = TextEditingController();


  TextEditingController textEditingControllerDocData = TextEditingController();


  TextEditingController textEditingControllerdocCountrieVal =
      TextEditingController();
  DocCountries? countrieVal;


  TextEditingController textEditingControllerClassificationsVal =
      TextEditingController();



  Classifications? classificationsVal;
  TextEditingController textEditingControllerprimaryClassificationsVal =
      TextEditingController();
  PrimaryClassifications? primaryClassificationval;






  setPrioritieVal(Priorities? prioritie) {
    prioritieVal = prioritie;
    serachData["Priority"] = prioritie?.id;
    update();
  }

  setPrivacieVal(Privacies? privacie) {
    privacieVal = privacie;
    serachData["Privacy"] = privacie?.id;
    update();
  }

  setStatuseVal(Statuses? statuse) {
    statuseVal = statuse;

    serachData["Status"] = statuse?.id;
    update();
  }

// لسته الافراد الي اختار منهم في البحث
  listOfUser(int pos) {
    users = findRecipientModel?.sections?[pos].destination ?? [];
    update();
  }

//الحصور علي جميع الافراد
  getFindRecipientData() {
    _findRecipient.data =
        "Token=${_secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    _findRecipient.getData().then((value) {
      findRecipientModel = value as FindRecipientModel;
      listOfUser(0);
      //print(findRecipientModel?.toJson() );
    });
  }

  formReset() {
    // setDocCountrieVal(null);
    // setClassificationsVal(null);
    // setprimaryClassificationsVal(null);

    // fromDocDate = "";
    // toDocDate = "";

    textEditingControllerReferenceNumber1.clear();
    textEditingControllerReferenceNumber2.clear();
    textEditingControllerReferenceNumber3.clear();
    textEditingControllerSubject.clear();
    textEditingControllerFrom.clear();
    textEditingControllerTo.clear();
    textEditingControllerTransferFrom.clear();
    textEditingControllerTransferTo.clear();
    textEditingControllerDocData.clear();

    textEditingControllerdocCountrieVal.clear();
    textEditingControllerClassificationsVal.clear();
    textEditingControllerprimaryClassificationsVal.clear();
  }

  Future<void> selectFromDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      textEditingControllerFromDocDate.text = pickedDate.toString().substring(0, 10);

      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(pickedDate);
      serachData["FromDocumentDate"] =
          outputDate.toString(); //fromDocDate.toString();
      update();
    }
  }

  Future<void> selectToDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      textEditingControllerToDocDate.text = pickedDate.toString().substring(0, 10);
      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(pickedDate);
      serachData["ToDocumentDate"] = outputDate;
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
    textEditingControllerReferenceNumber1.text =
        DateTime.now().toString().substring(0, 4);

    Map<String, dynamic>? logindata =
        _secureStorage.readSecureJsonData(AllStringConst.LogInData);
    LoginModel data = LoginModel.fromJson(logindata!);
    statuses = data.transferData?.statuses;
    privacies = data.transferData?.privacies;
    priorities = data.transferData?.priorities;
    getFindRecipientData();
    //getData();
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

  searchCorrespondences() {
    getSerchData = true;
    update();
    // String rf = "";
    //
    // if (textEditingControllerReferenceNumber1.text.isNotEmpty) {
    //   rf += textEditingControllerReferenceNumber1.text + "/";
    // }
    //
    // if (textEditingControllerReferenceNumber2.text.isNotEmpty) {
    //   rf += textEditingControllerReferenceNumber2.text + "/";
    // } else {
    //   rf += "/";
    // }
    // if (textEditingControllerReferenceNumber3.text.isNotEmpty) {
    //   rf += textEditingControllerReferenceNumber3.text;
    // }
    //
    // serachData["ReferenceNumber"] = rf;
    // if (textEditingControllerSubject.text.isNotEmpty) {
    //   serachData["Subject"] = textEditingControllerSubject.text;
    // }
    // if (textEditingControllerFrom.text.isNotEmpty) {
    //   serachData["From"] = textEditingControllerFrom.text;
    // }
    // if (textEditingControllerTo.text.isNotEmpty) {
    //   serachData["To"] = textEditingControllerTo.text;
    // }
    // if (textEditingControllerTransferFrom.text.isNotEmpty) {
    //   serachData["TransferFrom"] = textEditingControllerTransferFrom.text;
    // }
    // if (textEditingControllerTransferTo.text.isNotEmpty) {
    //   serachData["TransferTo"] = textEditingControllerTransferTo.text;
    // }
    // if (textEditingControllerDocData.text.isNotEmpty) {
    //   serachData["           "] = textEditingControllerDocData.text;
    // }



    String cr =
        "ReferenceNumber:${textEditingControllerReferenceNumber1.text}/${textEditingControllerReferenceNumber2.text}/${textEditingControllerReferenceNumber2.text};%23Subject:${textEditingControllerSubject.text};%23From:${textEditingControllerFrom.text};%23To:${textEditingControllerTo.text};%23TransferFrom:;%23TransferTo:;%23Privacy:${privacieVal?.id??""};%23Priority:${prioritieVal?.id??""};%23Status:${statuseVal?.id??""};%23Country:${countrieVal?.id??""};%23Classification:${classificationsVal?.id??""};%23PrimaryClassification:${primaryClassificationval?.iD??""};%23FromDocumentDate:${textEditingControllerFromDocDate.text};%23ToDocumentDate:${textEditingControllerToDocDate.text};%23RegisterDate:;%23";

    print(cr);
    _searchCorrespondencesApi.post({
      "Token": "${_secureStorage.token()}",
      "Criteria":cr,      "IsAdvanced": 1,
      "Language": Get.locale?.languageCode == "en" ? "en" : "ar"
    }).then((value) {
      searchCorrespondencesModel = value as SearchCorrespondencesModel;

      if ((searchCorrespondencesModel?.correspondences?.length ?? 0) < 1) {
        Get.snackbar("", "emptylist".tr);
      } else {
        Get.find<SearchPageResultController>().correspondences=searchCorrespondencesModel?.correspondences!??[] ;
        print( Get.find<SearchPageResultController>().correspondences.length);



        Get.toNamed("SearchPageResult");
        /// ToDo go to list of reslt
        ///
        ///
      }

      print("pp");
      print(searchCorrespondencesModel?.toJson());
      print("pp");
      getSerchData = false;
      update();
    });
  }

// {"Token":"oeXQq9ZIRfAahZs9UpXg","Criteria":"ReferenceNumber:2020//;%23Subject:;%23From:;%23To:;%23TransferFrom:;%23TransferTo:;%23Privacy:;%23Priority:;%23Status:;%23Country:;%23Classification:;%23PrimaryClassification:;%23FromDocumentDate:;%23ToDocumentDate:;%23RegisterDate:;%23","IsAdvanced":1,"Language":"ar"}

}
