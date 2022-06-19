import 'dart:convert';
import 'dart:ffi';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/can_open_document.dart';
import '../services/apis/get_correspondences_all_api.dart';
import '../services/apis/get_correspondences_api.dart';

//import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/find_recipient_json.dart';
import '../services/json_model/get_correspondences_all_model.dart';
import '../utility/storage.dart';
import 'dart:developer';

class InboxController extends GetxController {
  ScrollController scrollController = ScrollController();
  int index = 0;
  int inboxId = 5;
  bool haveMoreData = true;
  bool addToList = true;

  bool showHideFilterScreen = false;
  bool showHideMyFavListScreen = false;
  bool showHideCreateNewBasketScreen = false;

  final GetCorrespondencesApi _correspondencesApi = GetCorrespondencesApi();
  final GetCorrespondencesAllAPI _getCorrespondencesAllAPI =
      GetCorrespondencesAllAPI();

  GetCorrespondencesAllModel? getCorrespondencesAllModel;
  CorrespondencesModel? correspondencesModel;
  List<Correspondences>? correspondences = [];
  final SecureStorage _secureStorage = SecureStorage();

  CanOpenDocumentApi canOpenDocumentApi = CanOpenDocumentApi();

  bool getData = false;

  bool unread = false;

  updateUnread(v) {
    unread = v;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    getAllCorrespondencesData(
        inboxId: inboxId, pageSize: 20, showThumbnails: false);
    //  getCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false );
  }

  Future<void> onRefresh() async {
    // getCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false );
    print("9999999999999999999999999999999999");
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      index++;
      addToList = true;
      if (haveMoreData) {
        getCorrespondencesData(inboxId: inboxId);
        print("reach the bottom");
      }
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the top");
    }
  }

  applyFilter(){

    update();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

   showFilterScreen(bool show){
    showHideFilterScreen = show;
    update();
  }

  showMyFavListScreen(bool show){
    showHideMyFavListScreen = show;
    update();
  }

  showCreateNewBasketScreen(bool show){
    showHideCreateNewBasketScreen = show;
    update();
  }

  void getCorrespondencesData(
      {required int inboxId, int pageSize = 20, bool showThumbnails = false}) {
    getData = true;
    haveMoreData = true;
    update();
    _correspondencesApi.data =
        "Token=${_secureStorage.token()}&inboxId=$inboxId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
    _correspondencesApi.getData().then((value) {
      correspondencesModel = value as CorrespondencesModel;
      if (addToList) {
        correspondences!
            .addAll(correspondencesModel?.inbox?.correspondences ?? []);
      } else {
        correspondences = correspondencesModel?.inbox?.correspondences ?? [];
      }
      int listLength =
          correspondencesModel?.inbox?.correspondences?.length ?? 0;
      var v = correspondencesModel?.toJson();
      if (listLength < pageSize) {
        haveMoreData = false;
      }
      update();
      // log(v.length);
      print(correspondencesModel?.inbox?.correspondences?.length);
      getData = false;
      update();
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  getAllCorrespondencesData(
      {required int inboxId, int pageSize = 20, bool showThumbnails = false}) {
    correspondences?.clear();
    getData = true;
    haveMoreData = true;
    update();
    _getCorrespondencesAllAPI.data =
        "Token=${_secureStorage.token()}&inboxId=$inboxId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
    _getCorrespondencesAllAPI.getData().then((value) {
      getCorrespondencesAllModel = value as GetCorrespondencesAllModel;

      correspondences!
          .addAll(correspondencesModel?.inbox?.correspondences ?? []);

      int listLength =
          correspondencesModel?.inbox?.correspondences?.length ?? 0;
      var v = correspondencesModel?.toJson();
      if (listLength < pageSize) {
        haveMoreData = false;
      }
      update();
      // log(v.length);
      print(correspondencesModel?.inbox?.correspondences?.length);
      getData = false;
      update();
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  canOpenDoc({required correspondenceId, required transferId}) {
    canOpenDocumentApi.data =
        "Token=${_secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    canOpenDocumentApi.getData().then((value) {



      FindRecipientModel findRecipientModel = value as FindRecipientModel;

    });
  }
}
