import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/inOpenDocument/get_document_audit_logs_api.dart';
import '../services/apis/inOpenDocument/get_document_links_api.dart';
import '../services/apis/inOpenDocument/get_document_receivers_api.dart';
import '../services/apis/inOpenDocument/get_document_transfers_api.dart';
import '../services/apis/inside_doc/auto_send_to_recepients_and-cc_api.dart';
import '../services/apis/inside_doc/can_export_as_paperwork_api.dart';
import '../services/apis/inside_doc/check_for_empty_structure_recipients_api.dart';
import '../services/apis/inside_doc/g2g/can_receive_g2g_document_api.dart';
import '../services/apis/inside_doc/g2g/g2g_info_for_export_api.dart';
import '../services/apis/inside_doc/g2g/receive_document_using_g2g_api.dart';
import '../services/apis/inside_doc/get_user_routing_api.dart';
import '../services/apis/inside_doc/is_already_exported_as_paperwork_api.dart';
import '../services/apis/inside_doc/is_already_exported_as_transfer_api.dart';
import '../services/json_model/can_open_document_model.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/get_document_links_model.dart';
import '../services/json_model/get_document_logs_model.dart';
import '../services/json_model/get_document_receivers_model.dart';
import '../services/json_model/get_document_transfers_model.dart';
import '../services/json_model/inopendocModel/auto_send_to_recepients_and_cc_model.dart';
import '../services/json_model/inopendocModel/can_export_as_paperwork_model.dart';
import '../services/json_model/inopendocModel/check_for_empty_structure_recipients_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_export_dto.dart';
import '../services/json_model/inopendocModel/g2g/g2g_receive_or_reject_dto.dart';
import '../services/json_model/inopendocModel/get_user_routing_model.dart';
import '../services/json_model/inopendocModel/is_already_exported_as_paperwork_model.dart';
import '../services/json_model/inopendocModel/is_already_exported_as_transfer_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../services/models/signature_info.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button_with_icon.dart';
import 'inbox_controller.dart';

class DocumentController extends GetxController {
  SecureStorage secureStorage = SecureStorage();
  CanOpenDocumentModel? canOpenDocumentModel;


  IsAlreadyExportedAsPaperworkModel? isAlreadyExportedAsPaperworkModel;
  IsAlreadyExportedAsPaperworkAPI _alreadyExportedAsPaperworkAPI =

  IsAlreadyExportedAsPaperworkAPI();



  CanExportAsPaperworkAPI _canExportAsPaperworkAPI = CanExportAsPaperworkAPI();
  CanExportAsPaperworkModel? canExportAsPaperworkModel;


  AutoSendToRecepientsAndCCAPI _autoSendToRecepientsAndCCAPI =
  AutoSendToRecepientsAndCCAPI();
  AutoSendToRecepientsAndCCModel? autoSendToRecepientsAndCCModel;

  CheckForEmptyStructureRecipientsAPI _checkForEmptyStructureRecipientsAPI =
  CheckForEmptyStructureRecipientsAPI();
  CheckForEmptyStructureRecipientsModel? checkForEmptyStructureRecipientsModel;

  IsAlreadyExportedAsTransferAPI _isAlreadyExportedAsTransferAPI =
  IsAlreadyExportedAsTransferAPI();
  IsAlreadyExportedAsTransferModel? isAlreadyExportedAsTransferModel;

  GetUserRoutingAPI _getUserRoutingAPI = GetUserRoutingAPI();
  GetUserRoutingModel? getUserRoutingModel;

  G2GInfoForExportAPI _g2gInfoForExportAPI = G2GInfoForExportAPI();
  G2GInfoForExportModel? g2gInfoForExportModel;


  CanReceiveG2GDocumentAPI _canReceiveG2GDocumentAPI = CanReceiveG2GDocumentAPI();
  ReceiveDocumentUsingG2GApi _receiveDocumentUsingG2GApi=ReceiveDocumentUsingG2GApi();

  Map<String, dynamic>? logindata;
  Map<GlobalKey, String> singpic = {};
  List<Widget> pdfAndSing = [
    SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')
  ];

  addWidgetToPdfAndSing(Widget pic) {
    pdfAndSing.add(pic);
    update();
  }

