import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cts/models/DocumentModel.dart' as DocModel;
import 'package:cts/services/apis/inside_doc/g2g/eport_using_g2g_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../models/CorrespondencesModel.dart';
import '../models/DocumentModel.dart';
import '../screens/resize_sing.dart';
import '../services/apis/favorites/ListFavoriteRecipients_api.dart';
import '../services/apis/find_recipient_api.dart';
import '../services/apis/inOpenDocument/GetAttachmentItem_api.dart';
import '../services/apis/inOpenDocument/get_document_audit_logs_api.dart';
import '../services/apis/inOpenDocument/get_document_links_api.dart';
import '../services/apis/inOpenDocument/get_document_receivers_api.dart';
import '../services/apis/inOpenDocument/get_document_transfers_api.dart';
import '../services/apis/inOpenDocument/upload_attachment_api.dart';
import '../services/apis/inside_doc/auto_send_to_recepients_and-cc_api.dart';
import '../services/apis/inside_doc/can_export_as_paperwork_api.dart';
import '../services/apis/inside_doc/check_for_empty_structure_recipients_api.dart';
import '../services/apis/inside_doc/g2g/can_receive_g2g_document_api.dart';
import '../services/apis/inside_doc/g2g/g2g_info_for_export_api.dart';
import '../services/apis/inside_doc/g2g/receive_document_using_g2g_api.dart';
import '../services/apis/inside_doc/get_user_routing_api.dart';
import '../services/apis/inside_doc/is_already_exported_as_paperwork_api.dart';
import '../services/apis/inside_doc/is_already_exported_as_transfer_api.dart';
import '../services/apis/multiple_transfers_api.dart';
import '../services/apis/save_document_annotations_api.dart';
import '../services/json_model/can_open_document_model.dart';
import '../services/json_model/default_on_success_result.dart';
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_response.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_correspondences_model.dart';
import '../services/json_model/get_document_links_model.dart';
import '../services/json_model/get_document_logs_model.dart';
import '../services/json_model/get_document_receivers_model.dart';
import '../services/json_model/get_document_transfers_model.dart';
import '../services/json_model/inopendocModel/annotations_model.dart';
import '../services/json_model/inopendocModel/attachment_Info_model.dart';
import '../services/json_model/inopendocModel/auto_send_to_recepients_and_cc_model.dart';
import '../services/json_model/inopendocModel/can_export_as_paperwork_model.dart';
import '../services/json_model/inopendocModel/check_for_empty_structure_recipients_model.dart';
import '../services/json_model/inopendocModel/g2g/export_usign_g2g_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_export_dto.dart';
import '../services/json_model/inopendocModel/g2g/g2g_export_dto.dart';
import '../services/json_model/inopendocModel/g2g/g2g_receive_or_reject_dto.dart';
import '../services/json_model/inopendocModel/get_attachment_item_model.dart';
import '../services/json_model/inopendocModel/get_user_routing_model.dart';
import '../services/json_model/inopendocModel/getatt_achments_model.dart'
    as getatt_achments_model;
import '../services/json_model/inopendocModel/getatt_achments_model.dart';
import '../services/json_model/inopendocModel/is_already_exported_as_paperwork_model.dart';
import '../services/json_model/inopendocModel/is_already_exported_as_transfer_model.dart';
import '../services/json_model/inopendocModel/multiple_transfers_model.dart';
import '../services/json_model/inopendocModel/save_document_annotation_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../services/models/multiple_transfers_model_send.dart'
    as multipletransfersSend;
import '../services/models/signature_info.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button_with_icon.dart';
import 'inbox_controller.dart';
import 'package:flutter/services.dart' as rootBundel;

class DocumentController extends GetxController {
  SecureStorage secureStorage = SecureStorage();
  CanOpenDocumentModel? canOpenDocumentModel;
  final record = FlutterSoundRecorder();

//Map<int,String>folder={};
  bool notoragnalFileDoc = false;

  String oragnalFileDocpdfUrlFile = "";

  //  'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
  String pdfUrlFile = "";

  // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
  bool openAttachment = false;
  AttachmentsList? isOriginalMailAttachmentsList;
  Map<String, List<AttachmentsList>> folder2 = {};

  AttachmentInfoModel? attachmentInfoModel;

  Parents? toParent;

  TextEditingController textEditingControllerTodepartment =
      TextEditingController();

  Parents? ccToParent;

  //Export Using G2G
  TextEditingController textEditingControllerG2gNotes = TextEditingController();
  TextEditingController textEditingControllerToParent = TextEditingController();
  TextEditingController textEditingControllerToccParent =
      TextEditingController();

  TextEditingController textEditingControllerToccdepartment =
      TextEditingController();

  List<DepartmentList> toDepartmentList = [];

  List<DepartmentList> cctoDepartmentList = [];
  PdfViewerController? pdfViewerController = PdfViewerController();
  GlobalKey? pdfViewerkey;

  updateopenAttashment(String link) {
    openAttachment = true;

    update();
  }

  updatecloseAttashment(String link) {
    openAttachment = false;

    update();
  }

  addtoDepartmentList({required DepartmentList department}) {
    toDepartmentList.add(department);
    update();
  }

  addcctoDepartmentList({required DepartmentList department}) {
    cctoDepartmentList.add(department);
    update();
  }

  deltoDepartmentList({required DepartmentList department}) {
    toDepartmentList.remove(department);
    update();
  }

  delcctoDepartmentList({required DepartmentList department}) {
    cctoDepartmentList.remove(department);
    update();
  }

  GetAttAchmentItem? getAttAchmentItem;

  //دي الرد بتاع السيف للاتاتشمنت
  getatt_achments_model.Attachments? saveAttAchmentItemAnnotationsresalt;
  GetattAchmentsModel? saveAttAchmentItemAnnotationsData;

  getAttachmentItem({context, documentId, transferId, attachmentId}) {
    GetAttachmentItemAPI getAttachmentItemAPI = GetAttachmentItemAPI(context);
    getAttachmentItemAPI.data =
        "Token=${secureStorage.token()}&documentId=$documentId&transferId=$transferId&attachmentId=$attachmentId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    getAttachmentItemAPI.getData().then((value) {
      getAttAchmentItem = value as GetAttAchmentItem;
    });
  }

