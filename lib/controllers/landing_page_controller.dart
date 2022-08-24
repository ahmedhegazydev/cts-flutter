
import 'package:cts/controllers/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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

class LandingPageController extends GetxController {
  // final SecureStorage _secureStorage = Get.find<SecureStorage>();
  SecureStorage _secureStorage = SecureStorage();
  bool isSavingOrder = false;

  TextEditingController textEditingControllerEnglishName =
      TextEditingController();
  TextEditingController textEditingControllerArabicName =
      TextEditingController();
  TextEditingController textEditingControllerTo = TextEditingController();
  List<Destination> users = [];
  Destination? to;
  FindRecipientModel? findRecipientModel;
  // AddEditBasketFlagModel? addEditBasketFlagModel;

  // RemoveBasketRequest? removeBasketRequest;

  Map<String, dynamic>? _logindata;
  LoginModel? data;
  BuildContext? context;

  setSavingOrder(bool saving){
    this.isSavingOrder = saving;
    update();
  }
  getFindRecipientData({required context}) async {
    final FindRecipient _findRecipient = FindRecipient(context);
    _findRecipient.data =
    "Token=${_secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
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

  @override
  void onReady() {
    super.onReady();
    _logindata = _secureStorage.readSecureJsonData(AllStringConst.LogInData);
    data = LoginModel.fromJson(_logindata!);
    // getFindRecipientData();
    getFindRecipientData(context: context);
     //Get.find<SearchController>().getAllData();
    Get.find<DocumentController>().getFindRecipientData(context: context);

  }

  String userName() {
    String? name = _secureStorage.readSecureData(AllStringConst.FirstName);
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
      token: _secureStorage.token(),
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
      token: _secureStorage.token()!,
    );
    await _postReorderBasketsApi
        .post(reorderBasketsRequest.toMap())
        .then((value) {
      print(value);
      print("_postReorderBasketsApi");
    });
  }

  Future removeBasket(
      {context, basketId, required Function? onSuccess(String message)}) async {
    PostRemoveBasketApi _postRemoveBasketApi = PostRemoveBasketApi(context);
    RemoveBasketRequest removeBasketRequest = RemoveBasketRequest(
      basketId: basketId,
      language: Get.locale?.languageCode == "en" ? "en" : "ar",
      token: _secureStorage.token(),
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
  }
}