  List<MultiSignatures> multiSignatures = [];
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  FindRecipientModel? findRecipientModel;
  final FindRecipient _findRecipient = FindRecipient();

//===============================================
  final GetDocumentAuditLogsApi _getDocumentAuditLogsApi =
  GetDocumentAuditLogsApi();
  GetDocumentLogsModel? getDocumentLogsModel;
  final GetDocumentLinksApi _getDocumentLinksApi = GetDocumentLinksApi();
  GetDocumentLinksModel? getDocumentLinksModel;
  final GetDocumentReceiversApi _getDocumentReceiversApi =
  GetDocumentReceiversApi();
  GetDocumentReceiversModel? getDocumentReceiversModel;
  final GetDocumentTransfersApi _getDocumentTransfersApi =
  GetDocumentTransfersApi();

  GetDocumentTransfersModel? getDocumentTransfersModel;

  getDocumentAuditLogsdata({required String docId}) {
    _getDocumentAuditLogsApi.data =
    "Token=${secureStorage.token()}&docId=$docId&language=${Get.locale
        ?.languageCode == "en" ? "en" : "ar"}";

    _getDocumentAuditLogsApi.getData().then((value) {
      getDocumentLogsModel = value as GetDocumentLogsModel;
    });
  }

  getDocumentLinksdata({correspondenceId, transferId}) {
    _getDocumentLinksApi.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    _getDocumentLinksApi.getData().then((value) {
      getDocumentLinksModel = value as GetDocumentLinksModel;
    });
  }

  getDocumentReceiversdata({correspondenceId, transferId}) {
    _getDocumentReceiversApi.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    _getDocumentReceiversApi.getData().then((value) {
      getDocumentReceiversModel = value as GetDocumentReceiversModel;
    });
  }

  getDocumentTransfersdata({correspondenceId, transferId}) {
    _getDocumentTransfersApi.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    _getDocumentTransfersApi.getData().then((value) {
      getDocumentTransfersModel = value as GetDocumentTransfersModel;
    });
  }

  gatAllDataAboutDOC({required String docId,
    required String transferId,
    required String correspondenceId}) {
    print("gatAllDataAboutDOC");
    getDocumentAuditLogsdata(docId: docId);
    getDocumentTransfersdata(
        transferId: transferId, correspondenceId: correspondenceId);
    getDocumentReceiversdata(
        correspondenceId: correspondenceId, transferId: transferId);
    getDocumentLinksdata(
        transferId: transferId, correspondenceId: correspondenceId);
    print("*" * 10);
  }

//===============================================
  List<Destination> users = [];
  List<Destination> usersWillSendTo = [];

  String filterWord = "";

  filterUser(String name) {
    filterWord = name;
    update();
  }

  addTousersWillSendTo({required Destination user}) {
    usersWillSendTo.add(user);
    update(); // update(["user"]);
  }

  delTousersWillSendTo({required Destination user}) {
    usersWillSendTo.remove(user);
    update(); // update(["alluser"]);
  }

  listOfUser(int pos) {
    users = findRecipientModel?.sections?[pos].destination ?? [];
    update();
  }

  getFindRecipientData() {
    _findRecipient.data =
    "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en"
        ? "en"
        : "ar"}";
    _findRecipient.getData().then((value) {
      findRecipientModel = value as FindRecipientModel;

      Get.find<InboxController>().setFindRecipientData(findRecipientModel!);
      listOfUser(0);
      print(
          "tis is  findRecipientModel?.toJson()              =>  ${findRecipientModel
              ?.toJson()}");
    });
  }

  List<CustomActions>? customActions = [];
  late Correspondences correspondences;

  //PDFDocument? doc;

  Map<String, String> actions = {};

  //Map<String,String>actions={};
  // FlutterSoundPlayer? mPlayer ;

// Future record()async{
//   appDocDir = await getApplicationDocumentsDirectory();
//   _directoryPath=appDocDir!.path+ '/' + DateTime.now().millisecondsSinceEpoch.toString() +
//       '.aac';
//
//   await audioRecord!.startRecorder(toFile:_directoryPath);
// File aaa=File(_directoryPath);
// print(aaa);
// }
//   Future stop()async{
//     await audioRecord!.stopRecorder();
//
//
//     print(_directoryPath);
//
//   //  print(audioRecorder.stopRecorderCompleted(state, success, url));
//   //  play();
//  //   _writeFileToStorage();
//    // print();
//
//   }
//
//   //   void _writeFileToStorage() async {
//   //   _createDirectory();
//   //   _createFile();
//   // }
//   // Future play()async{
//   //   await mPlayer.openAudioSession();
//   //  // await mPlayer.nowPlaying(track);
//   //   Track a=Track(trackPath: _directoryPath );
//   //
//   //   await mPlayer.nowPlaying(a );
//   // }
//
//
//
//   void play() async {
//     await mPlayer.startPlayer(
//         fromURI: _directoryPath,
//         codec: Codec.mp3,
//         whenFinished: () {
//
//         });
//
//   }
  loadPdf() async {
    //correspondences.visualTrackingUrl
    //  doc = await PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf');
    print("get the pdf");
    update();
  }

  @override
  void onReady() {
    super.onReady();

    logindata = secureStorage.readSecureJsonData(AllStringConst.LogInData);
    if (logindata != null) {
      LoginModel data = LoginModel.fromJson(logindata!);
      customActions = data.customActions;

      multiSignatures = data.multiSignatures ?? [];
    }
  }