//open the AttachmentItem
//   getAttachmentItemlocal(
//       {documentId, transferId, attachmentId, required BuildContext context}) async {
//
//     notoragnalFileDoc=true;
//
//     final jsondata = await rootBundel.rootBundle.loadString(
//         "assets/json/getattachmentitem.json");
//
//     getAttAchmentItem = GetAttAchmentItem.fromJson(json.decode(jsondata));
//     print("g2gInfoForExportModel?.toJson()=>  ${g2gInfoForExportModel
//         ?.toJson()}");
//
//     pdfUrlFile=   getAttAchmentItem!.attachment!.uRL!;
//
// update();
//
//
//     // showDialog(
//     //     context: context,
//     //     builder: (BuildContext context) {
//     //       return AlertDialog(
//     //         title: Text(getAttAchmentItem!.attachment!.fileName!),
//     //         content: SizedBox(
//     //             height: MediaQuery
//     //                 .of(context)
//     //                 .size
//     //                 .height * .7,
//     //             width: MediaQuery
//     //                 .of(context)
//     //                 .size
//     //                 .width * .7,
//     //             child: SfPdfViewer.network(
//     //               //'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'
//     //                 getAttAchmentItem!.attachment!.uRL!
//     //
//     //             )),
//     //         actions: <Widget>[
//     //           TextButton(
//     //             onPressed: () {
//     //               Navigator.of(context).pop();
//     //             },
//     //             child: Text("Ok"),
//     //           ),
//     //         ],
//     //       );
//     //     });
//   }

  // [OperationContract]
  // [WebGet(RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json,
  // UriTemplate = "GetAttachmentItem?)]
  // GetAttachmentItemResult GetAttachmentItem(string Token, string documentId, string transferId, string attachmentId, string language);
  //

//=============================================================================================

  multipleTransferspost({context, correspondenceId, transferId}) {
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
      multiTransferNode[key]?.purposeId =
          canOpenDocumentModel!.correspondence!.purposeId;
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
      DefaultOnSuccessResult defaultOnSuccessResult=value as DefaultOnSuccessResult;

      Get.snackbar("", "تم التنفيذ بنجاح");

    });
  }

