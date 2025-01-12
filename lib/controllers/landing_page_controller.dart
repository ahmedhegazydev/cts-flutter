import 'package:cts/utility/utilitie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../services/apis/basket/add_edit_basket_result _api.dart';
import '../services/apis/basket/getFetchBasketList_api.dart';
import '../services/apis/basket/get_gasket_inbox_api.dart';
import '../services/apis/basket/remove_basket_api.dart';
import '../services/apis/basket/reorder_baskets_result _api.dart';
import '../services/apis/dashboard_stats_result_api.dart';
import '../services/apis/favorites/AddFavoriteRecipients_api.dart';
import '../services/apis/favorites/ListFavoriteRecipients_api.dart';
import '../services/apis/favorites/RemoveFavoriteRecipients_api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/get_my_routing_settings_api.dart';
import '../services/apis/remove_my_routing_settings_api.dart';
import '../services/apis/save_my_routing_settings_api.dart';
import '../services/json_model/basket/add_edit_basket_flag_model.dart';
import '../services/json_model/basket/fetch_basket_list_model.dart';
import '../services/json_model/basket/get_basket_inbox_model.dart';
import '../services/json_model/basket/remove_basket_request_model.dart';
import '../services/json_model/basket/reorder_baskets_request_model.dart';
import '../services/json_model/dashboard_stats_result_model.dart';
import '../services/json_model/favorites/add/AddFavoriteRecipients_request.dart';
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_response.dart';
import '../services/json_model/favorites/remove/RemoveFavoriteRecipients_request.dart';
import '../services/json_model/find_recipient_model.dart';

import '../services/json_model/login_model.dart';
import '../services/json_model/my_transfer_routing_dto_model.dart';
import '../services/json_model/my_transfer_routing_dto_result.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'document_controller.dart';

class LandingPageController extends GetxController {
  bool isSavingOrder = false;
  bool setSelectSuggestion = false;

  TextEditingController textEditingControllerEnglishName =
      TextEditingController();
  TextEditingController textEditingControllerArabicName =
      TextEditingController();

  TextEditingController textEditingControllerTo = TextEditingController();
  TextEditingController textEditingControllerTorouting =
      TextEditingController();
  TextEditingController textEditingControllerToroutingReson =
      TextEditingController();

  List<Destination> users = [];
  List<Destination> selectFavusers = [];
  Destination? toSaveMyRoutingSettings;

  Destination? to;

  int? oldIndex = 0;
  int? newIndex = 0;
  setOldIndex(int oldIndex) {
    this.oldIndex = oldIndex;
    update();
  }

  setNewIndex(int newIndex) {
    this.newIndex = newIndex;
    update();
  }

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

