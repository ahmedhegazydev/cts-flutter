import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/can_open_document.dart';
import '../services/apis/complete_in_correspondence_api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/get_correspondences_all_api.dart';
import '../services/apis/get_correspondences_api.dart';

//import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_all_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'dart:developer';

import '../utility/utilitie.dart';
import '../widgets/custom_button_with_icon.dart';

class InboxController extends GetxController {


  CompleteInCorrespondenceAPI _completeInCorrespondenceAPI =CompleteInCorrespondenceAPI();



String  completeNote ="";
  String  replyNote ="";
  CustomActions? completeCustomActions;
updatecompleteCustomActions(CustomActions actions){
  completeCustomActions =actions;

  update();
}

  Map <String,dynamic>?logindata;
  String filterWord="";
  ScrollController scrollController = ScrollController();
  int index = 0;
  int inboxId = 5;
  bool haveMoreData = true;
  bool addToList = true;
  final GetCorrespondencesApi _correspondencesApi = GetCorrespondencesApi();
  final GetCorrespondencesAllAPI _getCorrespondencesAllAPI =
      GetCorrespondencesAllAPI();

  GetCorrespondencesAllModel? getCorrespondencesAllModel;
  CorrespondencesModel? correspondencesModel;



  List<Correspondences>correspondences = [];
  List<Correspondences>allCorrespondences = [];




  final SecureStorage secureStorage = SecureStorage();

  CanOpenDocumentApi canOpenDocumentApi = CanOpenDocumentApi();

  bool getData = false;

  bool unread = false;



  FindRecipientModel? findRecipientModel;
  final FindRecipient _findRecipient=FindRecipient();


  List<CustomActions>? customActions=[];
  CustomActions? customAction;
  List<Destination>users =[];
  List<Destination>usersWillSendTo=[] ;
  addTousersWillSendTo({required Destination user}){
    usersWillSendTo.add(user);
    update();// update(["user"]);
  }
  delTousersWillSendTo({required Destination user}){
    usersWillSendTo.remove(user);
    update();// update(["alluser"]);
  }

  listOfUser(int pos){
    users=findRecipientModel?.sections?[pos].destination??[];
    update();
  }


  filterUser(String name){

    filterWord=name;
    update();

  }
  getFindRecipientData(){

    _findRecipient.data="Token=${secureStorage.token()}&language=${Get.locale?.languageCode=="en"?"en":"ar"}";
    _findRecipient.getData().then((value) {
      findRecipientModel=value as FindRecipientModel;
      listOfUser(0);
      //print(findRecipientModel?.toJson() );
    });
  }

  updateUnread(v) {
    unread = v;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    // getAllCorrespondencesData(
    //     inboxId: inboxId, pageSize: 20, showThumbnails: false);
      getCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false );
    getAllCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false );



    logindata=secureStorage.readSecureJsonData(AllStringConst.LogInData) ;
    if(logindata!=null){
      LoginModel data=LoginModel.fromJson(logindata!);
      customActions=data.customActions;
    }
    getFindRecipientData();

  }

  Future<void> onRefresh() async {
   //  getCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false );

   //  getAllCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false );
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
      //  getAllCorrespondencesData(inboxId: inboxId);
        print("reach the bottom");
      }
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the top");
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  void getCorrespondencesData(
      {required int inboxId, int pageSize = 20, bool showThumbnails = false}) {
    getData = true;
    haveMoreData = true;
    update();
    _correspondencesApi.data =
        "Token=${secureStorage.token()}&inboxId=$inboxId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
    _correspondencesApi.getData().then((value) {
      correspondencesModel = value as CorrespondencesModel;
      if (addToList) {
        correspondences
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
    correspondences.clear();
    getData = true;
    haveMoreData = true;
    update();
    _getCorrespondencesAllAPI.data =
        "Token=${secureStorage.token()}&inboxId=$inboxId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
    _getCorrespondencesAllAPI.getData().then((value) {
      getCorrespondencesAllModel = value as GetCorrespondencesAllModel;
      if (addToList) {
        allCorrespondences
            .addAll(correspondencesModel?.inbox?.correspondences ?? []);
      } else {
        allCorrespondences = correspondencesModel?.inbox?.correspondences ?? [];
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

  canOpenDoc({required correspondenceId, required transferId}) {
    canOpenDocumentApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    canOpenDocumentApi.getData().then((value) {



      FindRecipientModel findRecipientModel = value as FindRecipientModel;

    });
  }




  FlutterSoundRecorder? audioRecorder;
  FlutterSoundPlayer? audioPlayer;
  final pathToSave="audio.aac";
  bool recording=false;
  String _directoryPath = '/storage/emulated/0/SoundRecorder';
  Directory? appDocDir;
  Future record2()async{


    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    final stats=await Permission.microphone.request();

    if(stats !=PermissionStatus.granted){
      throw RecordingPermissionException("Microphone Permission");

    }
    audioRecorder=FlutterSoundRecorder();
    audioPlayer=FlutterSoundPlayer();
    audioRecorder!.openAudioSession();
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath=appDocDir!.path+ '/' + DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
    recording=true;
    update(["id"]);


    await audioRecorder?.startRecorder(toFile: _directoryPath);
  }
  Future stop2()async{

    await audioRecorder?.stopRecorder();
    recording=false;
    update(["id"]);






  }
  playRec()async{
    await   audioPlayer!.openAudioSession();
    await    audioPlayer!.startPlayer(fromURI: _directoryPath);
  }

  completeInCorrespondence({data}){

    _completeInCorrespondenceAPI.data=data;
    _completeInCorrespondenceAPI.getData( ).then((value) {
      print("000000000000000000000");
    });
  }
}
