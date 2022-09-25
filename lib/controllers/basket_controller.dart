import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/apis/basket/get_gasket_inbox_api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/json_model/basket/get_basket_inbox_model.dart';
import '../services/json_model/find_recipient_model.dart';
import '../utility/storage.dart';

class BasketController extends GetxController {
  BuildContext? context;
  FindRecipientModel? findRecipientModel;
  List<Destination> users = [];
  bool haveMoreData = true;
  final SecureStorage secureStorage = SecureStorage();
  ScrollController scrollController = ScrollController();
  // int index = 0;
  int? basketId;
  int pageSize = 20;
  int pageNumber = 0;
  TextEditingController textEditingControllerFromDocDate =
      TextEditingController();
  TextEditingController textEditingControllerToDocDate =
      TextEditingController();
  TextEditingController textEditingControllerSearch = TextEditingController();
  GetBasketInboxModel? getBasketInboxModel;
  int? valueOfRadio = 1;
  bool? alwes = false;
  setValueOfRadio(int? v) {
    valueOfRadio = v;
    update();
  }

  setalwes(bool? v) {
    alwes = v;
    update();
  }

  Future<void> selectFromDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      textEditingControllerFromDocDate.text =
          pickedDate.toString().substring(0, 10);

      // var outputFormat = DateFormat('dd/MM/yyyy');
      // var outputDate = outputFormat.format(pickedDate);
      //fromDocDate.toString();
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
      textEditingControllerToDocDate.text =
          pickedDate.toString().substring(0, 10);
      // var outputFormat = DateFormat('dd/MM/yyyy');
      // var outputDate = outputFormat.format(pickedDate);

      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  // _scrollListener() {
  //   if (scrollController.offset >= scrollController.position.maxScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     pageNumber++;

  //     if (haveMoreData) {
  //       getBasketInbox(context: context, id: basketId!, pageSize: pageNumber);
  //       print("reach the bottom");
  //     }
  //   }
  //   if (scrollController.offset <= scrollController.position.minScrollExtent &&
  //       !scrollController.position.outOfRange) {
  //     print("reach the top");
  //   }
  // }

  getBasketInbox(
      {required context,
      required int id,
      int pageSize = 20,
      int pageNumber = 0}) {
    GetBasketInboxApi getBasketInboxApi = GetBasketInboxApi(context);

    getBasketInboxApi.data =
        "token=${secureStorage.token()}&basketId=$id&pageNumber=$pageNumber&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";

    getBasketInboxApi.getData().then((value) {
      getBasketInboxModel = value as GetBasketInboxModel;

      if ((getBasketInboxModel?.correspondences?.length ?? 0) < pageSize) {
        haveMoreData = false;
      }

      ("data=>   ${getBasketInboxModel?.toJson()}   =>  ${getBasketInboxModel?.correspondences?.length}");
      update();
      // print(a.toJson());
    });
  }

  getFindRecipientData({context}) {
    final FindRecipient _findRecipient = FindRecipient(context);
    print("this is unbox getAllDatagetAllData ");
    _findRecipient.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    _findRecipient.getData().then((value) {
      findRecipientModel = value as FindRecipientModel;
      listOfUser(0);
      print(
          "findRecipientModel?.toJson()             =>    ${findRecipientModel?.toJson()}");
    });
  }

  setFindRecipientData(FindRecipientModel findRecipientModel) {
    this.findRecipientModel = findRecipientModel;
    listOfUser(0);
  }

  listOfUser(int pos) {
    users = findRecipientModel?.sections?[pos].destination ?? [];
    update();
  }
}