  Future getFindRecipientData({required context}) async {
    final FindRecipient _findRecipient = FindRecipient(context);
    _findRecipient.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await _findRecipient.getData().then((value) {
      findRecipientModel = value as FindRecipientModel;
      listOfUser(0);
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

  SaveMyRoutingSettingsusers(Destination destination) {
    selectFavusers.remove(destination);
    update();
  }

  DashboardStatsResultModel? dashboardStatsResultModel;
  getDashboardStats({context}) {
    DashboardStatsResultApi dashboardStatsResultApi = DashboardStatsResultApi();
    dashboardStatsResultApi.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    dashboardStatsResultApi.getData().then((value) {
      dashboardStatsResultModel = value as DashboardStatsResultModel;
      update();
    });
  }

  Future<DashboardStatsResultModel> getDashboardStatsAsync({context}) async {
    DashboardStatsResultApi dashboardStatsResultApi = DashboardStatsResultApi();
    dashboardStatsResultApi.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    var value = await dashboardStatsResultApi.getData();
    return value as DashboardStatsResultModel;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getDashboardStats();
    _logindata = SecureStorage.to.readSecureJsonData(AllStringConst.LogInData);
    if (_logindata != null) {
      data = LoginModel.fromJson(_logindata!);
    }
    getFindRecipientData(context: null);
    listFavoriteRecipients(context: null);
    Get.put<DocumentController>(DocumentController())
        .getFindRecipientData(context: null);
  }

  String userName() {
    String? name = SecureStorage.to.readSecureData(AllStringConst.FirstName);
    return name ?? "";
  }

  Future addEditBasket({context, required Baskets basket}) async {
    AddEditBasketFlagApi _addEditBasketFlagApi = AddEditBasketFlagApi(context);
    BasketDto basketDto = new BasketDto(
        Color: basket.color,
        Name: basket.name,
        NameAr: basket.nameAr,
        ID: 0,
        //=========
        CanBeReOrder: false,
        OrderBy: basket.orderBy,
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
      Navigator.pop(context);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.lightGreen,
          icon: Container(),
          message: "BasketAddedSuccess".tr,
        ),
      );

      // showLoaderDialog(context);
      // getFetchBasketList(context: context);
    });
    update();
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
      Navigator.pop(context);
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
      Navigator.pop(context);
      // Get.back();
      // onSuccess(value.toString());
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.lightGreen,
          icon: Container(),
          message: "BasketDeletedSuccess".tr,
        ),
      );
    });
    getFetchBasketList(context: context);
    //  update();
  }

  TextEditingController textEditingControllerFromDate = TextEditingController();
  DateTime? pickedDateselectFromDocDate;
  Future<void> selectFromDocDate({required BuildContext context}) async {
    pickedDateselectFromDocDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDateselectFromDocDate != null) {
      if (DateTime.now().day.compareTo(pickedDateselectFromDocDate!.day) > 0) {
        print("object");
        Get.snackbar("", "تاريخ البداء لا يمكن ان يكون اقل من اليوم");
      } else {
        var outputFormat = DateFormat('dd/MM/yyyy');
        var outputDate = outputFormat.format(pickedDateselectFromDocDate!);
        textEditingControllerFromDate.text =
            outputDate.toString().substring(0, 10);
        update();
      }
    }
  }

  TextEditingController textEditingControllerToDate = TextEditingController();
  Future<void> selectToDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      if (pickedDateselectFromDocDate == null) {
        return;
      }
      if (pickedDate.compareTo(pickedDateselectFromDocDate!) == 0 ||
          pickedDate.compareTo(pickedDateselectFromDocDate!) < 0) {
        Get.snackbar("", "لا يمكن ان يكون تاريخ البدا اكبر من تاريخ الانتهاء");
      } else {
        var outputFormat = DateFormat('dd/MM/yyyy');
        var outputDate = outputFormat.format(pickedDate);
        textEditingControllerToDate.text =
            outputDate.toString().substring(0, 10);

        update();
      }
    }
  }

  MyTransferRoutingDto? getMyRoutingSettingsModel;
  getMyRoutingsettings(context) {
    GetMyRoutingsettingsApi getMyRoutingsettingsApi =
        GetMyRoutingsettingsApi(context);
    getMyRoutingsettingsApi.data = "Token=${secureStorage.token()}";
    getMyRoutingsettingsApi.getData().then((value) {
      getMyRoutingSettingsModel = value as MyTransferRoutingDto;

      textEditingControllerTo.text =
          getMyRoutingSettingsModel?.routing?.name ?? "";
      textEditingControllerToDate.text =
          getMyRoutingSettingsModel?.routing?.crtToDate ?? "";
      textEditingControllerFromDate.text =
          getMyRoutingSettingsModel?.routing?.crtFromDate ?? "";
      textEditingControllerTorouting.text =
          getMyRoutingSettingsModel?.routing?.name ?? "";
      textEditingControllerToroutingReson.text =
          getMyRoutingSettingsModel?.routing?.crtComments ?? "";
    });
  }

  Future postSaveMyRoutingSettingsApi(
      {required MyTransferRoutingRequestDto data, context}) async {
    SaveMyRoutingSettingsApi getMyRoutingsettingsApi =
        SaveMyRoutingSettingsApi(context);

    await getMyRoutingsettingsApi.post(data.toMap()).then((value) {
      Navigator.pop(context);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.lightGreen,
          icon: Container(),
          message: "DoneDelegation".tr,
        ),
      );
    });
  }

  Future removeMyRoutingSettings({data, context}) async {
    RemoveMyRoutingSettingsApi removeMyRoutingSettingsApi =
        RemoveMyRoutingSettingsApi(context);

    await removeMyRoutingSettingsApi.post(data).then((value) {
      Navigator.pop(context);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.lightGreen,
          icon: Container(),
          message: "DeletedDelegation".tr,
        ),
      );
    });
  }

  // getDashboardStatsLocalJson() async {
  //   final jsondata = await rootBundel.rootBundle
  //       .loadString("assets/json/dashboard.json");
  //   dashboardStatsResultModel =
  //       DashboardStatsResultModel.fromJson(json.decode(jsondata));
  //
  //   update();
  // }

  /**
   * mofa-favorite-recipients-api (1)
   */
  Future listFavoriteRecipients({context}) async {
    ListFavoriteRecipientsApi listFavoriteRecipientsApi =
        ListFavoriteRecipientsApi(context);
    listFavoriteRecipientsApi.data =
        "Token=${secureStorage.token()}&Language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await listFavoriteRecipientsApi.getData().then((value) {
      if (setSelectSuggestion) {
        Navigator.pop(context);
      }
      if (value != null) {
        favoriteRecipientsResponse = value as ListFavoriteRecipientsResponse;
      } else {
        Get.snackbar("", "err".tr);
      }
      // print("listFavoriteRecipientsApi  =>${favoriteRecipientsResponse?.recipients[0].targetPhotoBs64.isEmpty}");
    });
    update();
  }

  Future removeFavoriteRecipients({context, favoriteRecipients}) async {
    RemoveFavoriteRecipientsApi removeFavoriteRecipientsApi =
        RemoveFavoriteRecipientsApi(context);
    RemoveFavoriteRecipientsRequest reorderBasketsRequest =
        RemoveFavoriteRecipientsRequest(
      ids: [favoriteRecipients],
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: secureStorage.token()!,
    );
    await removeFavoriteRecipientsApi
        .post(reorderBasketsRequest.toMap())
        .then((value) {
      Navigator.pop(context);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Colors.lightGreen,
          // icon: const Icon(
          //   Icons.check,
          //   color: const Color(0x15000000),
          //   size: 50,
          // ),
          // backgroundColor: "#94C973".toColor(),
          icon: Container(),
          message: "DeletedSuccess".tr,
        ),
      );
      listFavoriteRecipients(context: context);

      print(value);
      print("removeFavoriteRecipientsApi");
    });
  }

  Future addFavoriteRecipients({context, required int addFavorite}) async {
    AddFavoriteRecipientsApi addFavoriteRecipientsApi =
        AddFavoriteRecipientsApi(context);
    AddFavoriteRecipientsRequest addFavoriteRequest =
        AddFavoriteRecipientsRequest(
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: secureStorage.token()!,
      TargetGctId: addFavorite,
    );
    await addFavoriteRecipientsApi
        .post(addFavoriteRequest.toMap())
        .then((value) {
      Navigator.pop(context);

      showLoaderDialog(context);
      setSelectSuggestion = true;
      listFavoriteRecipients(context: context);

      print(value);
      print("addFavoriteRecipientsApi");
    });
  }

  FetchBasketListModel? fetchBasketListModel;
  GetBasketInboxModel? getBasketInboxModel;
  Future getFetchBasketList({required BuildContext? context}) async {
    print(
        "getFetchBasketListgetFetchBasketListgetFetchBasketListgetFetchBasketList");
    GetFetchBasketListApi getFetchBasketListApi =
        GetFetchBasketListApi(context);
    getFetchBasketListApi.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await getFetchBasketListApi.getData().then((value) {
      Navigator.pop(context!);

      if (value != null) {
        fetchBasketListModel = value as FetchBasketListModel;
        // fetchBasketListModel?.baskets?.forEach((element) {
        //   element.orderBy = Random().nextInt(100);
        // });
        fetchBasketListModel?.baskets?.sort();
      } else {
        // Get.snackbar("", "err".tr);
      }

      update();
      print(fetchBasketListModel?.toJson());
      print("getFetchBasketList i getit");
    });
    update();
  }

  getBasketInbox(
      {required context,
      required int id,
      int pageSize = 20,
      int pageNumber = 0}) {
    GetBasketInboxApi getBasketInboxApi = GetBasketInboxApi(context);

    getBasketInboxApi.data =
        "token=${secureStorage.token()}&basketId=$id&pageNumber=$pageNumber&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";

    getBasketInboxApi.getData().then((value) {
      if (value != null) {
        getBasketInboxModel = value as GetBasketInboxModel;

        if ((getBasketInboxModel?.correspondences?.length ?? 0) < pageSize) {
          // haveMoreData=false;
        }
      } else {
        Get.snackbar("", "err".tr);
      }

      update();
      // print(a.toJson());
    });
  }

  void setSelectSuggest(bool setSelectSuggestion) {
    this.setSelectSuggestion = setSelectSuggestion;
    update();
  }
}
