import 'dart:convert';

import 'package:cts/controllers/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../services/apis/basket/add_edit_basket_result _api.dart';
import '../services/apis/basket/remove_basket_api.dart';
import '../services/apis/basket/reorder_baskets_result _api.dart';
import '../services/apis/dashboard_stats_result_api.dart';
import '../services/apis/favorites/AddFavoriteRecipients_api.dart';
import '../services/apis/favorites/ListFavoriteRecipients_api.dart';
import '../services/apis/favorites/RemoveFavoriteRecipients_api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/get_correspondences_api.dart';
import '../services/apis/get_my_routing_settings_api.dart';
import '../services/apis/remove_my_routing_settings_api.dart';
import '../services/apis/remove_my_routing_settings_api.dart';
import '../services/apis/save_my_routing_settings_api.dart';
import '../services/json_model/basket/add_edit_basket_flag_model.dart';
import '../services/json_model/basket/remove_basket_request_model.dart';
import '../services/json_model/basket/reorder_baskets_request_model.dart';
import '../services/json_model/dashboard_stats_result_model.dart';
import '../services/json_model/favorites/add/AddFavoriteRecipients_request.dart';
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_request.dart';
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_response.dart';
import '../services/json_model/favorites/remove/RemoveFavoriteRecipients_request.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';


import '../services/json_model/get_my_routing_settings_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/my_transfer_routing_dto_model.dart';
import '../services/json_model/my_transfer_routing_dto_result.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'document_controller.dart';
import 'package:flutter/services.dart' as rootBundel;
class LandingPageController extends GetxController {
  // final SecureStorage _secureStorage = Get.find<SecureStorage>();
  bool isSavingOrder = false;

  TextEditingController textEditingControllerEnglishName =
      TextEditingController();
  TextEditingController textEditingControllerArabicName =
      TextEditingController();
  TextEditingController textEditingControllerTo = TextEditingController();
  TextEditingController textEditingControllerTorouting = TextEditingController();
  TextEditingController textEditingControllerToroutingReson = TextEditingController();
  List<Destination> users = [];
  List<Destination> selectFavusers = [];
  Destination? toSaveMyRoutingSettings;


  Destination? to;



  FindRecipientModel? findRecipientModel;
  final SecureStorage secureStorage = SecureStorage();

  // AddEditBasketFlagModel? addEditBasketFlagModel;

  // RemoveBasketRequest? removeBasketRequest;

  Map<String, dynamic>? _logindata;
  LoginModel? data;
  BuildContext? context;


  //Favorites
  ListFavoriteRecipientsResponse? favoriteRecipientsResponse;



  setSavingOrder(bool saving) {
    this.isSavingOrder = saving;
    update();
  }

