

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class DocumentController extends GetxController {
  SecureStorage secureStorage = SecureStorage();
  FindRecipientModel? findRecipientModel;
  final FindRecipient _findRecipient=FindRecipient();

  List<Destination>users =[];
  List<Destination>usersWillSendTo=[] ;
  Map <String,dynamic>?logindata;


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
      listOfUser(0);
      //print(findRecipientModel?.toJson() );
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

  }

  @override
  void onClose() {



  super.onClose();
  }


  // void _createFile() async {
  //   var _completeFileName = "oo";//await generateFileName();
  //     appDocDir = await getApplicationDocumentsDirectory();
  //   print("this is path of ${appDocDir!.path}");
  //   File(appDocDir!.path + '/' + _completeFileName)
  //       .create(recursive: true)
  //       .then((File file) async {
  //     //write to file
  //     Uint8List bytes = await file.readAsBytes();
  //     file.writeAsBytes(bytes);
  //     print(file.path);
  //   });
  // }
  // void _createDirectory() async {
  //   bool isDirectoryCreated = await Directory(    appDocDir!.path).exists();
  //   if (!isDirectoryCreated) {
  //     Directory( appDocDir!.path).create()
  //     // The created directory is returned as a Future.
  //         .then((Directory directory) {
  //       print(directory.path);
  //     });
  //   }
  // }
//
// Http http = new Http();
  // DocumentModel documentModel = new DocumentModel();
  // bool openExportDialog = false;
  //
  // DocumentController() {
  //   getDocument(Globals.documentCorrespondenceId, Globals.documentTansferId);
  // }
  //
  // changeExportDialogState() {
  //   openExportDialog = !openExportDialog;
  //   notifyListeners();
  // }
  //
  // Future getDocument(String correspondenceId, String transferId) async {
  //   var defaultLocale = ui.window.locale.languageCode;
  //   String token = await AppCache.getSavedUserToken();
  //   try {
  //     var response = await http.getRequest(Globals.url +
  //         'CanOpenDocument?Token=$token&correspondenceId=$correspondenceId&transferId=$transferId&language=${defaultLocale == "en" ? "en" : "ar"}');
  //     var data = jsonDecode(response.body);
  //     documentModel = DocumentModel.fromJson(data);
  //     notifyListeners();
  //     return documentModel;
  //   } catch (error) {
  //     Exception(error);
  //   }
  // }










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



    await audioRecorder?.startRecorder(toFile: _directoryPath);
  }
  Future stop2()async{

    await audioRecorder?.stopRecorder();







  }
  playRec()async{
    await   audioPlayer!.openAudioSession();
    await    audioPlayer!.startPlayer(fromURI: _directoryPath);
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













