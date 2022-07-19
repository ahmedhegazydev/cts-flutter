

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
import '../services/json_model/can_open_document_model.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/get_document_links_model.dart';
import '../services/json_model/get_document_logs_model.dart';
import '../services/json_model/get_document_receivers_model.dart';
import '../services/json_model/get_document_transfers_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../services/models/signature_info.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import 'inbox_controller.dart';

class DocumentController extends GetxController {
  SecureStorage secureStorage = SecureStorage();
  CanOpenDocumentModel? canOpenDocumentModel;
  Map <String,dynamic>?logindata;
Map<GlobalKey,String>singpic={};
  List<Widget>pdfAndSing=[
    SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')];


addWidgetToPdfAndSing(Widget pic){
  pdfAndSing.add(pic);
  update();
}
  List<MultiSignatures> multiSignatures=[];
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  exportBackgroundColor: Colors.transparent ,
  );





  FindRecipientModel? findRecipientModel;
  final FindRecipient _findRecipient=FindRecipient();
//===============================================
  final   GetDocumentAuditLogsApi _getDocumentAuditLogsApi=GetDocumentAuditLogsApi();
  GetDocumentLogsModel? getDocumentLogsModel;
final GetDocumentLinksApi _getDocumentLinksApi=GetDocumentLinksApi();
  GetDocumentLinksModel? getDocumentLinksModel;
final GetDocumentReceiversApi _getDocumentReceiversApi=GetDocumentReceiversApi();
  GetDocumentReceiversModel? getDocumentReceiversModel;
final GetDocumentTransfersApi _getDocumentTransfersApi=GetDocumentTransfersApi();

  GetDocumentTransfersModel? getDocumentTransfersModel;

  getDocumentAuditLogsdata({required String docId}){
    _getDocumentAuditLogsApi.data="Token=${secureStorage.token()}&docId=$docId&language=${Get.locale?.languageCode=="en"?"en":"ar"}";



     _getDocumentAuditLogsApi.getData().then((value) {
      getDocumentLogsModel=value as GetDocumentLogsModel;
     });
  }


  getDocumentLinksdata({correspondenceId,transferId}){
    _getDocumentLinksApi.data="Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode=="en"?"en":"ar"}";//"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";



    _getDocumentLinksApi.getData().then((value) {
      getDocumentLinksModel=value as GetDocumentLinksModel;
    });
  }

  getDocumentReceiversdata({correspondenceId,transferId}){
    _getDocumentReceiversApi.data="Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode=="en"?"en":"ar"}";//"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";



    _getDocumentReceiversApi.getData().then((value) {
      getDocumentReceiversModel=value as GetDocumentReceiversModel;
    });
  }




  getDocumentTransfersdata({correspondenceId,transferId}){
    _getDocumentTransfersApi.data="Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode=="en"?"en":"ar"}";//"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";



    _getDocumentTransfersApi.getData().then((value) {
      getDocumentTransfersModel=value as GetDocumentTransfersModel;
    });
  }


  gatAllDataAboutDOC({required String docId,required String transferId,required String correspondenceId}){
    print("gatAllDataAboutDOC");
   getDocumentAuditLogsdata(docId: docId);
   getDocumentTransfersdata(transferId:transferId ,correspondenceId: correspondenceId);
   getDocumentReceiversdata(correspondenceId:correspondenceId,transferId: transferId );
   getDocumentLinksdata(transferId: transferId,correspondenceId:correspondenceId );
    print("*"*10);
  }
//===============================================
  List<Destination>users =[];
  List<Destination>usersWillSendTo=[] ;



  String filterWord="";
  filterUser(String name){

    filterWord=name;
    update();

  }

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
  getFindRecipientData(){

    _findRecipient.data="Token=${secureStorage.token()}&language=${Get.locale?.languageCode=="en"?"en":"ar"}";
    _findRecipient.getData().then((value) {
      findRecipientModel=value as FindRecipientModel;


      Get.find<InboxController>().setFindRecipientData(findRecipientModel!);
      listOfUser(0);
      print("tis is  findRecipientModel?.toJson()              =>  ${findRecipientModel?.toJson()}" );
    });
  }

  List<CustomActions>? customActions=[];
late  Correspondences correspondences;
 //PDFDocument? doc;

Map<String,String>actions={};

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
  loadPdf()async{                             //correspondences.visualTrackingUrl
 //  doc = await PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf');
    print("get the pdf");
  update();
}

  @override
  void onReady() {
    super.onReady();

 logindata=secureStorage.readSecureJsonData(AllStringConst.LogInData) ;
    if(logindata!=null){
      LoginModel data=LoginModel.fromJson(logindata!);
      customActions=data.customActions;

      multiSignatures=  data.multiSignatures??[];
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
  }

  @override
  void onClose() {



  super.onClose();
  }











  FlutterSoundRecorder? audioRecorder;
  FlutterSoundPlayer? audioPlayer;
  final pathToSave="audio.aac";
  bool recording=false;
  String _directoryPath = '/storage/emulated/0/SoundRecorder';
  Directory? appDocDir;
  File? recordFile;

  Codec _codec = Codec.aacMP4;
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



    await audioRecorder?.startRecorder(toFile: _directoryPath);
  }
  Future stop2()async{

    await audioRecorder?.stopRecorder();







  }
  playRec()async{
    await   audioPlayer!.openAudioSession();
    await    audioPlayer!.startPlayer(fromURI: _directoryPath);
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
    transfarForMany[id] ?.actionType=customActions.name;
    update();
  }

  setNots({required int id,  String? not}) {
    transfarForMany[id] ?.notes= not;
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
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp4';
    recording = true;
    update( );

    await audioRecorder?.startRecorder(codec: _codec, toFile: _directoryPath);
  }

  Future stopForMany({required int id}) async {
    await audioRecorder?.stopRecorder();
    recordFile = File(_directoryPath);
    recording = false;
    String? audioFileBes64 =
    await audiobase64String(
        file:  recordFile);
    update( );
    transfarForMany[id]?.voiceNote=audioFileBes64;

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
        language: Get.locale?.languageCode == "en" ? "en" : "ar",token:secureStorage.token() );
    transfarForMany[id] = model;
  }



































  filePickerR() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
  File file = File(result.files.single.path!);

  } else {

  }
}





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