  getFindRecipientData({required context}) async {
    final FindRecipient _findRecipient = FindRecipient(context);
    _findRecipient.data =
    "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await _findRecipient.getData().then((value) {
      findRecipientModel = value as FindRecipientModel;
      listOfUser(0);
      //print(findRecipientModel?.toJson() );
    });
    update();
  }

  listOfUser(int pos) {
    users = findRecipientModel?.sections?[pos].destination ?? [];
    update();
  }

  updateselectFavusers(Destination destination) {
    if (!selectFavusers.contains(destination)) {
      selectFavusers.add(destination);
      update();
    }
  }

  deletselectFavusers(Destination destination) {
    selectFavusers.remove(destination);
    update();
  }



  SaveMyRoutingSettingsusers(Destination destination){
    selectFavusers.remove(destination);
    update();
  }

  DashboardStatsResultModel? dashboardStatsResultModel;
  getDashboardStats({context}){

    DashboardStatsResultApi  dashboardStatsResultApi=DashboardStatsResultApi( );
    dashboardStatsResultApi.data= "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    dashboardStatsResultApi.getData().then((value) {

      dashboardStatsResultModel =value as DashboardStatsResultModel;

print("dashboardStatsResultModel.toJson()   =>    ${dashboardStatsResultModel!.toJson()}");
update();
    });
  }




  @override
  void onReady() {
    super.onReady();
   //getDashboardStats();
    getDashboardStatsLocalJson();
    _logindata = secureStorage.readSecureJsonData(AllStringConst.LogInData);
    data = LoginModel.fromJson(_logindata!);
    // getFindRecipientData();
    getFindRecipientData(context: context);
    //Get.find<SearchController>().getAllData();
    Get.find<DocumentController>().getFindRecipientData(context: context);
  }

  String userName() {
    String? name = secureStorage.readSecureData(AllStringConst.FirstName);
    return name ?? "";
  }

  Future addEditBasket({context, color, nameEn, nameAr}) async {
    AddEditBasketFlagApi _addEditBasketFlagApi = AddEditBasketFlagApi(context);

    BasketDto basketDto = new BasketDto(
        Color: color,
        Name: nameEn,
        NameAr: nameAr,
        ID: 0,
        //=========
        CanBeReOrder: false,
        OrderBy: 0,
        AdminIsDeleted: false,
        isDeleted: false,
        UserGctId: 0);
    AddEditBasketFlagModel addEditBasketFlagModel = AddEditBasketFlagModel(
      token: secureStorage.token(),
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      basketFlag: basketDto,
    );
    await _addEditBasketFlagApi
        .post(addEditBasketFlagModel.toMap())
        .then((value) {
      Navigator.pop(context);
      print(value);
      print("_addEditBasketFlagApi");
    });
  }

  Future reOrderBaskets({context, baskets}) async {
    ReOrderBasketsApi _postReorderBasketsApi = ReOrderBasketsApi(context);
    ReorderBasketsRequest reorderBasketsRequest = ReorderBasketsRequest(
      baskets: baskets,
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: secureStorage.token()!,
    );
    await _postReorderBasketsApi
        .post(reorderBasketsRequest.toMap())
        .then((value) {
      print(value);
      print("_postReorderBasketsApi");
    });
    update();
  }

  Future removeBasket(
      {context, basketId, required Function? onSuccess(String message)}) async {
    PostRemoveBasketApi _postRemoveBasketApi = PostRemoveBasketApi(context);
    RemoveBasketRequest removeBasketRequest = RemoveBasketRequest(
      basketId: basketId,
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: secureStorage.token(),
    );
    await _postRemoveBasketApi.post(removeBasketRequest.toMap()).then((value) {
      print(value);
      // Navigator.pop(context);
      // Get.back();
      onSuccess(value.toString());
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.success(
      //     message:
      //     "Good job, basket have been deleted",
      //   ),
      // );
      print("_postRemoveBasketApi");
    });
    update();
  }

  TextEditingController textEditingControllerFromDate =
      TextEditingController();
  Future<void> selectFromDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {


      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(pickedDate);
      textEditingControllerFromDate.text =
          outputDate.toString().substring(0, 10);
      update();
    }
  }

  TextEditingController textEditingControllerToDate =
      TextEditingController();
  Future<void> selectToDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {

      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(pickedDate);
      textEditingControllerToDate.text =
          outputDate.toString().substring(0, 10);

      update();
    }
  }







  MyTransferRoutingDto? getMyRoutingSettingsModel;
  getMyRoutingsettings(context){
    GetMyRoutingsettingsApi getMyRoutingsettingsApi=GetMyRoutingsettingsApi(context);
    getMyRoutingsettingsApi.data="Token=${secureStorage.token()}";
    getMyRoutingsettingsApi.getData().then((value) {

      getMyRoutingSettingsModel=value as MyTransferRoutingDto;



      textEditingControllerToDate.text=getMyRoutingSettingsModel?.routing?.crtToDate??"";
      textEditingControllerFromDate.text=getMyRoutingSettingsModel?.routing?.crtFromDate??"";
    textEditingControllerTorouting.text=getMyRoutingSettingsModel?.routing?.name??"";
      textEditingControllerToroutingReson.text=getMyRoutingSettingsModel?.routing?.crtComments??"";



      update();
      print ("00000000000000000000000000000000000");
    });
  }

  postSaveMyRoutingSettingsApi({required MyTransferRoutingRequestDto  data,context}){
    SaveMyRoutingSettingsApi getMyRoutingsettingsApi=SaveMyRoutingSettingsApi(context);
print("data.toMap()  =>${data.toMap()}");





    print("*"*50);

    print(jsonEncode(data.toMap()));
print("*"*50);



    getMyRoutingsettingsApi.post(data.toMap()).then((value) {
      print("ljknjsjcnsancsancnsancijoasncoisacs");
    });
  }
  removeMyRoutingSettings({  data,context}){
    RemoveMyRoutingSettingsApi removeMyRoutingSettingsApi=RemoveMyRoutingSettingsApi(context);

print(jsonEncode(data));




    removeMyRoutingSettingsApi.post(data ).then((value) {
      print("ljknjsjcnsancsancnsancijoasncoisacs");
    });
  }


  getDashboardStatsLocalJson() async {
    final jsondata = await rootBundel.rootBundle
        .loadString("assets/json/dashboard.json");
    dashboardStatsResultModel =
        DashboardStatsResultModel.fromJson(json.decode(jsondata));

    update();
  }

  /**
   * mofa-favorite-recipients-api (1)
   */
  Future listFavoriteRecipients({context}) async {
    ListFavoriteRecipientsApi listFavoriteRecipientsApi =
        ListFavoriteRecipientsApi(context);
    listFavoriteRecipientsApi.data =
    "Token=${secureStorage.token()}&Language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await listFavoriteRecipientsApi
        .getData()
        .then((value) {
      favoriteRecipientsResponse = value as ListFavoriteRecipientsResponse;
      print(value);
      print("listFavoriteRecipientsApi");
    });
  }

  Future removeFavoriteRecipients({context, baskets}) async {
    RemoveFavoriteRecipientsApi removeFavoriteRecipientsApi =
        RemoveFavoriteRecipientsApi(context);
    RemoveFavoriteRecipientsRequest reorderBasketsRequest =
        RemoveFavoriteRecipientsRequest(
      ids: [],
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: secureStorage.token()!,
    );
    await removeFavoriteRecipientsApi
        .post(reorderBasketsRequest.toMap())
        .then((value) {
      print(value);
      print("removeFavoriteRecipientsApi");
    });
  }

  Future addFavoriteRecipients({context, baskets}) async {
    AddFavoriteRecipientsApi addFavoriteRecipientsApi =
        AddFavoriteRecipientsApi(context);
    AddFavoriteRecipientsRequest reorderBasketsRequest =
        AddFavoriteRecipientsRequest(
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: secureStorage.token()!,
      TargetGctId: 0,
    );
    await addFavoriteRecipientsApi
        .post(reorderBasketsRequest.toMap())
        .then((value) {
      print(value);
      print("addFavoriteRecipientsApi");
    });
  }
}