//=====================================================================================

  SaveDocumentAnnotationModel? postSaveDocumentAnnotationsModel;

  Future getSaveDocAnnotationsData(
      {context,
      userId,
      correspondenceId,
      transferId,
      attachmentId,
      isOriginalMail, //(string) input should “true” or “false”
      required List<DocumentAnnotations>
          documentAnnotationsString, //string converted from array contains the details of annotations)
      delegateGctId //string) input “0”

      }) async {
    final SaveDocumentAnnotationsAPI _saveDocumentAnnotationsApi =
        SaveDocumentAnnotationsAPI(context);
    // pdfViewerkey=null;
    postSaveDocumentAnnotationsModel = SaveDocumentAnnotationModel(
        AttachmentId: attachmentId.toString(),
        CorrespondenceId: correspondenceId,
        DelegateGctId: delegateGctId,
        documentAnnotationsString: documentAnnotationsString,
        IsOriginalMail: isOriginalMail,
        Token: secureStorage.token(),
        UserId: userId,
        TransferId: transferId);
    //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    //  print("postSaveDocumentAnnotationsModel?.toMap() =>${jsonEncode(postSaveDocumentAnnotationsModel?.toMap())}");

    await _saveDocumentAnnotationsApi
        .post(postSaveDocumentAnnotationsModel?.toMap())
        .then((value) {
      // print("value =>   ${value}");
      saveAttAchmentItemAnnotationsData = value as GetattAchmentsModel;
      for (int i = 0;
          i < (saveAttAchmentItemAnnotationsData?.attachments?.length ?? 0);
          i++) {
        if (saveAttAchmentItemAnnotationsData!.attachments![i].attachmentId ==
            getAttAchmentItem!.attachment!.attachmentId) {
          pdfUrlFile = saveAttAchmentItemAnnotationsData!.attachments![i]
              .uRL!; //"http://www.africau.edu/images/default/sample.pdf";
          print(pdfUrlFile);
          saveAttAchmentItemAnnotationsresalt =
              saveAttAchmentItemAnnotationsData!.attachments![i];
          pdfAndSing.clear();
          singpic.clear();
          pdfAndSingannotation.clear();
          pdfUrlFile = saveAttAchmentItemAnnotationsData!.attachments![i].uRL!;
          //   pdfUrlFile = 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
          pdfAndSing.add(SfPdfViewer.network(
            pdfUrlFile,
            controller: pdfViewerController,
            onPageChanged: (v) {
              print(
                  "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
              for (int i = 0; i < pdfAndSingannotation.length; i++) {
                if (int.parse(pdfAndSingannotation[i].page!) ==
                    v.newPageNumber) {
                  List<int> list = pdfAndSingannotation[i].imageByte!.codeUnits;
                  final Uint8List? data = Uint8List.fromList(list);
                  pdfAndSingannotationShowOrHide.add(
                    Positioned(
                      top: double.tryParse(pdfAndSingannotation[i].y!),
                      left: double.tryParse(pdfAndSingannotation[i].x!),
                      child: Image.memory(
                        data!,
                        fit: BoxFit.fill,
                        width: double.tryParse(pdfAndSingannotation[i].width!),
                        height:
                            double.tryParse(pdfAndSingannotation[i].height!),
                      ),
                    ),
                  );
                }
              }
              // pdfAndSingannotation
              //   v.newPageNumber
            },
            //  key: pdfViewerkey,
          ));

          if (saveAttAchmentItemAnnotationsData!.attachments![i].annotations!
              .contains("[]")) {
            print("[]");
          } else {
            print("i will addddddd");
            Map<dynamic, dynamic> dat = jsonDecode(
                saveAttAchmentItemAnnotationsData!
                    .attachments![i].annotations!);
            dat.forEach((key, value) async {
              print("--------------------------------------------");
              Annotation annotation = Annotation.fromJson(value[0]);
              List<int> list = annotation.imageByte!.codeUnits;
              final Uint8List? data = Uint8List.fromList(list);
              print("the data is $data");

              pdfAndSingannotation.add(annotation);
              // pdfAndSingannotation.add(
              //   Positioned(
              //     top: double.tryParse(annotation.y!),
              //     left: double.tryParse(annotation.x!),
              //     child: Image.memory(
              //       data!,
              //       fit: BoxFit.fill,
              //       width: double.tryParse(annotation.width!),
              //       height: double.tryParse(annotation.height!),
              //     ),
              //   ),
              // );

              pdfUrlFile =
                  saveAttAchmentItemAnnotationsData!.attachments![i].uRL!;
            });
          }
          // log(saveAttAchmentItemAnnotationsData.toString());
          // // String d=saveAttAchmentItemAnnotationsresalt!.annotations!..replaceAll(new RegExp(r'[^\w\s]+'),'');
          // print("ddddddddddddddddddddddd=>  ${saveAttAchmentItemAnnotationsresalt?.annotations}");
          //
          //          Map<String,dynamic>dat=jsonDecode(saveAttAchmentItemAnnotationsresalt?.annotations??"");
          //
          //
          //     //   DocumentAnnotations a=DocumentAnnotations.fromJson(jsonDecode( saveAttAchmentItemAnnotationsresalt!.annotations!));
          //
          //          //update();
        }
      }
//       saveAttAchmentItemAnnotationsData?.attachments?.forEach((element) {
//         if(element.attachmentId==getAttAchmentItem!.attachment!.attachmentId){
//
//           pdfUrlFile=element.uRL!;//"http://www.africau.edu/images/default/sample.pdf";
// print(pdfUrlFile);
//           saveAttAchmentItemAnnotationsresalt=element;
//          pdfAndSing.clear();
//          singpic.clear();
//           pdfUrlFile= element.uRL!;// 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
//           pdfAndSing.add(SfPdfViewer.network(
//             pdfUrlFile
//
//             , controller: pdfViewerController,
//           //  key: pdfViewerkey,
//           ));
//
//           if(element.annotations!.contains("[]")){
//             print("[]");
//           }
//           else{
//             print("i will addddddd");
//             Map<dynamic,dynamic> dat=jsonDecode(element.annotations!);
//             dat.forEach((key, value) async{
//               print("--------------------------------------------");
//               Annotation annotation= Annotation.fromJson( value[0]);
//               List<int> list = annotation.imageByte!.codeUnits;
//               final Uint8List? data =    Uint8List.fromList(list);
//               print("the data is $data");
//
//
//
//               pdfAndSingannotation.add(
//                 Visibility(
//                   child: Positioned(top: double.tryParse(annotation.y!),left:double.tryParse(annotation.x!),
//                         child: Image
//                             .memory(
//                           data!,
//                           fit: BoxFit
//                               .fill,
//
//                           width: double.tryParse(annotation.width!),
//                           height:  double.tryParse(annotation.height!),
//                         ),
//                       ),
//                 ),
//                   );
//               addWidgetToPdfAndSing(
//                   Positioned(top: 100,right:500,
//                       child:Container(height: 100,width: 100, color: Colors.red,)
//                   ));
//               pdfUrlFile=element.uRL!;
//               print(pdfUrlFile);
//
//
//               print(addWidgetToPdfAndSing);
//               print("i add image");
//             });
//           }
//           log(saveAttAchmentItemAnnotationsData.toString());
//  // // String d=saveAttAchmentItemAnnotationsresalt!.annotations!..replaceAll(new RegExp(r'[^\w\s]+'),'');
//  // print("ddddddddddddddddddddddd=>  ${saveAttAchmentItemAnnotationsresalt?.annotations}");
//  //
//  //          Map<String,dynamic>dat=jsonDecode(saveAttAchmentItemAnnotationsresalt?.annotations??"");
//  //
//  //
//  //     //   DocumentAnnotations a=DocumentAnnotations.fromJson(jsonDecode( saveAttAchmentItemAnnotationsresalt!.annotations!));
//  //
//  //          //update();
//         }
//
//       });
    });
  }

//   Future getSaveDocAnnotationsDataLocalJson() async {
//     ///ToDo is oraginal file
//     ///
//     notoragnalFileDoc = true;
//     final jsondata = await rootBundel.rootBundle
//         .loadString("assets/json/getattachments.json");
//     saveAttAchmentItemAnnotationsData =
//         GetattAchmentsModel.fromJson(jsonDecode(jsondata));
//     pdfAndSing.clear();
//     singpic.clear();
//
//     saveAttAchmentItemAnnotationsData?.attachments?.forEach((element) {
//       //   print("saveAttAchmentItemAnnotationsData=>   \n${element.toJson()}");
//       // String a= element.annotations!.replaceAll(r"\", ""); //.replaceAll(new RegExp(r'[^\w\s]+'),'');
//       //  var bbb=jsonDecode(a);
// //element.attachmentId==getAttAchmentItem!.attachment!.attachmentId
//       if (true) {
//         saveAttAchmentItemAnnotationsresalt = element;
//
//         //  pdfViewerkey=null;
//         //  pdfViewerController=null;
//         pdfUrlFile =
//             'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
//
//         pdfAndSing.add(SfPdfViewer.network(
//           pdfUrlFile
//           // saveAttAchmentItemAnnotationsresalt!.uRL!
//           // oragnalFileDoc??""
//           ,
//           controller: pdfViewerController,
//           //   key: pdfViewerkey,
//         ));
//
//         // pdfAndSing.add(Positioned(top: 100,right:100,
//         //     child:Container(height: 100,width: 100, color: Colors.red,)
//         // ));
//
//         if (element.annotations!.contains("[]")) {
//           print("[]");
//         } else {
//           print("i will addddddd");
//           Map<dynamic, dynamic> dat = jsonDecode(element.annotations!);
//           dat.forEach((key, value) async {
//             print("--------------------------------------------");
//             Annotation annotation = Annotation.fromJson(value[0]);
//             List<int> list = annotation.imageByte!.codeUnits;
//             final Uint8List? data = Uint8List.fromList(list);
//             print("the data is $data");
//             addWidgetToPdfAndSing(Positioned(
//               top: double.tryParse(annotation.y!),
//               right: double.tryParse(annotation.x!),
//               child: Image.memory(
//                 data!,
//                 fit: BoxFit.fill,
//                 width: double.tryParse(annotation.width!),
//                 height: double.tryParse(annotation.height!),
//               ),
//             ));
//             addWidgetToPdfAndSing(Positioned(
//                 top: 100,
//                 right: 500,
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   color: Colors.red,
//                 )));
//             pdfUrlFile = element.uRL!;
//             print(pdfUrlFile);
//
//             print(addWidgetToPdfAndSing);
//             print("i add image");
//           });
//         }
//         log(saveAttAchmentItemAnnotationsData.toString());
//         print(
//             "saveAttAchmentItemAnnotationsresalt!.annotations!=99999>  ${saveAttAchmentItemAnnotationsresalt!.annotations}");
//
//         update();
//       }
//
//       // Map<String, dynamic> dat=   new Map<String, dynamic>.from(json.decode(element.annotations!));
//       // print("ddddddddddddddddddddddd=>  ${saveAttAchmentItemAnnotationsresalt?.annotations}");
//
// //       if(dat.runtimeType is List<dynamic>){
// //         print(dat.runtimeType );
// //       }
// // else{ print(dat as Map<dynamic,dynamic>);
// //
// //       }
//       // printWrapped("dat=> $dat");
//       //print(dat);
//       //  debugPrint(bbb.toString(), wrapWidth: 1024);
//     });
//
//     update();
//   }

  backTooragnalFileDocpdf() {
    notoragnalFileDoc = false;
    // pdfViewerkey=null;

    pdfAndSing.clear();
    singpic.clear();
    // pdfUrlFile =
    //     'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
    pdfAndSing.add(SfPdfViewer.network(
      pdfUrlFile
      //   saveAttAchmentItemAnnotationsresalt!.uRL!
      // oragnalFileDoc??""
      ,
      controller: pdfViewerController,
      // key: pdfViewerkey,
    ));
    update();
  }

  //تحديث كان ابن فيل وجلب جميع البيانات الخاصه بلملف
  updatecanOpenDocumentModel(CanOpenDocumentModel data) {
    canOpenDocumentModel = data;
    canOpenDocumentModel?.attachments?.attachments?.forEach((element) {
      if (element.isOriginalMail!) {
        print("element.uRL=>      ${element.uRL}");
        oragnalFileDocpdfUrlFile = element.uRL!;
        isOriginalMailAttachmentsList = element;

        pdfViewerkey = GlobalKey();
        pdfAndSing.clear();
        pdfAndSing.add(SfPdfViewer.network(
          oragnalFileDocpdfUrlFile
          // oragnalFileDoc??""
          ,
          controller: pdfViewerController,
          // onPageChanged: (v) {
          //   print(
          //       "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
          //   for (int i = 0; i < pdfAndSingannotation.length; i++) {
          //     if (int.parse(pdfAndSingannotation[i].page!) ==
          //         v.newPageNumber) {
          //       List<int> list = pdfAndSingannotation[i].imageByte!.codeUnits;
          //       final Uint8List? data = Uint8List.fromList(list);
          //       pdfAndSingannotationShowOrHide.add(
          //         Positioned(
          //           top: double.tryParse(pdfAndSingannotation[i].y!),
          //           left: double.tryParse(pdfAndSingannotation[i].x!),
          //           child: Image.memory(
          //             data!,
          //             fit: BoxFit.fill,
          //             width: double.tryParse(pdfAndSingannotation[i].width!),
          //             height:
          //             double.tryParse(pdfAndSingannotation[i].height!),
          //           ),
          //         ),
          //       );
          //     }
          //   }
          //   // pdfAndSingannotation
          //   //   v.newPageNumber
          // }
          //  key: pdfViewerkey,
        ));

        log(element.annotations!);
        Map<String, dynamic> dat = jsonDecode(element.annotations!);
        print("77777777777777777=>     ${dat.values.toList()}");

        ViewerAnnotation daa = ViewerAnnotation.fromMap(dat);
        print("88888888=>     ${daa.toMap()}");
        // Positioned(
        //   top: double.tryParse(dat["Y"]),
        //   left: double.tryParse(dat["X"]),
        //   child: Image.memory(
        //     dat["ImageByte"],
        //     fit: BoxFit.fill,
        //     width: double.tryParse(dat["Width"]),
        //     height:
        //     double.tryParse(dat["Height"]),
        //   ),
        // );
        //

        update();
      }

      if (element.isOriginalMail == false) {
        if (folder2[element.folderName] != null) {
          folder2[element.folderName]?.add(element);
        } else {
          List<AttachmentsList> a = [];
          a.add(element);
          folder2[element.folderName!] = a;
        }
      }
    });
    print("folder2=>${folder2.length}");
    print("folder2=>${folder2}");
    // for(int i=0;i< ( canOpenDocumentModel?.attachments?.attachments?.length??0);i++){
    //   folder[i]=canOpenDocumentModel!.attachments!.attachments![i]!.folderName!;
    //
    //
    // }

    for (int i = 0; i < pdfAndSingannotation.length; i++) {
      List<int> list = pdfAndSingannotation[i].imageByte!.codeUnits;
      final Uint8List? data = Uint8List.fromList(list);
      pdfAndSingannotationShowOrHide.add(
        Positioned(
          top: double.tryParse(pdfAndSingannotation[i].y!),
          left: double.tryParse(pdfAndSingannotation[i].x!),
          child: Image.memory(
            data!,
            fit: BoxFit.fill,
            width: double.tryParse(pdfAndSingannotation[i].width!),
            height: double.tryParse(pdfAndSingannotation[i].height!),
          ),
        ),
      );
    }
    update();
  }

  IsAlreadyExportedAsPaperworkModel? isAlreadyExportedAsPaperworkModel;

  CanExportAsPaperworkModel? canExportAsPaperworkModel;

  AutoSendToRecepientsAndCCModel? autoSendToRecepientsAndCCModel;

  CheckForEmptyStructureRecipientsModel? checkForEmptyStructureRecipientsModel;

  IsAlreadyExportedAsTransferModel? isAlreadyExportedAsTransferModel;

  GetUserRoutingModel? getUserRoutingModel;

  G2GInfoForExportModel? g2gInfoForExportModel;

  //Export using G2G

  // G2GExportDto? g2gExportDto;
  // G2GRecipient? g2gRecipient;
  ExportUsingG2gModel? exportUsingG2gModel;

  Map<String, dynamic>? logindata;
  Map<GlobalKey, String> singpic = {};
  List<Widget> pdfAndSing = [];

  //لسته الامضاء القادمه مع الملف
  List<Annotation> pdfAndSingannotation = [];
  List<Widget> pdfAndSingannotationShowOrHide = [];

  Map<GlobalKey, String> singpicopenattachment = {};
  List<Widget> pdfAndSingopenattachment = [];

  // deleteItem(DocModel.Attachments item) {
  deleteItem(AttachmentsG2gInfoExport item) {
    print("remove: $item");
    print(
        "Number of items before: ${g2gInfoForExportModel?.attachments?.length}");
    g2gInfoForExportModel?.attachments?.remove(item);
    print(
        "Number of items after delete: ${g2gInfoForExportModel?.attachments?.length}");
    update();
  }

  addWidgetToPdfAndSingopenattachment(Widget pic) {
    pdfAndSingopenattachment.add(pic);
    update();
  }

  addWidgetToPdfAndSing(Widget pic) {
    pdfAndSing.add(pic);
    print("pdfAndSing.lengthpdfAndSing.length=>   ${pdfAndSing.length}");
    update();
  }

  List<MultiSignatures> multiSignatures = [];
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  FindRecipientModel? findRecipientModel;

//===============================================

  GetDocumentLogsModel? getDocumentLogsModel;

  GetDocumentLinksModel? getDocumentLinksModel;

  GetDocumentReceiversModel? getDocumentReceiversModel;

  GetDocumentTransfersModel? getDocumentTransfersModel;

  //9/7/2022
  // ظظ الشغل الي اتكلم فيه حسين//
//==================================================================================================
  getDocumentAuditLogsdata({required context, required String docId}) {
    final GetDocumentAuditLogsApi _getDocumentAuditLogsApi =
        GetDocumentAuditLogsApi(context);
    _getDocumentAuditLogsApi.data =
        "Token=${secureStorage.token()}&docId=$docId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";

    _getDocumentAuditLogsApi.getData().then((value) {
      getDocumentLogsModel = value as GetDocumentLogsModel;
    });
  }

  getDocumentLinksdata({required context, correspondenceId, transferId}) {
    final GetDocumentLinksApi _getDocumentLinksApi =
        GetDocumentLinksApi(context);
    _getDocumentLinksApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    _getDocumentLinksApi.getData().then((value) {
      getDocumentLinksModel = value as GetDocumentLinksModel;
    });
  }

  getDocumentReceiversdata({required context, correspondenceId, transferId}) {
    final GetDocumentReceiversApi _getDocumentReceiversApi =
        GetDocumentReceiversApi(context);
    _getDocumentReceiversApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    _getDocumentReceiversApi.getData().then((value) {
      getDocumentReceiversModel = value as GetDocumentReceiversModel;
    });
  }

  getDocumentTransfersdata({required context, correspondenceId, transferId}) {
    final GetDocumentTransfersApi _getDocumentTransfersApi =
        GetDocumentTransfersApi(context);
    _getDocumentTransfersApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    _getDocumentTransfersApi.getData().then((value) {
      getDocumentTransfersModel = value as GetDocumentTransfersModel;
    });
  }

  gatAllDataAboutDOC(
      {required context,
      required String docId,
      required String transferId,
      required String correspondenceId}) {
    print("gatAllDataAboutDOC");
    getDocumentAuditLogsdata(context: context, docId: docId);
    getDocumentTransfersdata(
        context: context,
        transferId: transferId,
        correspondenceId: correspondenceId);
    getDocumentReceiversdata(
        context: context,
        correspondenceId: correspondenceId,
        transferId: transferId);
    getDocumentLinksdata(
        context: context,
        transferId: transferId,
        correspondenceId: correspondenceId);
    print("*" * 10);
  }

//==================================================================================================
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
    multipletransfersSend.TransferNode transferNode =
        multipletransfersSend.TransferNode(
            purposeId: canOpenDocumentModel!.correspondence!.purposeId,destinationId: user.id.toString(),voiceNotePrivate: false);
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

  Future getFindRecipientData({context}) async {
    final FindRecipient _findRecipient = FindRecipient(context);
    _findRecipient.data =
        "Token=${secureStorage.token()}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    _findRecipient.getData().then((value) {
      findRecipientModel = value as FindRecipientModel;

      Get.find<InboxController>().context = context;
      Get.find<InboxController>().setFindRecipientData(findRecipientModel!);
      // listOfUser(0);
      print(
          "tis is  findRecipientModel?.toJson()              =>  ${findRecipientModel?.toJson()}");
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
//   await mPlayer!.stopPlayer();
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
    // getAttachmentItemlocal( );
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
//   await audioRecord!.stopPlayer();

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
    initRecorder();

    genratG2GExportDto();
    g2GInfoForExport();
    // pdfAndSing.add(SfPdfViewer.network(canOpenDocumentModel.correspondence.,
    //   // pdfUrlFile,
    //   controller: pdfViewerController,onPageChanged: (v){
    //
    //     print("ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    //     for(int i =0;i<pdfAndSingannotation.length;i++){
    //       if(int.parse(pdfAndSingannotation[i].page!)==    v.newPageNumber){
    //         List<int> list = pdfAndSingannotation[i].imageByte!.codeUnits;
    //         final Uint8List? data = Uint8List.fromList(list);
    //         pdfAndSingannotationShowOrHide.add(   Positioned(
    //           top: double.tryParse(pdfAndSingannotation[i].y!),
    //           left: double.tryParse(pdfAndSingannotation[i].x!),
    //           child: Image.memory(
    //             data!,
    //             fit: BoxFit.fill,
    //             width: double.tryParse(pdfAndSingannotation[i].width!),
    //             height: double.tryParse(pdfAndSingannotation[i].height!),
    //           ),
    //         ),);
    //       }
    //     }
    //     // pdfAndSingannotation
    //     //   v.newPageNumber
    //
    //   },
    //   //  key: pdfViewerkey,
    // ));
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
    // audioRecorder!.openAudioSession();
    audioRecorder!.stopRecorder();
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';

    await audioRecorder?.startRecorder(toFile: _directoryPath);
  }

  Future stop2() async {
    await audioRecorder?.stopRecorder();
  }

  playRec() async {
    // await audioPlayer!.openAudioSession();
    await audioPlayer!.stopPlayer();
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

  // setNots({required int id, String? not}) {
  //   transfarForMany[id]?.notes = not;
  //   update();
  // }

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
    // audioRecorder!.openAudioSession();
    audioRecorder!.stopRecorder();
    appDocDir = await getApplicationDocumentsDirectory();
    _directoryPath = appDocDir!.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
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

  filePickerR({context}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    UploadAttachmentApi _uploadAttachmentApi = UploadAttachmentApi(context);

    if (result != null) {
      File file = File(result.files.single.path!);
      final bytes = File(file.path).readAsBytesSync();

      String img64 = base64Encode(bytes);
      String name = file.path.split("/").last.split(".").first;
      print("filke path isss  =>${file.path}");
      print("name =>$name");
      print("img64 =>  $img64");
      attachmentInfoModel = AttachmentInfoModel(
          token: secureStorage.token()!,
          correspondenceId:
              canOpenDocumentModel!.correspondence!.correspondenceId!,
          fileName: name,
          fileContent: img64,
          language: Get.locale?.languageCode == "en" ? "en" : "ar");

      _uploadAttachmentApi.post(attachmentInfoModel?.toMap()).then((value) {
        print("object  $value");
      });
    } else {}
  }

  getIsAlreadyExportedAsPaperwork(
      {required correspondenceId,
      required transferId,
      required exportAction,
      required context}) async {
    IsAlreadyExportedAsPaperworkAPI _alreadyExportedAsPaperworkAPI =
        IsAlreadyExportedAsPaperworkAPI(context);
    print("in  getIsAlreadyExportedAsPaperwork");
    _alreadyExportedAsPaperworkAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    _alreadyExportedAsPaperworkAPI.getData().then((value) {
      isAlreadyExportedAsPaperworkModel =
          value as IsAlreadyExportedAsPaperworkModel;
      print(
          "canExportAsPaperworkModel =>  ${isAlreadyExportedAsPaperworkModel?.isConfirm}");

      if (isAlreadyExportedAsPaperworkModel?.isConfirm ?? false) {
        showDilog(
            context: context,
            massge: isAlreadyExportedAsPaperworkModel!.message!,
            no: () {
            //  Navigator.of(context).pop();
              getSwitchMethod(
                  exportAction: exportAction,
                  transferId: transferId,
                  correspondenceId: correspondenceId,
                  context: context,
                  name: isAlreadyExportedAsPaperworkModel?.noMethod??isAlreadyExportedAsPaperworkModel!.noMethod2!);
            },
            yes: () {
              // getCanExportAsPaperwork(
              //     exportAction: exportAction,
              //     transferId: transferId,
              //     correspondenceId: correspondenceId,
              //     context: context);
              print("oooooooooooooooooooooooooooooooooo");
              getSwitchMethod(
                  exportAction: exportAction,
                  transferId: transferId,
                  correspondenceId: correspondenceId,
                  context: context,
                  name: isAlreadyExportedAsPaperworkModel?.yesMethod??isAlreadyExportedAsPaperworkModel!.yesMethod2!);
              Get.back();
              // Navigator.of(context).pop();
            });
      }else if(isAlreadyExportedAsPaperworkModel?.request!=null ){
        getSwitchMethod(
            exportAction: exportAction,
            transferId: transferId,
            correspondenceId: correspondenceId,
            context: context,
            name: isAlreadyExportedAsPaperworkModel!.request!);
        Get.back();

      }

      else {


    Get.snackbar("", isAlreadyExportedAsPaperworkModel!.message!);


        // getSwitchMethod(
        //     exportAction: exportAction,
        //     transferId: transferId,
        //     correspondenceId: correspondenceId,
        //     context: context,
        //     name: isAlreadyExportedAsPaperworkModel!.request!);
        // Get.back();
        //


        //  Navigator.of(context).pop();
      }
      // print("_alreadyExportedAsPaperworkAPI =>  ${isAlreadyExportedAsPaperworkModel!.toJson()}");
    });
  }

Future  getCanExportAsPaperwork(
      {required correspondenceId,
      required transferId,
      required exportAction,
      required context}) async{
    CanExportAsPaperworkAPI _canExportAsPaperworkAPI =
        CanExportAsPaperworkAPI(null);
    _canExportAsPaperworkAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
  await  _canExportAsPaperworkAPI.getData().then((value) {
      canExportAsPaperworkModel = value as CanExportAsPaperworkModel;
      print(
          "canExportAsPaperworkModel =>  ${canExportAsPaperworkModel?.isConfirm}");





      // if(canExportAsPaperworkModel?.isConfirm??false){
      //   Get.snackbar("", canExportAsPaperworkModel!.message!);
      // }
      // print("_alreadyExportedAsPaperworkAPI =>  ${canExportAsPaperworkModel!.toJson()}");
//الي كان شغال
//       if (canExportAsPaperworkModel?.isConfirm ?? false) {
//         showDilog(
//             context: context,
//             massge: canExportAsPaperworkModel?.message??"",
//             no: () {
//             //  Navigator.of(context).pop();
//             },
//             yes:
//             // isAlreadyExportedAsTransferModel?.yesMethod2 != null ||
//             //         isAlreadyExportedAsTransferModel?.yesMethod != null
//             //     ?
//          ()
//
//             {
//                     print("oooooooooooooooooooooooooooooooooo");
//                     //  Navigator.of(context).pop();
//                     // getCanExportAsPaperwork(
//                     //     exportAction: exportAction,
//                     //     transferId: transferId,
//                     //     correspondenceId: correspondenceId,
//                     //     context: context);
//                  //   Get.back();
//                   }
//                 // : () {
//                 //    // Get.back();
//                 //   }
//
//
//                   );
//       }
    });


    canExportAsPaperworkModel=   await  _canExportAsPaperworkAPI.getData() as CanExportAsPaperworkModel;

    // if (canExportAsPaperworkModel?.isConfirm ?? false) {
    //   showDilog(
    //       context: context,
    //       massge: canExportAsPaperworkModel?.message??"",
    //       no: () {
    //          Navigator.of(context).pop();
    //       },
    //       yes:
    //       // isAlreadyExportedAsTransferModel?.yesMethod2 != null ||
    //       //         isAlreadyExportedAsTransferModel?.yesMethod != null
    //       //     ?
    //           ()
    //
    //       {
    //         print("oooooooooooooooooooooooooooooooooo");
    //         //  Navigator.of(context).pop();
    //         // getCanExportAsPaperwork(
    //         //     exportAction: exportAction,
    //         //     transferId: transferId,
    //         //     correspondenceId: correspondenceId,
    //         //     context: context);
    //         //   Get.back();
    //       }
    //     // : () {
    //     //    // Get.back();
    //     //   }
    //
    //
    //   );
    // }


  }

  autoSendToRecepientsAndCC(
      {required context,
      required correspondenceId,
      required transferId,
      required exportAction}) {
    AutoSendToRecepientsAndCCAPI _autoSendToRecepientsAndCCAPI =
        AutoSendToRecepientsAndCCAPI(context);
    _autoSendToRecepientsAndCCAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    _autoSendToRecepientsAndCCAPI.getData().then((value) {
      autoSendToRecepientsAndCCModel = value as AutoSendToRecepientsAndCCModel;

      if (autoSendToRecepientsAndCCModel?.isConfirm ?? false) {
        Get.snackbar("", autoSendToRecepientsAndCCModel!.message!);
      }
      print(
          "_alreadyExportedAsPaperworkAPI =>  ${autoSendToRecepientsAndCCModel!.toJson()}");
    });
  }

  checkForEmptyStructureRecipients(
      {required context,
      required correspondenceId,
      required transferId,
      required exportAction}) {
    CheckForEmptyStructureRecipientsAPI _checkForEmptyStructureRecipientsAPI =
        CheckForEmptyStructureRecipientsAPI(context);
    _checkForEmptyStructureRecipientsAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    _checkForEmptyStructureRecipientsAPI.getData().then((value) {
      checkForEmptyStructureRecipientsModel =
          value as CheckForEmptyStructureRecipientsModel;

      if (checkForEmptyStructureRecipientsModel?.isConfirm ?? false) {
        Get.snackbar("", checkForEmptyStructureRecipientsModel!.message!);
      }
      print(
          "_alreadyExportedAsPaperworkAPI =>  ${checkForEmptyStructureRecipientsModel!.toJson()}");
    });
  }

  isAlreadyExportedAsTransfer(
      {required context,
      required correspondenceId,
      required transferId,
      required exportAction}) {
    IsAlreadyExportedAsTransferAPI _isAlreadyExportedAsTransferAPI =
        IsAlreadyExportedAsTransferAPI(context);
    _isAlreadyExportedAsTransferAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    _isAlreadyExportedAsTransferAPI.getData().then((value) {
      isAlreadyExportedAsTransferModel =
          value as IsAlreadyExportedAsTransferModel;

      if (isAlreadyExportedAsTransferModel?.isConfirm ?? false) {
        Get.snackbar("", isAlreadyExportedAsTransferModel!.message!);
      }
      print(
          "_alreadyExportedAsPaperworkAPI =>  ${isAlreadyExportedAsTransferModel!.toJson()}");
    });
  }

  //-----------------------------------------------------------------------
  getUserRouting({required context, required gctId}) {
    GetUserRoutingAPI _getUserRoutingAPI = GetUserRoutingAPI(context);
    _getUserRoutingAPI.data = "Token=${secureStorage.token()}&GctId=$gctId";
    _getUserRoutingAPI.getData().then((value) {
      getUserRoutingModel = value as GetUserRoutingModel;
    });
  }

  g2gInfoForExport({
    required context,
    required documentId,
  }) {
    print("going to get");
    G2GInfoForExportAPI _g2gInfoForExportAPI = G2GInfoForExportAPI(context);
    _g2gInfoForExportAPI.data =
        "token=${secureStorage.token()}&documentId=$documentId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    _g2gInfoForExportAPI.getData().then((value) {
      g2gInfoForExportModel = value as G2GInfoForExportModel;
      print(
          "g2gInfoForExportModelg2gInfoForExportModel =>  ${g2gInfoForExportModel?.toJson()}");
    }).catchError((e) {
      print("err =>  $e");
    });
  }

  g2GInfoForExport() async {
    final jsondata = await rootBundel.rootBundle
        .loadString("assets/json/g2gInfoforexport.json");
    g2gInfoForExportModel =
        G2GInfoForExportModel.fromJson(json.decode(jsondata));

    print(
        "g2gInfoForExportModel?.toJson()=>  ${g2gInfoForExportModel?.toJson()}");
  }

