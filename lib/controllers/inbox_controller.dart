import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/basket/add_documents_to_basket_api.dart';
import '../services/apis/basket/add_edit_basket_result _api.dart';
import '../services/apis/basket/getFetchBasketList_api.dart';
import '../services/apis/basket/get_gasket_inbox_api.dart';
import '../services/apis/basket/remove_basket_api.dart';
import '../services/apis/can_open_document.dart';
import '../services/apis/complete_in_correspondence_api.dart';
import '../services/apis/favorites/ListFavoriteRecipients_api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/get_correspondences_all_api.dart';
import '../services/apis/get_correspondences_api.dart';

//import '../services/json_model/get_correspondences_model.dart';
import '../services/apis/multiple_transfers_api.dart';
import '../services/json_model/basket/add_documents_to_basket_request.dart';
import '../services/json_model/basket/add_edit_basket_flag_model.dart';
import '../services/json_model/basket/fetch_basket_list_model.dart';
import '../services/json_model/basket/remove_basket_request_model.dart';
import '../services/json_model/can_open_document_model.dart';
import '../services/json_model/default_on_success_result.dart';
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_response.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_all_model.dart';
import '../services/json_model/inopendocModel/multiple_transfers_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../utility/all_string_const.dart';
import '../utility/Extenstions.dart';
import '../utility/storage.dart';

import '../utility/utilitie.dart';
import 'document_controller.dart';
import 'package:flutter/services.dart' as rootBundel;
import '../services/models/multiple_transfers_model_send.dart'
    as multipletransfersSend;
import 'landing_page_controller.dart';

class InboxController extends GetxController {
  //ده عشان لو اختار من الشاشه بره كل الصادر و الوارد نخفي شاشاه التاب الي فيها صادر ووارد
  bool isAllOrNot = false;

  String? purposeId;
bool isUrgentClicked = false;
  TextEditingController textEditingControllerFilter = TextEditingController();
  BuildContext? context;
  FetchBasketListModel? fetchBasketListModel;
  List<int> listSelectCorrespondences = [];
  int? oldIndex = 0;
  int? newIndex = 0;
  int? nodeId = 0;
  setOldIndex(int oldIndex) {
    this.oldIndex = oldIndex;
    update();
  }

  setIsUrgentFilterClicked(bool isUrgentClicked) {
    this.isUrgentClicked = isUrgentClicked;
    var filteredUrgentPriorities = correspondencesModel?.priorities
        ?.where((content) => content.Value == 3)
        .toList();
    if(filteredUrgentPriorities?.isNotEmpty == true){
      var filteredUrgentCorrespondences = allCorrespondences
          .where((content) => content.priorityId == filteredUrgentPriorities![0].Value)
          .toList();
      if(isUrgentClicked == true){
        allCorrespondences = filteredUrgentCorrespondences;
      }else{
        allCorrespondences = filteredUrgentCorrespondencesTemp;
      }
    }
    update();
  }

  Future addDocumentsToBasket({context, basketId}) async {
    AddDocumentsToBasketRequest addDocumentsToBasketRequest =
        AddDocumentsToBasketRequest(
            basketId: basketId,
            language: Get.locale?.languageCode == "en" ? "en" : "ar",
            token: secureStorage.token()!,
            documentIds: listSelectCorrespondences);
    AddEDocumentsToBasketApi addEDocumentsToBasketApi =
        AddEDocumentsToBasketApi(context);

    Map<String, dynamic> a = {
      "token": secureStorage.token(),
      "basketId": basketId,
      "language": "ar",
      "documentIds": listSelectCorrespondences
    };

    await addEDocumentsToBasketApi
        .post(addDocumentsToBasketRequest.toMap())
        .then((value) {
      Navigator.pop(context);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          icon: Container(),
          backgroundColor: Colors.lightGreen,
          message: "EndedSuccess".tr,
        ),
      );
      listSelectCorrespondences.clear();

      print(value);
      print("object");
    });
  }

  Future getFetchBasketList({context}) async {
    print(
        "getFetchBasketListgetFetchBasketListgetFetchBasketListgetFetchBasketList");
    GetFetchBasketListApi getFetchBasketListApi =
        GetFetchBasketListApi(context);
    getFetchBasketListApi.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await getFetchBasketListApi.getData().then((value) {
      Navigator.pop(context);
      // Get.back();
      fetchBasketListModel = value as FetchBasketListModel;
      // fetchBasketListModel?.baskets?.forEach((element) {
      //   element.orderBy = Random().nextInt(100);
      // });
      fetchBasketListModel?.baskets?.sort();

      Get.find<LandingPageController>().update();
      print(fetchBasketListModel?.toJson());
      print("getFetchBasketList i getit");
    });
  }

  updateSelect(v) {}

  String completeNote = "";
  String replyNote = "";
  bool isPrivate = true;

  updateISPrivate(v) {
    isPrivate = v;
    update(["pr"]);
  }

  CustomActions? completeCustomActions;

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