//
//   Future initRecord()async{
//   audioRecord=FlutterSoundRecorder();
//
//   final stats=await Permission.microphone.request();
//   await Permission.storage.request();
//   await Permission.manageExternalStorage.request();
//   if(stats !=PermissionStatus.granted){
//     throw RecordingPermissionException("Microphone Permission");
//
//   }
//   //mPlayer = FlutterSoundPlayer();
//  await audioRecord!.openAudioSession();
//
//
// }
// void closeRecord(){
//   audioRecord!.closeAudioSession();
//
//   audioRecord=null;
//
// }

  /// get all Transfer about doc

  @override
  void onInit() {
    super.onInit();
    print(" i get startonInitonInitonInitonInit ");
    genratG2GExportDto();
  }

  @override
  void onClose() {
    super.onClose();
  }

  FlutterSoundRecorder? audioRecorder;
  FlutterSoundPlayer? audioPlayer;
  final pathToSave = "audio.aac";
  bool recording = false;
  String _directoryPath = '/storage/emulated/0/SoundRecorder';
  Directory? appDocDir;
  File? recordFile;

  Codec _codec = Codec.aacMP4;

  Future record2() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    final stats = await Permission.microphone.request();

    if (stats != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone Permission");
    }
    audioRecorder = FlutterSoundRecorder();
    audioPlayer = FlutterSoundPlayer();
    audioRecorder!.openAudioSession();
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime
            .now()
            .millisecondsSinceEpoch
            .toString() +
        '.aac';

    await audioRecorder?.startRecorder(toFile: _directoryPath);
  }

  Future stop2() async {
    await audioRecorder?.stopRecorder();
  }

  playRec() async {
    await audioPlayer!.openAudioSession();
    await audioPlayer!.startPlayer(fromURI: _directoryPath);
  }

  Map<int, ReplyWithVoiceNoteRequestModel> transfarForMany = {};
  Map<int, CustomActions> transfarForManyCustomActions = {};

  // Map<int, String> transfarForManyNots = {};

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

  deltransfarForMany({required int id}) {
    transfarForMany.remove(id);
  }

  Future recordForMany() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    final stats = await Permission.microphone.request();

    if (stats != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone Permission");
    }
    audioRecorder = FlutterSoundRecorder();
    audioPlayer = FlutterSoundPlayer();
    audioRecorder!.openAudioSession();
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime
            .now()
            .millisecondsSinceEpoch
            .toString() +
        '.mp4';
    recording = true;
    update();

    await audioRecorder?.startRecorder(codec: _codec, toFile: _directoryPath);
  }

  Future stopForMany({required int id}) async {
    await audioRecorder?.stopRecorder();
    recordFile = File(_directoryPath);
    recording = false;
    String? audioFileBes64 = await audiobase64String(file: recordFile);
    update();
    transfarForMany[id]?.voiceNote = audioFileBes64;
  }

  SetMultipleReplyWithVoiceNoteRequestModel({required int id,
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

  filePickerR() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {}
  }

  getIsAlreadyExportedAsPaperwork({required correspondenceId,
    required transferId,
    required exportAction,required context}) async {
    print("in  getIsAlreadyExportedAsPaperwork");
    _alreadyExportedAsPaperworkAPI.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}&exportAction=$exportAction";
    _alreadyExportedAsPaperworkAPI.getData().then((value) {

      isAlreadyExportedAsPaperworkModel =
      value as IsAlreadyExportedAsPaperworkModel;
      print("canExportAsPaperworkModel =>  ${isAlreadyExportedAsPaperworkModel?.isConfirm}");


      if(isAlreadyExportedAsPaperworkModel?.isConfirm??false){

        showDilog( context: context,massge: isAlreadyExportedAsPaperworkModel!.message!,no: (){

          Navigator.of(context).pop();

        },yes: (){
          getCanExportAsPaperwork(exportAction:  exportAction, transferId: transferId,correspondenceId:correspondenceId );



        });
      }
      // print("_alreadyExportedAsPaperworkAPI =>  ${isAlreadyExportedAsPaperworkModel!.toJson()}");
    });
  }

  getCanExportAsPaperwork(
      {required correspondenceId, required transferId, required exportAction,required context}) {
    _canExportAsPaperworkAPI.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}&exportAction=$exportAction";
    _canExportAsPaperworkAPI.getData().then((value) {
      canExportAsPaperworkModel = value as CanExportAsPaperworkModel;
      print("canExportAsPaperworkModel =>  ${canExportAsPaperworkModel?.isConfirm}");
      // if(canExportAsPaperworkModel?.isConfirm??false){
      //   Get.snackbar("", canExportAsPaperworkModel!.message!);
      // }
      // print("_alreadyExportedAsPaperworkAPI =>  ${canExportAsPaperworkModel!.toJson()}");

      if(canExportAsPaperworkModel?.isConfirm??false){

        showDilog( context: context,massge: canExportAsPaperworkModel!.message!,no: (){

          Navigator.of(context).pop();

        },yes: (){



          //getCanExportAsPaperwork(exportAction:  exportAction, transferId: transferId,correspondenceId:correspondenceId );



        });
      }



    });
  }

  autoSendToRecepientsAndCC(
      {required correspondenceId, required transferId, required exportAction}) {
    _autoSendToRecepientsAndCCAPI.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}&exportAction=$exportAction";
    _autoSendToRecepientsAndCCAPI.getData().then((value) {
      autoSendToRecepientsAndCCModel = value as AutoSendToRecepientsAndCCModel;

      if(autoSendToRecepientsAndCCModel?.isConfirm??false){
        Get.snackbar("", autoSendToRecepientsAndCCModel!.message!);
      }
      print("_alreadyExportedAsPaperworkAPI =>  ${autoSendToRecepientsAndCCModel!.toJson()}");
    });
  }

  checkForEmptyStructureRecipients(
      {required correspondenceId, required transferId, required exportAction}) {
    _checkForEmptyStructureRecipientsAPI.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}&exportAction=$exportAction";
    _checkForEmptyStructureRecipientsAPI.getData().then((value) {
      checkForEmptyStructureRecipientsModel =
      value as CheckForEmptyStructureRecipientsModel;


      if(checkForEmptyStructureRecipientsModel?.isConfirm??false){
        Get.snackbar("", checkForEmptyStructureRecipientsModel!.message!);
      }
      print("_alreadyExportedAsPaperworkAPI =>  ${checkForEmptyStructureRecipientsModel!.toJson()}");
    });
  }

  isAlreadyExportedAsTransfer(
      {required correspondenceId, required transferId, required exportAction}) {
    _isAlreadyExportedAsTransferAPI.data =
    "Token=${secureStorage
        .token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar"}&exportAction=$exportAction";
    _isAlreadyExportedAsTransferAPI.getData().then((value) {
      isAlreadyExportedAsTransferModel =
      value as IsAlreadyExportedAsTransferModel;


      if(isAlreadyExportedAsTransferModel?.isConfirm??false){
        Get.snackbar("", isAlreadyExportedAsTransferModel!.message!);
      }
      print("_alreadyExportedAsPaperworkAPI =>  ${isAlreadyExportedAsTransferModel!.toJson()}");
    });
  }

  getUserRouting({required gctId}) {
    _getUserRoutingAPI.data = "Token=${secureStorage.token()}&GctId=$gctId";
    _getUserRoutingAPI.getData().then((value) {
      getUserRoutingModel = value as GetUserRoutingModel;
    });
  }

  g2gInfoForExport({
    required documentId,
  }) {
    _g2gInfoForExportAPI.data =
    "token=${secureStorage.token()}&documentId=$documentId&language=${Get.locale
        ?.languageCode == "en" ? "en" : "ar"}";
    _g2gInfoForExportAPI.getData().then((value) {
      g2gInfoForExportModel = value as G2GInfoForExportModel;
    });
  }

  genratG2GExportDto() {
    G2GRecipient g2gRecipient = G2GRecipient(
        childId: 5, isCC: false, parentId: 10);
    G2GExportDto g = G2GExportDto(
        token: secureStorage.token(),
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        notes: "i9jjoj",
        attachments: [],
        documentId: 2020,
        recipients: [ g2gRecipient]);


    print("this the map=> ${jsonEncode(g2gRecipient.toMap())}");
    print("this the map=> ${jsonEncode(g.toMap())}");
  }


  canReceiveG2GDocument({required correspondenceId}) {
    G2GReceiveOrRejectDto g2gReceiveOrRejectDto = G2GReceiveOrRejectDto(
        documentId:correspondenceId, language:Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar", token:secureStorage.token()!, notes:"");
    _canReceiveG2GDocumentAPI.post( g2gReceiveOrRejectDto.toMap()).then((value) {});
  }

  receiveDocumentUsingG2G({required correspondenceId}) {
    G2GReceiveOrRejectDto g2gReceiveOrRejectDto = G2GReceiveOrRejectDto(
        documentId:correspondenceId, language:Get
        .locale?.languageCode == "en"
        ? "en"
        : "ar", token:secureStorage.token()!, notes:"");
    _receiveDocumentUsingG2GApi.post( g2gReceiveOrRejectDto.toMap()).then((value) {});
  }
}