//-----------------------------------------------------------------------------

//الي جم من الانبوكس عشان يتنادو لما ندخل الفيل
//   Get.find<DocumentController>()
//       .gatAllDataAboutDOC(
//   context: context,
//   docId:
//   correspondences[pos].purposeId!,
//   correspondenceId: correspondences[pos]
//       .correspondenceId!,
//   transferId:
//   correspondences[pos].transferId!);
//   Get.find<DocumentController>()
//       .g2gInfoForExport(
//   context: context,
//   documentId: correspondences[pos]
//       .correspondenceId!);

  //-----------------------------------------------------------------------
  genratG2GExportDto() {
    // g2gRecipient =
    // G2GRecipient(childId: 5, isCC: false, parentId: 10);
    // g2gExportDto = G2GExportDto(
    //     token: secureStorage.token(),
    //     language: Get.locale?.languageCode == "en" ? "en" : "ar",
    //     notes: " ",
    //     attachments: [],
    //     documentId: 2020,
    //     recipients: [g2gRecipient!]);
    //
    // print("this the map=> ${jsonEncode(g2gRecipient?.toMap())}");
    // print("this the map=> ${jsonEncode(g2gExportDto?.toMap())}");
  }

  exportUsingG2g({required context, notes}) {
    G2GExportDto? g2gExportDto;
    G2GRecipient? g2gRecipient;
    List<int>? attachmentsIds = <int>[];
    g2gInfoForExportModel?.attachments?.forEach((element) {
      attachmentsIds.add(element.FileKey ?? 0);
    });
    g2gRecipient = G2GRecipient(childId: 5, isCC: false, parentId: 10);
    g2gExportDto = G2GExportDto(
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        token: secureStorage.token()!,
        notes: notes,
        attachments: attachmentsIds,
        documentId: int.parse(correspondences.correspondenceId ?? "2020"),
        recipients: [g2gRecipient]);

    var allRecipients = <G2GRecipient>[];
    var mergedList = new List<DepartmentList>.from(toDepartmentList)
      ..addAll(cctoDepartmentList);
    mergedList.forEach((element) {
      allRecipients.add(new G2GRecipient(
          childId: element.childG2GID,
          isCC: element.isCC,
          parentId: element.parentG2GID));
    });
    g2gExportDto.recipients = allRecipients;
    ExportUsingG2gAPI _exportUsingG2gAPI = ExportUsingG2gAPI(context);
    _exportUsingG2gAPI.post(g2gExportDto.toMap()).then((value) {
      print(" _exportUsingG2gAPI end $value");
      print(value);
    });
  }

  //Not used
  canReceiveG2GDocument({required context, required correspondenceId}) {
    CanReceiveG2GDocumentAPI _canReceiveG2GDocumentAPI =
        CanReceiveG2GDocumentAPI(context);
    G2GReceiveOrRejectDto g2gReceiveOrRejectDto = G2GReceiveOrRejectDto(
        documentId: correspondenceId,
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        token: secureStorage.token()!,
        notes: "");
    _canReceiveG2GDocumentAPI
        .post(g2gReceiveOrRejectDto.toMap())
        .then((value) {});
  }

  //Not used
  receiveDocumentUsingG2G({required context, required correspondenceId}) {
    ReceiveDocumentUsingG2GApi _receiveDocumentUsingG2GApi =
        ReceiveDocumentUsingG2GApi(context);
    G2GReceiveOrRejectDto g2gReceiveOrRejectDto = G2GReceiveOrRejectDto(
        documentId: correspondenceId,
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        token: secureStorage.token()!,
        notes: "");
    _receiveDocumentUsingG2GApi
        .post(g2gReceiveOrRejectDto.toMap())
        .then((value) {});
  }

  getSwitchMethod(
      {required String name,
      required correspondenceId,
      required exportAction,
      required transferId,
      required context}) {
    switch (name) {
      case "CanExportAsPaperwork":
        // do something
        getCanExportAsPaperwork(
            exportAction: exportAction,
            transferId: transferId,
            correspondenceId: correspondenceId,
            context: context);
        break;
      case "OpenTransferWindow":
        // do something else
        break;
      case "IsAlreadyExportedAsTransfer":
        isAlreadyExportedAsTransfer(
            context: context,
            correspondenceId: correspondenceId,
            transferId: transferId,
            exportAction: exportAction);
        // do something else
        break;
      case "CheckForEmptyStructureRecipients":
        // do something else
        checkForEmptyStructureRecipients(
            context: context,
            exportAction: exportAction,
            transferId: transferId,
            correspondenceId: correspondenceId);
        break;
      case "ConfirmAgain":
        // do something else
        break;
      case "AutoSendToRecepientsAndCC":
        autoSendToRecepientsAndCC(
            context: context,
            correspondenceId: correspondenceId,
            exportAction: exportAction,
            transferId: transferId);
        break;
      case "IsAlreadyExportedAsPaperwork":
        isAlreadyExportedAsTransfer(
            context: context,
            exportAction: exportAction,
            transferId: transferId,
            correspondenceId: correspondenceId);
        // do something else
        break;
      case "NOTHING":
        // do something else
        break;
    }
  }

  //الجديد في الارسال الي الكل

  //Favorites user
  ListFavoriteRecipientsResponse? favoriteRecipientsResponse;

  Future listFavoriteRecipients({context}) async {
    ListFavoriteRecipientsApi listFavoriteRecipientsApi =
        ListFavoriteRecipientsApi(context);
    listFavoriteRecipientsApi.data =
        "Token=${secureStorage.token()}&Language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    await listFavoriteRecipientsApi.getData().then((value) {
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

  setNots({required int id, String? not}) {
    multiTransferNode[id]?.note = not;
  }

  Map<int, multipletransfersSend.TransferNode> multiTransferNode = {};
  Map<int, dynamic> recordingMap = {};

  Future initRecorder() async {
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

  Future recordMathod({required id}) async {
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

  Future stopMathod() async {
    recording = false;
    update(["id"]);
    recordFile = File(_directoryPath);
    await record.stopRecorder();
    update(["record"]);
  }

  Future playMathod({required id}) async {
    audioPlayer = FlutterSoundPlayer();
    audioPlayer!.openPlayer();
    if (recordingMap[id] != null) {
      await audioPlayer!.startPlayer(fromURI: recordingMap[id]);
    } else {
      Get.snackbar("", "nofiletoopen".tr);
    }
  }
}

showDilog(
    {required context,
    required String massge,
    required VoidCallback yes,
    required VoidCallback no}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/close_button.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              ]),
          content: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(massge),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: yes
              //     () {
              //
              // }

              ,
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: no
              //     () {
              //
              //
              //   //Navigator.of(context).pop();
              // }
              ,
              child: Text("No"),
            ),
          ],
        );
      });
}