// updatecompleteCustomActions({CustomActions actions,int id}){
//   completeCustomActions =actions;
//
//   update();
// }

  bool edit = false;

  setEdit() {
    if (edit) {
      edit = false;
    } else {
      edit = true;
    }
    update();
  }

  Map<String, dynamic>? logindata;
  String filterWord = "";
  ScrollController scrollController = ScrollController();
  int index = 0;
  int inboxId = 0;
  bool haveMoreData = true;
  bool addToList = false;

  bool showHideFilterScreen = false;
  bool showHideMyFavListScreen = false;
  bool showHideCreateNewBasketScreen = false;

  GetCorrespondencesAllModel? getCorrespondencesAllModel;
  CorrespondencesModel? correspondencesModel;

  // List<Correspondences> correspondences = [];
  List<Correspondences> allCorrespondences = [];
  List<Correspondences> allCorrespondencesTempFilterUnread = [];
  List<Correspondences> filteredUrgentCorrespondencesTemp = [];

  final SecureStorage secureStorage = SecureStorage();

  CanOpenDocumentModel? canOpenDocumentModel;

  bool getData = false;

  bool unread = false;

  FindRecipientModel? findRecipientModel;

  List<CustomActions>? customActions = [];
  CustomActions? customAction;
  List<Destination> users = [];
  List<Destination> usersWillSendTo = [];

  TextEditingController textEditingControllerFromDocDate =
      TextEditingController();
  TextEditingController textEditingControllerToDocDate =
      TextEditingController();
  TextEditingController textEditingControllerSearch = TextEditingController();

  addTousersWillSendTo({required Destination user, thepos}) {
    purposeId = allCorrespondences[thepos].purposeId;
    usersWillSendTo.add(user);
    multipletransfersSend.TransferNode transferNode =
        multipletransfersSend.TransferNode(
            purposeId: allCorrespondences[thepos].purposeId,
            destinationId: user.id.toString(),
            voiceNotePrivate: false);
    multiTransferNode[user.id!] = transferNode;
    update(); // update(["user"]);
  }

  delTousersWillSendTo({required Destination user}) {
    usersWillSendTo.remove(user);
    multiTransferNode.remove(user.id);
    update(); // update(["alluser"]);
  }

  listOfUser(int pos) {
    users = findRecipientModel?.sections?[pos].destination ?? [];
    update();
  }

  filterUser(String name) {
    filterWord = name;
    update();
  }

  // getFindRecipientData(){
  //   print("this is unbox getAllDatagetAllData ");
  //   _findRecipient.data="Token=${secureStorage.token()}&language=${Get.locale?.languageCode=="en"?"en":"ar"}";
  //   _findRecipient.getData().then((value) {
  //     findRecipientModel=value as FindRecipientModel;
  //     listOfUser(0);
  //      print("findRecipientModel?.toJson()             =>    ${findRecipientModel?.toJson()}" );
  //   });
  // }
  setFindRecipientData(FindRecipientModel findRecipientModel) {
    this.findRecipientModel = findRecipientModel;
    // listOfUser(0);
  }


  updateUnread(v) {
    unread = v;
    var filtered = allCorrespondences
        .where((content) => content.isNew == v)
        .toList();
    if(v == true){
      allCorrespondences = filtered;
      if(isUrgentClicked){

      }
    }else{
      allCorrespondences =  allCorrespondencesTempFilterUnread;
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();

    logindata = secureStorage.readSecureJsonData(AllStringConst.LogInData);
    if (logindata != null) {
      LoginModel data = LoginModel.fromJson(logindata!);
      customActions = data.customActions;
    }
    // _scrollListener(context: context);
  }

  getAllData({required context}) {
    context = null;
    // final GetCorrespondencesApi _correspondencesApi = GetCorrespondencesApi(context);
    getCorrespondencesData(
        context: context,
        inboxId: inboxId,
        pageSize: 20,
        showThumbnails: false);
    // getAllCorrespondencesData(
    //     context: context,
    //     inboxId: inboxId,
    //     pageSize: 20,
    //     showThumbnails: false);

    //getFindRecipientData();
    // getFetchBasketList(context: context);
  }

  Future<void> onRefresh() async {
    //  getCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false,context: context );

    // getAllCorrespondencesData(inboxId: inboxId, pageSize:20 ,showThumbnails:false, context: context );
    print("onRefresh");
  }

  final record = FlutterSoundRecorder();
  Future recordMathod() async {
    //  await record.startRecorder(toFile: "audio");
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp4';
    recording = true;
    update(["id"]);

    await record.startRecorder(codec: _codec, toFile: _directoryPath);
  }

  Future stopMathod() async {
    recording = false;
    update(["id"]);
    recordFile = File(_directoryPath);
    await record.stopRecorder();
  }

  Future playMathod() async {
    audioPlayer = FlutterSoundPlayer();
    audioPlayer!.openPlayer();
    await audioPlayer!.startPlayer(fromURI: _directoryPath);
  }

  @override
  void onInit() {
    super.onInit();
    // scrollController.addListener(_scrollListener(context: context));

    initRecorder();
    // initRecorder2();
  }

  Future initRecorder() async {
    final statusmicrophone = await Permission.microphone.request();
    final statusstorage = await Permission.storage.request();
    final statusmanageExternalStorage =
        await Permission.manageExternalStorage.request();

    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    if (statusmicrophone != PermissionStatus.granted) {
      return;
      throw "Microphone permission not granted";
    }
    if (statusstorage != PermissionStatus.granted) {
      return;
      throw "storage permission not granted";
    }
    if (statusmanageExternalStorage != PermissionStatus.granted) {
      Permission.manageExternalStorage.request();
    }
    await record.openRecorder();
  }

  _scrollListener({required context}) {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      index++;
      addToList = true;
      if (haveMoreData) {
        getCorrespondencesData(context: context, inboxId: inboxId);
        print("reach the bottom");
      }
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the top");
    }
  }

  applyFilter() {
    update();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  showFilterScreen(bool show) {
    showHideFilterScreen = show;
    update();
  }

  showMyFavListScreen(bool show) {
    showHideMyFavListScreen = show;
    update();
  }

  showCreateNewBasketScreen(bool show) {
    showHideCreateNewBasketScreen = show;
    update();
  }

  void getCorrespondencesData(
      {context,
      required int inboxId,
      int pageSize = 20,
      bool showThumbnails = false}) {
    final GetCorrespondencesApi _correspondencesApi =
        GetCorrespondencesApi(context);
    getData = true;
    haveMoreData = true;
    update();
    this.inboxId = inboxId;

    _correspondencesApi.data =
        // "Token=${secureStorage.token()}&inboxId=$inboxId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
        "Token=${secureStorage.token()}&inboxId=$inboxId&nodeId=$nodeId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
    print("_correspondencesApi.data =>${_correspondencesApi.data}");
    print("yor  request this url  =>  ${_correspondencesApi.apiUrl()}");
    _correspondencesApi.getData().then((value) {
      correspondencesModel = value as CorrespondencesModel;
      if (addToList) {
        allCorrespondences
            .addAll(correspondencesModel?.inbox?.correspondences ?? []);
      } else {
        allCorrespondences = correspondencesModel?.inbox?.correspondences ?? [];
      }

      //For filter by urgent priority check box
      filteredUrgentCorrespondencesTemp = allCorrespondences;

      //For filter by unRead check box
      allCorrespondencesTempFilterUnread = allCorrespondences;
      if(unread == true){
        var filtered = allCorrespondences
            .where((content) => content.isNew == true)
            .toList();
        allCorrespondences = filtered;
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
      {required context,
      required int inboxId,
      int pageSize = 20,
      bool showThumbnails = false}) {
    print("theinboxId=> $inboxId =================  theindex=>   $index  ");
    final GetCorrespondencesAllAPI _getCorrespondencesAllAPI =
        GetCorrespondencesAllAPI(context);
    // correspondences.clear();
    allCorrespondences.clear();
    getData = true;
    haveMoreData = true;
    update();
    _getCorrespondencesAllAPI.data =
        "Token=${secureStorage.token()}&inboxId=$inboxId&index=$index&pageSize=$pageSize&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&showThumbnails=$showThumbnails";
    _getCorrespondencesAllAPI.getData().then((value) {
      // Navigator.pop(context);
      print("i get alll _getCorrespondencesAllAPI");
      getCorrespondencesAllModel = value as GetCorrespondencesAllModel;
      if (addToList) {
        allCorrespondences
            .addAll(getCorrespondencesAllModel?.inbox?.correspondences ?? []);
      } else {
        allCorrespondences =
            getCorrespondencesAllModel?.inbox?.correspondences ?? [];
      }

      int listLength =
          getCorrespondencesAllModel?.inbox?.correspondences?.length ?? 0;
      var v = getCorrespondencesAllModel?.toJson();
      if (listLength < pageSize - 1) {
        haveMoreData = false;
      }
      update();
      // log(v.length);
      print(getCorrespondencesAllModel?.inbox?.correspondences?.length);
      getData = false;
      update();
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  //
  //  openfilee({required docId,required correspondenceId, required transferId})async{
  //    print("openfilee87y7878");
  //    canOpenDocumentApi.data =
  //    "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
  //
  // final  jsondata=await rootBundel.rootBundle.loadString("assets/json/canopendocument.json");
  //    canOpenDocumentModel=   CanOpenDocumentModel.fromJson(json.decode(jsondata));
  //
  //    // canOpenDocumentApi.getData().then((value) {
  //    //
  //    //   canOpenDocumentModel=value as CanOpenDocumentModel;
  //    //   print("i get dayta");
  //    // });
  //    print(canOpenDocumentModel?.toJson());
  //    if(canOpenDocumentModel!.allow!){
  //      Get.find<DocumentController>().updatecanOpenDocumentModel(canOpenDocumentModel!);
  //      Get.toNamed("/DocumentPage");
  //    }
  //   //
  //  }

  Future canOpenDoc(
      {required context,
      required docId,
      required correspondenceId,
      required transferId}) async {
    CanOpenDocumentApi canOpenDocumentApi = CanOpenDocumentApi(context);

    print("canOpenDoc canOpenDoc canOpenDoc canOpenDoc");
    canOpenDocumentApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";

    print(canOpenDocumentApi.data);
    print("canOpenDocumentApi.data");
    canOpenDocumentApi.getData().then((value) {
      canOpenDocumentModel = value as CanOpenDocumentModel;

      print(
          "the valll ogfffcanOpenDocumentModel!.allow!cumentModel!.allow! =>${canOpenDocumentModel?.toJson()}");
      Get.find<DocumentController>().canOpenDocumentModel = value;
      Get.find<DocumentController>().updatecanOpenDocumentModel(value);
      //   FindRecipientModel findRecipientModel = value as FindRecipientModel;
      if (canOpenDocumentModel!.allow!) {
        //   Get.put(DocumentController(),permanent: true);

        // Get.find<DocumentController>().gatAllDataAboutDOC(
        //     context: context,
        //     docId: docId,
        //     transferId: transferId,
        //     correspondenceId: correspondenceId);

        Get.toNamed("/DocumentPage");
      } else {
        Get.snackbar("", "canotopen".tr);
      }
    }).catchError((e) {
      print("eeeeeeeeeeeeeeee=>  $e");
    });

    // // عشان ندخل الملف وبعدين هنشوف مشكله الجسون
    //
    //    Get.find<DocumentController>().gatAllDataAboutDOC(docId:  docId, transferId: transferId, correspondenceId: correspondenceId);
    //   Get.find<DocumentController>().loadPdf();
    Get.toNamed("/DocumentPage");
  }

  int userId = 0;

  Map<int, ReplyWithVoiceNoteRequestModel> transfarForMany = {};
  Map<int, CustomActions> transfarForManyCustomActions = {};

// //open the AttachmentItem
// //   getAttachmentItemlocal(
// //       {documentId, transferId, attachmentId, required BuildContext context}) async {
// //
// //     notoragnalFileDoc=true;
// //
// //     final jsondata = await rootBundel.rootBundle.loadString(
// //         "assets/json/getattachmentitem.json");
// //
// //     getAttAchmentItem = GetAttAchmentItem.fromJson(json.decode(jsondata));
// //     print("g2gInfoForExportModel?.toJson()=>  ${g2gInfoForExportModel
// //         ?.toJson()}");
// //
// //     pdfUrlFile=   getAttAchmentItem!.attachment!.uRL!;
// //
// // update();
// //
// //
// //     // showDialog(
// //     //     context: context,
// //     //     builder: (BuildContext context) {
// //     //       return AlertDialog(
// //     //         title: Text(getAttAchmentItem!.attachment!.fileName!),
// //     //         content: SizedBox(
// //     //             height: MediaQuery
// //     //                 .of(context)
// //     //                 .size
// //     //                 .height * .7,
// //     //             width: MediaQuery
// //     //                 .of(context)
// //     //                 .size
// //     //                 .width * .7,
// //     //             child: SfPdfViewer.network(
// //     //               //'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'
// //     //                 getAttAchmentItem!.attachment!.uRL!
// //     //
// //     //             )),
// //     //         actions: <Widget>[
// //     //           TextButton(
// //     //             onPressed: () {
// //     //               Navigator.of(context).pop();
// //     //             },
// //     //             child: Text("Ok"),
// //     //           ),
// //     //         ],
// //     //       );
// //     //     });
// //   }
//
//   // [OperationContract]
//   // [WebGet(RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json,
//   // UriTemplate = "GetAttachmentItem?)]
//   // GetAttachmentItemResult GetAttachmentItem(string Token, string documentId, string transferId, string attachmentId, string language);
//   //
//
// //=============================================================================================
//
//   multipleTransferspost({context, correspondenceId, transferId}) {
//     //
//     MultipleTransfersAPI _multipleTransfersAPI = MultipleTransfersAPI(context);
//     recordingMap.forEach((key, value) async {
//       print("key====>$key");
//       print("key====>${value}");
//
//       String? audioFileBes64 = await audiobase64String(file: File(value));
//
//       multiTransferNode[key]?.voiceNote = audioFileBes64;
//       multiTransferNode[key]?.voiceNoteExt = "m4a";
//       multiTransferNode[key]?.voiceNotePrivate = false;
//       multiTransferNode[key]?.destinationId = key.toString();
//       multiTransferNode[key]?.purposeId =
//           canOpenDocumentModel!.correspondence!.purposeId;
//       multiTransferNode[key]?.voiceNotePrivate = false;
//
//       // multipletransfersSend.TransferNode transferNode =
//       // multipletransfersSend.TransferNode(
//       //     destinationId: key.toString(),note: ,voiceNotePrivate: ,
//       //     purposeId:
//       //         canOpenDocumentModel!.correspondence!.correspondenceId!,
//       //     //value.correspondencesId!,
//       //     dueDate: canOpenDocumentModel!.correspondence!.docDueDate!,
//       //     //canOpenDocumentModel!.correspondence!.docDueDate!,
//       //     voiceNote: audioFileBes64!,
//       //     voiceNoteExt: "m4a");
//       print(
//           "multiTransferNode[key]=>    ${jsonEncode(multiTransferNode[key]?.toMap())}");
//       print("key====>${jsonEncode(value)}");
//     });
//
//     List<multipletransfersSend.TransferNode> transfers = [];
//     multiTransferNode.forEach((key, value) {
//       transfers.add(value);
//     });
//
//     multipletransfersSend.MultipleTransfers multipleTransfers =
//     multipletransfersSend.MultipleTransfers(
//         transfers: transfers,
//         correspondenceId: correspondenceId,
//         token: secureStorage.token()!,
//         transferId: transferId);
//
//     // MultipleTransfersModel multipleTransfersModel = MultipleTransfersModel(
//     //     token: secureStorage.token()!,
//     //     correspondenceId: correspondenceId,
//     //     transferId: transferId,
//     //     transfers: transfers);
//
//     print(
//         "multipleTransfersModel.toMap()   =>${jsonEncode(multipleTransfers.toMap())}");
//     transfarForMany.clear();
//     usersWillSendTo.clear();
//     _multipleTransfersAPI.post(multipleTransfers.toMap()).then((value) {
//       DefaultOnSuccessResult defaultOnSuccessResult=value as DefaultOnSuccessResult;
//
//       Get.snackbar("", "تم التنفيذ بنجاح");
//
//     });
//   }

//============================================================================
  CustomActions? getactions(id) {
    return transfarForManyCustomActions[id];
    update();
  }

  setactions(id, CustomActions customActions) {
    transfarForManyCustomActions[id] = customActions;
    transfarForMany[id]?.actionType = customActions.name;
    update();
  }

  setNots({required int id, String? not}) {
    transfarForMany[id]?.notes = not;
    update();
  }

  SetMultipleReplyWithVoiceNoteRequestModel(
      {required int id,
      required String transferId,
      required String correspondencesId}) {
    ReplyWithVoiceNoteRequestModel model = ReplyWithVoiceNoteRequestModel(
        userId: id.toString(),
        transferId: transferId,
        correspondencesId: correspondencesId,
        notes: "",
        voiceNoteExt: "m4a",
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        token: secureStorage.token());
    transfarForMany[id] = model;
  }

  deltransfarForMany({required int id}) {
    transfarForMany.remove(id);
  }

  Codec _codec = Codec.aacMP4;
  FlutterSoundRecorder? audioRecorder;
  FlutterSoundPlayer? audioPlayer;
  final pathToSave = "audio.aac";
  bool recording = false;
  String _directoryPath = '/storage/emulated/0/SoundRecorder';
  Directory? appDocDir;
  File? recordFile;

  Future record2() async {
    final statsstorage = await Permission.storage.request();
    final statsmanageExternalStorage =
        await Permission.manageExternalStorage.request();
    final statsmicrophone = await Permission.microphone.request();

    if (statsmicrophone != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone Permission");
    }
    if (statsstorage != PermissionStatus.granted) {
      throw RecordingPermissionException("storage Permission");
    }
    if (statsmanageExternalStorage != PermissionStatus.granted) {
      throw RecordingPermissionException("manageExternalStorage Permission");
    }

    audioRecorder = FlutterSoundRecorder();
    audioPlayer = FlutterSoundPlayer();
    // audioRecorder!.openAudioSession();
    audioRecorder!.stopRecorder();
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp4';
    recording = true;
    update(["id"]);

    await audioRecorder?.startRecorder(codec: _codec, toFile: _directoryPath);
  }

  Future stop2() async {
    await audioRecorder?.stopRecorder();
    recordFile = File(_directoryPath);
    recording = false;
    update(["id"]);
  }

  playRec() async {
    // await audioPlayer!.openAudioSession();
    await audioPlayer!.stopPlayer();
    await audioPlayer!.startPlayer(fromURI: _directoryPath);
  }

  Future completeInCorrespondence({context, data}) async {
    CompleteInCorrespondenceAPI _completeInCorrespondenceAPI =
        CompleteInCorrespondenceAPI(context);
    _completeInCorrespondenceAPI.data = data;
    await _completeInCorrespondenceAPI.getData().then((value) {
      print("000000000000000000000");
      Get.find<LandingPageController>().getDashboardStats(context: context);

      Get.find<InboxController>().getCorrespondencesData(
          context: context,
          inboxId: Get.find<InboxController>().inboxId,
          pageSize: 20,
          showThumbnails: false);

      Navigator.pop(context);
      Get.back();
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          icon: Container(),
          backgroundColor: Colors.lightGreen,
          message: "EndedSuccess".tr,
        ),
      );
    });
  }

  //================================================================================================
  // Future recordForMany() async {
  //   await Permission.storage.request();
  //   await Permission.manageExternalStorage.request();
  //   final stats = await Permission.microphone.request();
  //
  //   if (stats != PermissionStatus.granted) {
  //     throw RecordingPermissionException("Microphone Permission");
  //   }
  //   audioRecorder = FlutterSoundRecorder();
  //   audioPlayer = FlutterSoundPlayer();
  //   // audioRecorder!.openAudioSession();
  //   audioRecorder!.stopRecorder();
  //   appDocDir = await getApplicationDocumentsDirectory();
  //   _directoryPath = appDocDir!.path +
  //       '/' +
  //       DateTime.now().millisecondsSinceEpoch.toString() +
  //       '.mp4';
  //   recording = true;
  //   update();
  //
  //   await audioRecorder?.startRecorder(codec: _codec, toFile: _directoryPath);
  // }
  //
  // Future stopForMany({required int id}) async {
  //   await audioRecorder?.stopRecorder();
  //   recordFile = File(_directoryPath);
  //   recording = false;
  //   String? audioFileBes64 = await audiobase64String(file: recordFile);
  //   update();
  //   transfarForMany[id]?.voiceNote = audioFileBes64;
  // }
  //
  //

  /////=============================
  Future<void> selectFromDocDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      textEditingControllerFromDocDate.text =
          pickedDate.toString().substring(0, 10);

      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(pickedDate);
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
      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(pickedDate);

      update();
    }
  }

  //fileter

  List<String> texts1 = [
    "للعلم و الاطلاع",
    "لاجراء اللازم",
    "للافاده",
    "للتوجيه",
  ];
  String selectTexts1pos = "";

  updateTexts1(ppos) {
    selectTexts1pos = ppos;
    update();
  }

  List<String> texts2 = [
    "مباشر",
    "نسخه",
    "خاص",
  ];
  String selectTexts2pos = "";

  updateTexts2(ppos) {
    selectTexts2pos = ppos;
    update();
  }

  List<String> texts3 = [
    "high".tr,
    "medium".tr,
    "low".tr,
  ];
  String selectTexts3pos = "";

  updateTexts3(ppos) {
    selectTexts3pos = ppos;
    update();
  }

  canceldata() {
    // updateTexts1(texts1[3]  );
    // updateTexts2(texts1[2]  );
    // updateTexts3( texts1[2] );
    updateTexts1("");
    updateTexts2("");
    updateTexts3("");
    Get.back();
    update();
  }

//=============================================================================================

  multipleTransferspost2({context, correspondenceId, transferId}) {
    //
    MultipleTransfersAPI _multipleTransfersAPI = MultipleTransfersAPI(context);
    recordingMap.forEach((key, value) async {
      print("key====>$key");
      print("key====>${value}");

      String? audioFileBes64 = await audiobase64String(file: File(value));

      multiTransferNode[key]?.voiceNote = audioFileBes64;
      multiTransferNode[key]?.voiceNoteExt = "m4a";
      multiTransferNode[key]?.voiceNotePrivate = false;
      multiTransferNode[key]?.destinationId = key.toString();
      multiTransferNode[key]?.purposeId = purposeId;
      // canOpenDocumentModel!.correspondence!.purposeId;
      multiTransferNode[key]?.voiceNotePrivate = false;

      // multipletransfersSend.TransferNode transferNode =
      // multipletransfersSend.TransferNode(
      //     destinationId: key.toString(),note: ,voiceNotePrivate: ,
      //     purposeId:
      //         canOpenDocumentModel!.correspondence!.correspondenceId!,
      //     //value.correspondencesId!,
      //     dueDate: canOpenDocumentModel!.correspondence!.docDueDate!,
      //     //canOpenDocumentModel!.correspondence!.docDueDate!,
      //     voiceNote: audioFileBes64!,
      //     voiceNoteExt: "m4a");
      print(
          "multiTransferNode[key]=>    ${jsonEncode(multiTransferNode[key]?.toMap())}");
      print("key====>${jsonEncode(value)}");
    });

    List<multipletransfersSend.TransferNode> transfers = [];
    multiTransferNode.forEach((key, value) {
      transfers.add(value);
    });

    multipletransfersSend.MultipleTransfers multipleTransfers =
        multipletransfersSend.MultipleTransfers(
            transfers: transfers,
            correspondenceId: correspondenceId,
            token: secureStorage.token()!,
            transferId: transferId);

    // MultipleTransfersModel multipleTransfersModel = MultipleTransfersModel(
    //     token: secureStorage.token()!,
    //     correspondenceId: correspondenceId,
    //     transferId: transferId,
    //     transfers: transfers);

    print(
        "multipleTransfersModel.toMap()   =>${jsonEncode(multipleTransfers.toMap())}");
    transfarForMany.clear();
    usersWillSendTo.clear();
    _multipleTransfersAPI.post(multipleTransfers.toMap()).then((value) {
      DefaultOnSuccessResult defaultOnSuccessResult =
          value as DefaultOnSuccessResult;

      Get.snackbar("", "تم التنفيذ بنجاح");
    });
  }

//=====================================================================================
  //Favorites user
  ListFavoriteRecipientsResponse? favoriteRecipientsResponse;

  Future listFavoriteRecipients({context}) async {
    ListFavoriteRecipientsApi listFavoriteRecipientsApi =
        ListFavoriteRecipientsApi(context);
    listFavoriteRecipientsApi.data =
        "Token=${secureStorage.token()}&Language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await listFavoriteRecipientsApi.getData().then((value) {
      Navigator.pop(context);
      if (value != null) {
        favoriteRecipientsResponse = value as ListFavoriteRecipientsResponse;
      } else {
        Get.snackbar("", "err".tr);
      }

      // print("listFavoriteRecipientsApi  =>${favoriteRecipientsResponse?.recipients[0].targetPhotoBs64.isEmpty}");
    });
    update();
  }

//التسجيل الجديد

  setNots2({required int id, String? not}) {
    multiTransferNode[id]?.note = not;
  }

  Map<int, multipletransfersSend.TransferNode> multiTransferNode = {};
  Map<int, dynamic> recordingMap = {};

  Future initRecorder2() async {
    final statusmicrophone = await Permission.microphone.request();
    final statusstorage = await Permission.storage.request();
    final statusmanageExternalStorage =
        await Permission.manageExternalStorage.request();

    if (statusmicrophone != PermissionStatus.granted) {
      Permission.microphone.request();
    }
    if (statusstorage != PermissionStatus.granted) {
      await Permission.storage.request();
    }
    if (statusmanageExternalStorage != PermissionStatus.granted) {
      Permission.manageExternalStorage.request();
    }
    await record.openRecorder();
  }

  Future recordMathod2({required id}) async {
    await record.openRecorder();
    //  await record.startRecorder(toFile: "audio");
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp4';
    recording = true;
    update(["id"]);
    recordingMap[id] = _directoryPath;
    await record.startRecorder(codec: _codec, toFile: _directoryPath);
    update(["record"]);
  }

  Future stopMathod2() async {
    recording = false;
    update(["id"]);
    recordFile = File(_directoryPath);
    await record.stopRecorder();
    update(["record"]);
  }

  Future playMathod2({required id}) async {
    audioPlayer = FlutterSoundPlayer();
    audioPlayer!.openPlayer();
    if (recordingMap[id] != null) {
      await audioPlayer!.startPlayer(fromURI: recordingMap[id]);
    } else {
      Get.snackbar("", "nofiletoopen".tr);
    }
  }
}