showDilog({required context,required String massge,required VoidCallback yes,required VoidCallback no}){
  return showDialog(
      context: context,
      builder: (BuildContext
      context) {
        return AlertDialog(
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Spacer(),
                InkWell(
                  onTap:
                      () {

                    Navigator.pop(
                        context);
                  },
                  child: Image
                      .asset(
                    'assets/images/close_button.png',
                    width:
                    20,
                    height:
                    20,
                  ),
                ),
              ]),
          content:
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
Text(massge),
                ]),
          ),
          actions: <Widget>[
            TextButton(
              onPressed:yes
              //     () {
              //
              // }

              ,
              child: Text(
                  "Yes"),
            ),




            TextButton(
              onPressed:no
              //     () {
              //
              //
              //   //Navigator.of(context).pop();
              // }
              ,
              child: Text(
                  "No"),
            ),  ],
        );
      });

}
//
// String _fileName = 'Recording_';
// String _fileExtension = '.aac';
// String _directoryPath = '/storage/emulated/0/SoundRecorder';
// class Recorder {
//   FlutterSoundRecorder? _recorder;
//   bool _isRecorderInitialized = false;
//   bool get isRecording => _recorder!.isRecording;
//
//   Future init() async {
//     _recorder = FlutterSoundRecorder();
//     //final directory = "/sdcard/downloads/";
//     //Directory? extStorageDir = await getExternalStorageDirectory();
//     //String _path = directory.path;
//
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Recording permission required.');
//     }
//
//     await _recorder!.openAudioSession();
//     _isRecorderInitialized = true;
//   }
//
//   // void _writeFileToStorage() async {
//   //   File audiofile = File('$_path/$_fileName');
//   //   Uint8List bytes = await audiofile.readAsBytes();
//   //   audiofile.writeAsBytes(bytes);
//   // }
//
//   void dispose() {
//     _recorder!.closeAudioSession();
//     _recorder = null;
//     _isRecorderInitialized = false;
//   }
//
//   Future record() async {
//     if (!_isRecorderInitialized) {
//       return;
//     }
//     print('recording....');
//     await _recorder!.startRecorder(
//       toFile: '$_fileName',
//       //codec: Codec.aacMP4,
//     );
//   }
//
//   Future stop() async {
//     if (!_isRecorderInitialized) {
//       return;
//     }
//     await _recorder!.stopRecorder();
//     _writeFileToStorage();
//     print('stopped....');
//   }
//
//   Future toggleRecording() async {
//     if (_recorder!.isStopped) {
//       await record();
//     } else {
//       await stop();
//     }
//   }
//
//
//
//   void _createFile() async {
//     var _completeFileName = "oo";//await generateFileName();
//     File(_directoryPath + '/' + _completeFileName)
//         .create(recursive: true)
//         .then((File file) async {
//       //write to file
//       Uint8List bytes = await file.readAsBytes();
//       file.writeAsBytes(bytes);
//       print(file.path);
//     });
//   }
//
//   void _createDirectory() async {
//     bool isDirectoryCreated = await Directory(_directoryPath).exists();
//     if (!isDirectoryCreated) {
//       Directory(_directoryPath).create()
//       // The created directory is returned as a Future.
//           .then((Directory directory) {
//         print(directory.path);
//       });
//     }
//   }
//
//   void _writeFileToStorage() async {
//     _createDirectory();
//     _createFile();
//   }
// }