extension UtilListExtension on List {
  groupBy(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      this.forEach((f) => keys.add(f[key]));

      [...keys.toSet()].forEach((k) {
        List data = [...this.where((e) => e[key] == k)];
        result.add({k: data});
      });

      return result;
    } catch (e, s) {
      return this;
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
// await _recorder!.stopPlayer();

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
class ViewerAnnotation {
  String? id;
  String? page;
  String? X;
  String? Y;
  String? type;
  String? width;
  String? height;
  String? imageByte;
  String? imageName;
  String? text;
  bool? readonly;
  String? userId;
  bool? hidden;

  ViewerAnnotation({
    this.id,
    this.page,
    this.X,
    this.Y,
    this.type,
    this.width,
    this.height,
    this.imageByte,
    this.imageName,
    this.text,
    this.readonly,
    this.userId,
    this.hidden,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'page': this.page,
      'X': this.X,
      'Y': this.Y,
      'type': this.type,
      'width': this.width,
      'height': this.height,
      'imageByte': this.imageByte,
      'imageName': this.imageName,
      'text': this.text,
      'readonly': this.readonly,
      'userId': this.userId,
      'hidden': this.hidden,
    };
  }

  factory ViewerAnnotation.fromMap(Map<String, dynamic> map) {
    return ViewerAnnotation(
      id: map['id'],
      page: map['page'],
      X: map['X'],
      Y: map['Y'],
      type: map['type'],
      width: map['width'],
      height: map['height'],
      imageByte: map['imageByte'],
      imageName: map['imageName'],
      text: map['text'],
      readonly: map['readonly'],
      userId: map['userId'],
      hidden: map['hidden'],
    );
  }
}
