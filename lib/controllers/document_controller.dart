import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cts/services/apis/inside_doc/g2g/eport_using_g2g_api.dart';
import 'package:cts/services/apis/request_edit_in_office_api.dart';
import 'package:cts/services/apis/request_refresh_edit_in_office_api.dart';
import 'package:cts/services/json_model/request_edit_in_office_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
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
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_response.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_document_links_model.dart';
import '../services/json_model/get_document_logs_model.dart';
import '../services/json_model/get_document_receivers_model.dart';
import '../services/json_model/get_document_transfers_model.dart';
import '../services/json_model/inopendocModel/annotations_model.dart';
import '../services/json_model/inopendocModel/attachment_Info_model.dart';
import '../services/json_model/inopendocModel/auto_send_to_recepients_and_cc_model.dart';
import '../services/json_model/inopendocModel/can_export_as_paperwork_model.dart';
import '../services/json_model/inopendocModel/check_for_empty_structure_recipients_model.dart';
import '../services/json_model/inopendocModel/export_response_model.dart';
import '../services/json_model/inopendocModel/g2g/export_usign_g2g_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_export_dto.dart';
import '../services/json_model/inopendocModel/g2g/g2g_receive_or_reject_dto.dart';
import '../services/json_model/inopendocModel/get_attachment_item_model.dart';
import '../services/json_model/inopendocModel/get_user_routing_model.dart';
import '../services/json_model/inopendocModel/is_already_exported_as_paperwork_model.dart';
import '../services/json_model/inopendocModel/is_already_exported_as_transfer_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/save_document_annotation_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../services/models/multiple_transfers_model_send.dart'
    as multipletransfersSend;
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button_with_icon.dart';
import 'inbox_controller.dart';
import 'package:flutter/services.dart' as rootBundel;

import 'landing_page_controller.dart';

class DocumentController extends GetxController {
  ////
  ///
  ///EXPORT AND SHIT !!!!!
  ///

  StartExportAsPaperowrk(
      {required correspondenceId,
      required transferId,
      required exportAction,
      required context}) {
    executeExportMethod(
        method: "IsAlreadyExportedAsPaperwork",
        correspondenceId: correspondenceId,
        transferId: transferId,
        exportAction: exportAction,
        context: context);
  }

  StartExportAsTransfer(
      {required context,
      required correspondenceId,
      required transferId,
      required exportAction}) {
    executeExportMethod(
        method: "IsAlreadyExportedAsTransfer",
        correspondenceId: correspondenceId,
        transferId: transferId,
        exportAction: exportAction,
        context: context);
  }

  Future executeExportMethod(
      {required String method,
      required correspondenceId,
      required transferId,
      required String exportAction,
      required context,
      previousResponse = null,
      withContinue = false}) async {
    var api;
    switch (method) {
      case "IsAlreadyExportedAsTransfer":
        api = IsAlreadyExportedAsTransferAPI(context);
        break;
      case "IsAlreadyExportedAsPaperwork":
        api = IsAlreadyExportedAsPaperworkAPI(context);
        break;

      case "CanExportAsPaperwork":
        api = CanExportAsPaperworkAPI(context);
        break;
      case "CheckForEmptyStructureRecipients":
        api = CheckForEmptyStructureRecipientsAPI(context);
        break;
      case "AutoSendToRecepientsAndCC":
        // if (!withContinue)
        //   showDilog(
        //       context: context,
        //       massge: previousResponse.message!,
        //       subTitle: previousResponse.recipientsTitle +
        //           " ' " +
        //           previousResponse.recipients.join(', ') +
        //           " ' " +
        //           previousResponse.ccedsTitle +
        //           " ' " +
        //           previousResponse.cceds.join(', ') +
        //           " '",
        //       no: () {
        //         Navigator.of(context).pop();
        //         return;
        //       },
        //       yes: () {
        //         executeExportMethod(
        //             method: "AutoSendToRecepientsAndCC",
        //             correspondenceId: correspondenceId,
        //             transferId: transferId,
        //             exportAction: exportAction,
        //             context: context,
        //             previousResponse: exportResponse,
        //             withContinue: true);
        //         Navigator.of(context).pop();
        //       });

        api = AutoSendToRecepientsAndCCAPI(context);
        break;

      case "ConfirmAgain":
        // do something else
        recursivelyExportFuntcion(
            context: context,
            correspondenceId: correspondenceId,
            transferId: transferId,
            exportResponse: previousResponse,
            exportAction: exportAction,
            isAgain: true);
        return;

      case "OpenTransferWindow":
        print("OpenTransferWindow");
        transferPopup(context, transferId, correspondenceId,
            defaultPurpose: 23);
        return;
      case "NOTHING":
        return;
      case "ExportDone":
        Get.find<LandingPageController>().getDashboardStats(context: context);
        Get.find<InboxController>().getCorrespondencesDataAsync(
            context: context,
            inboxId: Get.find<InboxController>().inboxId,
            pageSize: 20,
            showThumbnails: false);
        Get.offAllNamed("/InboxPage");
        return;
    }

    api.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";

    showLoaderDialog(context);
    var resp = await api.getData() as ExportResponse;
    Navigator.of(context).pop();
    recursivelyExportFuntcion(
        context: context,
        correspondenceId: correspondenceId,
        transferId: transferId,
        exportResponse: resp,
        exportAction: exportAction);
  }

  recursivelyExportFuntcion(
      { //required String name,
      required correspondenceId,
      required exportAction,
      required transferId,
      required context,
      required ExportResponse exportResponse,
      isAgain = false}) async {
    if (exportResponse.transferTo != null) {
      userWillAddToOpenTransferWindow = Destination(
          value: exportResponse.transferTo!.structureName,
          id: exportResponse.transferTo!.id);
      usersWillSendTo.clear();
      addTousersWillSendTo(user: userWillAddToOpenTransferWindow!);
    }

    if (exportResponse.isConfirm) {
      var additional = "\n";
      if (exportResponse.recipients != null &&
          exportResponse.recipients!.length > 0) {
        additional += exportResponse.recipientsTitle! +
            "\n" +
            exportResponse.recipients!.join('\n') +
            "\n \n";
      }

      if (exportResponse.cceds != null && exportResponse.cceds!.length > 0) {
        additional += exportResponse.ccedsTitle! +
            "\n" +
            exportResponse.cceds!.join('\n') +
            "\n \n";
      }

      showDilog(
          context: context,
          massge: exportResponse.message!,
          subTitle: additional,
          no: () {
            executeExportMethod(
              method: !isAgain
                  ? exportResponse.noMethod!
                  : exportResponse.noMethod2!,
              correspondenceId: correspondenceId,
              transferId: transferId,
              exportAction: exportAction,
              context: context,
            );
            Navigator.of(context).pop();
          },
          yes: () {
            executeExportMethod(
                method: !isAgain
                    ? exportResponse.yesMethod!
                    : exportResponse.yesMethod2!,
                correspondenceId: correspondenceId,
                transferId: transferId,
                exportAction: exportAction,
                context: context,
                previousResponse: exportResponse);
            Navigator.of(context).pop();
          });
    } else {
      executeExportMethod(
        method: exportResponse.request!,
        correspondenceId: correspondenceId,
        transferId: transferId,
        exportAction: exportAction,
        context: context,
      );
    }
  }

  getIsAlreadyExportedAsPaperwork(
      {required correspondenceId,
      required transferId,
      required exportAction,
      required context}) async {
    IsAlreadyExportedAsPaperworkAPI _alreadyExportedAsPaperworkAPI =
        IsAlreadyExportedAsPaperworkAPI(null);

    _alreadyExportedAsPaperworkAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    isAlreadyExportedAsPaperworkModel = await _alreadyExportedAsPaperworkAPI
        .getData() as IsAlreadyExportedAsPaperworkModel;
    if (isAlreadyExportedAsPaperworkModel?.transferTo != null) {
      userWillAddToOpenTransferWindow = Destination(
          value: isAlreadyExportedAsPaperworkModel?.transferTo!.structureName,
          id: isAlreadyExportedAsPaperworkModel?.transferTo!.id);
      usersWillSendTo.clear();
      addTousersWillSendTo(user: userWillAddToOpenTransferWindow!);
    }
    if (isAlreadyExportedAsPaperworkModel?.isConfirm ?? false) {
      showDilog(
          context: context,
          massge: isAlreadyExportedAsPaperworkModel!.message!,
          no: () {
            getSwitchMethod(
                exportAction: exportAction,
                transferId: transferId,
                correspondenceId: correspondenceId,
                context: context,
                name: isAlreadyExportedAsPaperworkModel?.noMethod ??
                    isAlreadyExportedAsPaperworkModel!.noMethod2!);
          },
          yes: () {
            getSwitchMethod(
                exportAction: exportAction,
                transferId: transferId,
                correspondenceId: correspondenceId,
                context: context,
                name: isAlreadyExportedAsPaperworkModel?.yesMethod ??
                    isAlreadyExportedAsPaperworkModel!.yesMethod2!);
          });
    } else if (isAlreadyExportedAsPaperworkModel?.request != null) {
      getSwitchMethod(
          exportAction: exportAction,
          transferId: transferId,
          correspondenceId: correspondenceId,
          context: context,
          name: isAlreadyExportedAsPaperworkModel!.request!);
    } else {
      Get.snackbar("", isAlreadyExportedAsPaperworkModel!.message!);
    }
  }

  // ExportResponse? exportResponse;

  getSwitchMethod(
      {required String name,
      required correspondenceId,
      required exportAction,
      required transferId,
      required context}) async {
    switch (name) {
      case "CanExportAsPaperwork":
        // do something

        // _alreadyExportedAsPaperworkAPI.getData() as  IsAlreadyExportedAsPaperworkModel;
        await canExportAsPPWorkkCase(
            exportAction, transferId, correspondenceId, context);
        break;
      case "OpenTransferWindow":
        print("OpenTransferWindow");

        userWillAddToOpenTransferWindow = Destination(
            value: canExportAsPaperworkModel?.transferTo!.structureName,
            id: canExportAsPaperworkModel?.transferTo!.id);
        usersWillSendTo.clear();
        addTousersWillSendTo(user: userWillAddToOpenTransferWindow!);
        transferPopup(context, transferId, correspondenceId);

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
        Get.find<LandingPageController>().getDashboardStats(context: context);
        await Get.find<InboxController>().getCorrespondencesDataAsync(
            context: context,
            inboxId: Get.find<InboxController>().inboxId,
            pageSize: 20,
            showThumbnails: false);
        Get.offAllNamed("/InboxPage");
        // do something else
        break;
    }
  }

  Future<void> canExportAsPPWorkkCase(
      exportAction, transferId, correspondenceId, context) async {
    // _alreadyExportedAsPaperworkAPI.getData() as  IsAlreadyExportedAsPaperworkModel;
    isAlreadyExportedAsPaperworkModel = await getCanExportAsPaperwork(
        exportAction: exportAction,
        transferId: transferId,
        correspondenceId: correspondenceId,
        context: context);

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
                name: isAlreadyExportedAsPaperworkModel?.noMethod ??
                    isAlreadyExportedAsPaperworkModel!.noMethod2!);
          },
          yes: () {
            // getCanExportAsPaperwork(
            //     exportAction: exportAction,
            //     transferId: transferId,
            //     correspondenceId: correspondenceId,
            //     context: context);

            getSwitchMethod(
                exportAction: exportAction,
                transferId: transferId,
                correspondenceId: correspondenceId,
                context: context,
                name: isAlreadyExportedAsPaperworkModel?.yesMethod ??
                    isAlreadyExportedAsPaperworkModel!.yesMethod2!);
            //   Get.back();
            // Navigator.of(context).pop();
          });
    } else if (isAlreadyExportedAsPaperworkModel?.request != null) {
      getSwitchMethod(
          exportAction: exportAction,
          transferId: transferId,
          correspondenceId: correspondenceId,
          context: context,
          name: isAlreadyExportedAsPaperworkModel!.request!);

      print(isAlreadyExportedAsPaperworkModel?.request);
      //  Get.back();

    } else {
      // Get.snackbar("", isAlreadyExportedAsPaperworkModel?.message ?? "");

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
  }

  ///
  ///EXPORT AND SHIT !!!!!
  ///

  Destination? userWillAddToOpenTransferWindow;
  RxBool isPlayingAudio = false.obs;
  RxInt documentEditedInOfficeId = 0.obs;

  SecureStorage secureStorage = SecureStorage();
  DocumentModel? documentBaseModel;
  final record = FlutterSoundRecorder();

  bool notoragnalFileDoc = false;

  String oragnalFileDocpdfUrlFile = "";

  String pdfUrlFile = "";
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
  // getatt_achments_model.Attachments? saveAttAchmentItemAnnotationsresalt;
  Attachments? saveAttAchmentItemAnnotationsData;

  Future<GetAttAchmentItem?> getAttachmentItemAsync(
      {context, documentId, transferId, attachmentId}) async {
    GetAttachmentItemAPI getAttachmentItemAPI = GetAttachmentItemAPI(context);
    getAttachmentItemAPI.data =
        "Token=${secureStorage.token()}&documentId=$documentId&transferId=$transferId&attachmentId=$attachmentId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    var value = await getAttachmentItemAPI.getData();
    if (value == null) return null;
    return value as GetAttAchmentItem;
  }

  multipleTransferspost({context, correspondenceId, transferId}) async {
    //
    MultipleTransfersAPI _multipleTransfersAPI = MultipleTransfersAPI(context);
    // check
    recordingMap.forEach((key, value) async {
      //  int countOfNodes = recordingMap.length;
      for (var entry in recordingMap.entries) {
        var key = entry.key;
        var value = entry.value;
        //  recordingMap.forEach((key, value)  {
        String? audioFileBes64 = await audiobase64String(file: File(value));
        multiTransferNode[key]?.voiceNote = audioFileBes64;
        multiTransferNode[key]?.voiceNoteExt = "m4a";
        multiTransferNode[key]?.voiceNotePrivate = false;
        multiTransferNode[key]?.destinationId = key.toString();
        multiTransferNode[key]?.purposeId =
            documentBaseModel!.correspondence!.purposeId;
        multiTransferNode[key]?.voiceNotePrivate = false;
      }
    });

    List<multipletransfersSend.TransferNode> transfers = [];
    multiTransferNode.forEach((key, value) {
      var pid = getPurposes(value.destinationId);
      value.purposeId = pid?.id;

      transfers.add(value);
    });

    multipletransfersSend.MultipleTransfers multipleTransfers =
        multipletransfersSend.MultipleTransfers(
            transfers: transfers,
            correspondenceId: correspondenceId,
            token: secureStorage.token()!,
            transferId: transferId);

    transfarForMany.clear();
    usersWillSendTo.clear();
    await _multipleTransfersAPI
        .post(multipleTransfers.toMap()); //.then((value) {
    Get.find<LandingPageController>().getDashboardStats(context: context);
    Get.find<InboxController>().getCorrespondencesData(
        context: context,
        inboxId: Get.find<InboxController>().inboxId,
        pageSize: 20,
        showThumbnails: false);
    Get.back();

    Get.offAllNamed("/InboxPage");

    CustomSnackBar.success(
      icon: Container(),
      backgroundColor: Colors.lightGreen,
      message: "EndedSuccess".tr,
    );
    //});
  }

//=====================================================================================

  SaveDocumentAnnotationModel? postSaveDocumentAnnotationsModel;

  Future SaveDocAnnotationsData({
    required BuildContext context,
    required String userId,
    required String correspondenceId,
    required String transferId,
    required String attachmentId,
    required String isOriginalMail,
    required String documentAnnotationsString,
    required String delegateGctId,
    required String docURL,
    bool? unSign,
  }) async {
    final SaveDocumentAnnotationsAPI _saveDocumentAnnotationsApi =
        SaveDocumentAnnotationsAPI(context);

    var unsignValueToSend = 'false';
    if (unSign != null && unSign == true) unsignValueToSend = 'true';
    postSaveDocumentAnnotationsModel = SaveDocumentAnnotationModel(
      AttachmentId: attachmentId.toString(),
      CorrespondenceId: correspondenceId,
      DelegateGctId: delegateGctId,
      DocumentAnnotationsString: documentAnnotationsString,
      IsOriginalMail: isOriginalMail,
      Token: secureStorage.token()!,
      UserId: userId,
      TransferId: transferId,
      DocumentPagesString: '',
      DocumentUrl: docURL,
      Language: 'en',
      UnSign: unsignValueToSend,
      PagesOrderString: "[]",
    );
    await _saveDocumentAnnotationsApi
        .post(postSaveDocumentAnnotationsModel?.toMap());
  }

  backTooragnalFileDocpdf() {
    notoragnalFileDoc = false;
    pdfAndSing.clear();
    singpic.clear();
    pdfAndSing.clear();
    selectedAttachent = null;
    pdfAndSingURL.value = oragnalFileDocpdfUrlFile;

    Map<String, dynamic> dat =
        jsonDecode(isOriginalMailAttachmentsList!.annotations!);

    var loopableData = dat.values.toList();

    loopableData.forEach((elementa) {
      ViewerAnnotation daa = ViewerAnnotation.fromMap(elementa[0]);
      annotations.add(daa);
    });
    canSignThisDocument();
    update();
  }

  AttachmentsList? selectedAttachent;
  openNewAttachment(AttachmentsList attachment) {
    selectedAttachent = attachment;
    notoragnalFileDoc = true;
    pdfAndSing.clear();
    singpic.clear();
    pdfAndSing.clear();
    pdfAndSingURL.value = attachment.uRL!;
    annotations.clear();
    print(attachment.annotations!);
    try {
      Map<String, dynamic> dat = jsonDecode(attachment.annotations!);

      var loopableData = dat.values.toList();

      loopableData.forEach((elementa) {
        ViewerAnnotation daa = ViewerAnnotation.fromMap(elementa[0]);
        annotations.add(daa);
      });
    } catch (ex) {
      print(ex);
    }
    canSignThisDocument();
    update();
  }

  RxBool canSignThis = true.obs;
  bool canSignThisDocument() {
    canSignThis.value = true;
    if (selectedAttachent == null) return true;
    if (selectedAttachent!.fileName!.contains('pdf')) {
      canSignThis.value = true;
      return true;
    }
    canSignThis.value = false;
    return false;
  }

  //تحديث كان ابن فيل وجلب جميع البيانات الخاصه بلملف
  updatecanOpenDocumentModel(DocumentModel data) {
    logindata = SecureStorage.to.readSecureJsonData(AllStringConst.LogInData);
    preparePageData();
    pdfAndSing.clear();
    documentEditedInOfficeId.value = 0;
    documentBaseModel = data;
    folder2.clear();
    documentBaseModel?.attachments?.attachments?.forEach((element) {
      if (element.isOriginalMail!) {
        oragnalFileDocpdfUrlFile = element.uRL!;
        isOriginalMailAttachmentsList = element;

        pdfAndSing.clear();
        // pdfAndSingData.clear();

        annotations.clear();
        selectedAttachent = null;
        pdfAndSingURL.value = oragnalFileDocpdfUrlFile;
        // pdfAndSingData.add(oragnalFileDocpdfUrlFile);

        Map<String, dynamic> dat = jsonDecode(element.annotations!);

        var loopableData = dat.values.toList();

        loopableData.forEach((elementa) {
          ViewerAnnotation daa = ViewerAnnotation.fromMap(elementa[0]);
          annotations.add(daa);
        });
        canSignThisDocument();

        // update();
      } else {
        if (folder2[element.folderName] != null) {
          folder2[element.folderName]?.add(element);
        } else {
          List<AttachmentsList> a = [];
          a.add(element);
          folder2[element.folderName!] = a;
        }
      }
    });
  }

  ExportResponse? exportResponse;
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
  // List<String> pdfAndSingData = [];

  RxString pdfAndSingURL = "".obs;

  List<ViewerAnnotation> annotations = [];
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

//==================================================================================================
  Future<GetDocumentLogsModel?> getDocumentAuditLogsdata(
      {required context, required String docId}) async {
    final GetDocumentAuditLogsApi _getDocumentAuditLogsApi =
        GetDocumentAuditLogsApi(context);
    _getDocumentAuditLogsApi.data =
        "Token=${secureStorage.token()}&docId=$docId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";

    var value = await _getDocumentAuditLogsApi.getData();
    getDocumentLogsModel = value as GetDocumentLogsModel;
    return getDocumentLogsModel;
  }

  Future<GetDocumentLinksModel?> getDocumentLinksdata(
      {required context, correspondenceId, transferId}) async {
    final GetDocumentLinksApi _getDocumentLinksApi =
        GetDocumentLinksApi(context);
    _getDocumentLinksApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    var value = await _getDocumentLinksApi.getData();
    getDocumentLinksModel = value as GetDocumentLinksModel;
    return getDocumentLinksModel;
  }

  Future<GetDocumentReceiversModel?> getDocumentReceiversdata(
      {required context, correspondenceId, transferId}) async {
    final GetDocumentReceiversApi _getDocumentReceiversApi =
        GetDocumentReceiversApi(context);
    _getDocumentReceiversApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";

    var value = await _getDocumentReceiversApi.getData(); //.then((value) {
    getDocumentReceiversModel = value as GetDocumentReceiversModel;
    return getDocumentReceiversModel;
    //});
  }

  Future<GetDocumentTransfersModel?> getDocumentTransfersdata(
      {required context, correspondenceId, transferId}) async {
    final GetDocumentTransfersApi _getDocumentTransfersApi =
        GetDocumentTransfersApi(context);
    _getDocumentTransfersApi.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}"; //"Token=${secureStorage.token()}&docId=$id&language=${Get.locale?.languageCode=="en"?"en":"ar"}";
    var value = await _getDocumentTransfersApi.getData(); //.then((value) {
    getDocumentTransfersModel = value as GetDocumentTransfersModel;
    return getDocumentTransfersModel;
    //});
  }

  Future<GetDocumentReceiversModel?> getRecieversData(context) async {
    var transferId = documentBaseModel!.correspondence!.transferId!;
    var correspondenceId = documentBaseModel!.correspondence!.correspondenceId;
    return await getDocumentReceiversdata(
        context: context,
        correspondenceId: correspondenceId,
        transferId: transferId);
  }

  Future<GetDocumentLinksModel?> getLinks(context) async {
    var transferId = documentBaseModel!.correspondence!.transferId!;
    var correspondenceId = documentBaseModel!.correspondence!.correspondenceId;
    return await getDocumentLinksdata(
        context: context,
        correspondenceId: correspondenceId,
        transferId: transferId);
  }

  Future<GetDocumentLogsModel?> getAuditLog(context) async {
    var correspondenceId = documentBaseModel!.correspondence!.correspondenceId;
    return await getDocumentAuditLogsdata(
      context: context,
      docId: correspondenceId!,
    );
  }

  Future<GetDocumentTransfersModel?> getTransfersData(context) async {
    var transferId = documentBaseModel!.correspondence!.transferId!;
    var correspondenceId = documentBaseModel!.correspondence!.correspondenceId!;
    return await getDocumentTransfersdata(
      context: context,
      correspondenceId: correspondenceId,
      transferId: transferId,
    );
  }

  // gatAllDataAboutDOC(
  //     {required context,
  //     //   required String docId,
  //     required String transferId,
  //     required String correspondenceId}) {
  //   print("gatAllDataAboutDOC");
  //   getDocumentAuditLogsdata(context: context, docId: correspondenceId);
  //   getDocumentTransfersdata(
  //       context: context,
  //       transferId: transferId,
  //       correspondenceId: correspondenceId);
  //   getDocumentReceiversdata(
  //       context: context,
  //       correspondenceId: correspondenceId,
  //       transferId: transferId);
  //   getDocumentLinksdata(
  //       context: context,
  //       transferId: transferId,
  //       correspondenceId: correspondenceId);
  //   print("*" * 10);
  // }

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

    var purp = "15";
    if (documentBaseModel != null &&
        documentBaseModel!.correspondence != null) {
      purp = documentBaseModel!.correspondence!.purposeId!;
    }

    multipletransfersSend.TransferNode transferNode =
        multipletransfersSend.TransferNode(
            purposeId: purp,
            destinationId: user.id.toString(),
            voiceNotePrivate: false);
    multiTransferNode[user.id!] = transferNode;

    transfarForManyPurposes[user.id.toString()] =
        purposes!.where((x) => x.id == purp).first;
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

      Get.find<InboxController>().setFindRecipientData(findRecipientModel!);
      listOfUser(0);
      print(
          "tis is  findRecipientModel?.toJson()              =>  ${findRecipientModel?.toJson()}");
    });
  }

  List<CustomActions>? customActions = [];
  List<Purposes>? purposes = [];

  Map<String, String> actions = {};

  @override
  void onReady() {
    super.onReady();
    // getAttachmentItemlocal( );
    logindata = SecureStorage.to.readSecureJsonData(AllStringConst.LogInData);
    if (logindata != null) {
      LoginModel data = LoginModel.fromJson(logindata!);
      customActions = data.customActions;
      purposes = data.transferData!.purposes!;
      multiSignatures = data.multiSignatures ?? [];
    }
  }

  preparePageData() async {
    logindata = SecureStorage.to.readSecureJsonData(AllStringConst.LogInData);
    if (logindata != null) {
      LoginModel data = LoginModel.fromJson(logindata!);
      customActions = data.customActions;
      purposes = data.transferData!.purposes!;
      multiSignatures = data.multiSignatures ?? [];
      var signDef = SecureStorage.to.readSecureData(AllStringConst.Signature);
      if (signDef != null && signDef.isNotEmpty)
        multiSignatures.add(MultiSignatures(signature: signDef));
    }
  }

  @override
  void onInit() {
    super.onInit();
    //  initRecorder();

    // /  genratG2GExportDto();
    g2GInfoForExport();
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

  Map<String, Purposes> transfarForManyPurposes = {};

  // Map<int, String> transfarForManyNots = {};

  CustomActions? getactions(id) {
    return transfarForManyCustomActions[id];
    // update();
  }

  Purposes? getPurposes(id) {
    return transfarForManyPurposes[id];
    // update();
  }

  setactions(id, CustomActions customActions) {
    transfarForManyCustomActions[id] = customActions;
    transfarForMany[id]?.actionType = customActions.name;
    update();
  }

  setPurposes(id, Purposes customActions) {
    transfarForManyPurposes[id] = customActions;
    transfarForMany[id]?.actionType = customActions.id;
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
        '.aac';
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

      attachmentInfoModel = AttachmentInfoModel(
          token: secureStorage.token()!,
          correspondenceId:
              documentBaseModel!.correspondence!.correspondenceId!,
          fileName: name,
          fileContent: img64,
          language: Get.locale?.languageCode == "en" ? "en" : "ar");

      _uploadAttachmentApi.post(attachmentInfoModel?.toMap()).then((value) {});
    } else {}
  }

  Future getCanExportAsPaperwork(
      {required correspondenceId,
      required transferId,
      required exportAction,
      required context}) async {
    print("getCanExportAsPaperwork");
    CanExportAsPaperworkAPI _canExportAsPaperworkAPI =
        CanExportAsPaperworkAPI(null);
    _canExportAsPaperworkAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    await _canExportAsPaperworkAPI.getData().then((value) {
      canExportAsPaperworkModel = value as CanExportAsPaperworkModel;
      print(
          "canExportAsPaperworkModel =>  ${canExportAsPaperworkModel?.isConfirm}");
      if (canExportAsPaperworkModel?.transferTo != null) {
        userWillAddToOpenTransferWindow = Destination(
            value: canExportAsPaperworkModel?.transferTo!.structureName,
            id: canExportAsPaperworkModel?.transferTo!.id);
        usersWillSendTo.clear();
        addTousersWillSendTo(user: userWillAddToOpenTransferWindow!);
      }

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

    canExportAsPaperworkModel =
        await _canExportAsPaperworkAPI.getData() as CanExportAsPaperworkModel;

    if (canExportAsPaperworkModel?.isConfirm ?? false) {
      showDilog(
          context: context,
          massge: canExportAsPaperworkModel!.message!,
          no: () {
            //  Navigator.of(context).pop();
            getSwitchMethod(
                exportAction: exportAction,
                transferId: transferId,
                correspondenceId: correspondenceId,
                context: context,
                name: canExportAsPaperworkModel?.noMethod ??
                    canExportAsPaperworkModel!.noMethod2!);
          },
          yes: () {
            // getCanExportAsPaperwork(
            //     exportAction: exportAction,
            //     transferId: transferId,
            //     correspondenceId: correspondenceId,
            //     context: context);

            getSwitchMethod(
                exportAction: exportAction,
                transferId: transferId,
                correspondenceId: correspondenceId,
                context: context,
                name: canExportAsPaperworkModel?.yesMethod ??
                    canExportAsPaperworkModel!.yesMethod2!);
            //   Get.back();
            // Navigator.of(context).pop();
          });
    } else if (canExportAsPaperworkModel?.request != null) {
      getSwitchMethod(
          exportAction: exportAction,
          transferId: transferId,
          correspondenceId: correspondenceId,
          context: context,
          name: canExportAsPaperworkModel!.request!);

      print(canExportAsPaperworkModel?.request);
      //  Get.back();

    } else {
      Get.snackbar("", canExportAsPaperworkModel!.message!);

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
      required exportAction}) async {
    showLoaderDialog(context);
    AutoSendToRecepientsAndCCAPI _autoSendToRecepientsAndCCAPI =
        AutoSendToRecepientsAndCCAPI(context);
    _autoSendToRecepientsAndCCAPI.data =
        "Token=${secureStorage.token()}&correspondenceId=$correspondenceId&transferId=$transferId&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}&exportAction=$exportAction";
    var value = await _autoSendToRecepientsAndCCAPI.getData(); //.then((value) {
    autoSendToRecepientsAndCCModel = value as AutoSendToRecepientsAndCCModel;

    if (autoSendToRecepientsAndCCModel?.isConfirm ?? false) {
      Get.snackbar("", autoSendToRecepientsAndCCModel!.message!);
    }

    Navigator.pop(context);
    var methodName = "";

    if (autoSendToRecepientsAndCCModel?.yesMethod != null)
      methodName = autoSendToRecepientsAndCCModel!.yesMethod!;
    else if (autoSendToRecepientsAndCCModel?.yesMethod2 != null)
      methodName = autoSendToRecepientsAndCCModel!.yesMethod2!;
    if (autoSendToRecepientsAndCCModel!.request == "NOTHING")
      methodName = "NOTHING";
    //  _popUpMenu(context);
    getSwitchMethod(
      exportAction: exportAction,
      transferId: transferId,
      correspondenceId: correspondenceId,
      context: context,
      name: methodName,
    );
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

      // if (checkForEmptyStructureRecipientsModel?.isConfirm ?? false) {
      //   Get.snackbar("", checkForEmptyStructureRecipientsModel!.message!);
      // }

      showDilog(
          context: context,
          massge: checkForEmptyStructureRecipientsModel!.message!,
          no: () {
            Navigator.of(context).pop();
          },
          yes: () {
            var methodName = "";
            if (checkForEmptyStructureRecipientsModel?.yesMethod != null)
              methodName = checkForEmptyStructureRecipientsModel!.yesMethod!;
            else if (checkForEmptyStructureRecipientsModel?.yesMethod2 != null)
              methodName = checkForEmptyStructureRecipientsModel!.yesMethod2!;
            Navigator.of(context).pop();
            getSwitchMethod(
              exportAction: exportAction,
              transferId: transferId,
              correspondenceId: correspondenceId,
              context: context,
              name: methodName,
            );
            //   Get.back();
            // Navigator.of(context).pop();
          });
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
        showDilog(
            context: context,
            massge: isAlreadyExportedAsTransferModel!.message!,
            no: () {
              //  Navigator.of(context).pop();
              getSwitchMethod(
                  exportAction: exportAction,
                  transferId: transferId,
                  correspondenceId: correspondenceId,
                  context: context,
                  name: isAlreadyExportedAsTransferModel?.noMethod ??
                      isAlreadyExportedAsTransferModel!.noMethod2!);
              Get.back();
            },
            yes: () {
              // getCanExportAsPaperwork(
              //     exportAction: exportAction,
              //     transferId: transferId,
              //     correspondenceId: correspondenceId,
              //     context: context);
              getSwitchMethod(
                  exportAction: exportAction,
                  transferId: transferId,
                  correspondenceId: correspondenceId,
                  context: context,
                  name: isAlreadyExportedAsTransferModel?.yesMethod ??
                      isAlreadyExportedAsTransferModel!.yesMethod2!);
              Get.back();
              // Navigator.of(context).pop();
            });
      } else if (isAlreadyExportedAsTransferModel?.request != null) {
        print("i get isAlreadyExportedAsPaperworkModel?.isConfirm == false");
        getSwitchMethod(
            exportAction: exportAction,
            transferId: transferId,
            correspondenceId: correspondenceId,
            context: context,
            name: isAlreadyExportedAsTransferModel!.request!);
        print(isAlreadyExportedAsTransferModel?.request);
        Get.back();
      } else {
        // Get.snackbar("isAlreadyExportedAsTransferModel",
        //     isAlreadyExportedAsTransferModel!.message!);
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

      if (isAlreadyExportedAsTransferModel?.isConfirm ?? false) {
        //   Get.snackbar("", isAlreadyExportedAsTransferModel!.message!);
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
        documentId: int.parse(
            documentBaseModel!.correspondence!.correspondenceId ?? "2020"),
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

  //الجديد في الارسال الي الكل

  //Favorites user
  ListFavoriteRecipientsResponse? favoriteRecipientsResponse;

  Future listFavoriteRecipients({context}) async {
    ListFavoriteRecipientsApi listFavoriteRecipientsApi =
        ListFavoriteRecipientsApi(context);
    listFavoriteRecipientsApi.data =
        "Token=${secureStorage.token()}&Language=${Get.locale?.languageCode == "en" ? "en" : "ar"}";
    var value = await listFavoriteRecipientsApi.getData(); //.then((value) {
    if (value != null) {
      favoriteRecipientsResponse = value as ListFavoriteRecipientsResponse;
    } else {
      Get.snackbar("", "err".tr);
    }
    // });
    update();
  }

  bool canOpenInOffice() {
    if (documentBaseModel == null) return false;
    if (documentBaseModel!.attachments!.attachments!.length == 0) return false;
    var attachment = documentBaseModel!.attachments!.attachments![0];
    var editOfficeDetails = attachment.editOfficeDetails!;
    if (editOfficeDetails.spUrl == null ||
        editOfficeDetails.spUrl!.isEmpty ||
        editOfficeDetails.isEditable == false) {
      return false;
    }
    return true;
  }

  Future<String> refreshOffice({context}) async {
    var attachment = documentBaseModel!.attachments!.attachments![0];
    var editOfficeDetails = attachment.editOfficeDetails!;

    if (editOfficeDetails.spUrl == null ||
        editOfficeDetails.isEditable == false) {
      return "";
    }
    RequestEditInOfficeModel model = RequestEditInOfficeModel(
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        token: secureStorage.token()!,
        documentId: attachment.docId,
        attachmentId: attachment.attachmentId,
        siteId: editOfficeDetails.siteId,
        webId: editOfficeDetails.webId,
        fileId: editOfficeDetails.fileId);
    RequestRefreshEditInOfficeAPI api = RequestRefreshEditInOfficeAPI(context);
    await api.post(model.toMap());
    documentEditedInOfficeId.value = 0;
    return editOfficeDetails.spUrl!;
  }

  Future<String> prepareOpenDocumentInOffice({context}) async {
    var attachment = documentBaseModel!.attachments!.attachments![0];
    var editOfficeDetails = attachment.editOfficeDetails!;

    if (editOfficeDetails.spUrl == null ||
        editOfficeDetails.isEditable == false) {
      return "";
    }

    documentEditedInOfficeId.value = attachment.attachmentId ?? 0;
    RequestEditInOfficeModel model = RequestEditInOfficeModel(
        language: Get.locale?.languageCode == "en" ? "en" : "ar",
        token: secureStorage.token()!,
        documentId: attachment.docId,
        attachmentId: attachment.attachmentId,
        siteId: editOfficeDetails.siteId,
        webId: editOfficeDetails.webId,
        fileId: editOfficeDetails.fileId);
    RequestEditInOfficeAPI api = RequestEditInOfficeAPI(context);

    var res = await api.post(model.toMap());
    if (res == null) {
      return "";
    }

    return editOfficeDetails.spUrl!;
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
    await initRecorder();
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
    update();
  }

  Future stopMathod() async {
    recording = false;
    update(["id"]);
    recordFile = File(_directoryPath);
    await record.stopRecorder();
    update(["record"]);
  }

  TextEditingController completeNote = new TextEditingController();
  String replyNote = "";
  bool isPrivate = true;

  Future playMathod({required id}) async {
    audioPlayer = FlutterSoundPlayer();
    audioPlayer!.openPlayer();
    if (recordingMap[id] != null) {
      isPlayingAudio.value = true;
      await audioPlayer!.startPlayer(
          fromURI: recordingMap[id],
          whenFinished: () {
            isPlayingAudio.value = false;
          });
    } else {
      Get.snackbar("", "nofiletoopen".tr);
    }
  }

  Recipients? selectlistfavoriteUser;

  transferPopup(context, String transferID, String correspondenceID,
      {int? defaultPurpose}) async {
    showLoaderDialog(context);
    getFindRecipientData(context: context);
    await preparePageData();
    await listFavoriteRecipients(context: context);
    Navigator.pop(context);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: buildPopupHeader(
              context,
              'assets/images/refer.png',
              "refer".tr,
            ),
            content: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "referTo".tr,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.black.withOpacity(.5),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    buildFavoitesBar(context, transferID, correspondenceID),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      height: 300,
                      child: GetBuilder<DocumentController>(
                        builder: (logic) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: usersWillSendTo.length,
                              itemBuilder: (context, pos) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: userTransferListItem(context, pos)
                                    // Container(
                                    //   color: Colors.grey[200],
                                    //   child: Column(children: [
                                    //     Row(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.center,
                                    //         children: [
                                    //           Text(
                                    //             "name".tr,
                                    //             style: Theme.of(context)
                                    //                 .textTheme
                                    //                 .headline3!
                                    //                 .copyWith(
                                    //                   color: createMaterialColor(
                                    //                     const Color.fromRGBO(
                                    //                       77,
                                    //                       77,
                                    //                       77,
                                    //                       1,
                                    //                     ),
                                    //                   ),
                                    //                   fontSize: 15,
                                    //                 ),
                                    //             textAlign: TextAlign.center,
                                    //             overflow: TextOverflow.ellipsis,
                                    //           ),
                                    //           Padding(
                                    //             padding:
                                    //                 const EdgeInsets.all(8.0),
                                    //             child: Text(logic
                                    //                     .usersWillSendTo[pos]
                                    //                     .value ??
                                    //                 ""),
                                    //           ),
                                    //           SizedBox(
                                    //             width: 8,
                                    //           ),
                                    //           Spacer(),
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               transfarForMany.remove(logic
                                    //                   .usersWillSendTo[pos].id);
                                    //               logic.delTousersWillSendTo(
                                    //                   user: logic
                                    //                       .usersWillSendTo[pos]);
                                    //             },
                                    //             child: Image.asset(
                                    //               'assets/images/close_button.png',
                                    //               width: 20,
                                    //               height: 20,
                                    //             ),
                                    //           ),
                                    //         ]),
                                    //     SizedBox(
                                    //       height: 4,
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Expanded(
                                    //           child: Text("action".tr),
                                    //         ),
                                    //         SizedBox(
                                    //           width: 10,
                                    //         ),
                                    //         Expanded(
                                    //           child: Text("audioNotes".tr),
                                    //         )
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Expanded(
                                    //           child: Container(
                                    //             height: 40,
                                    //             color: Colors.grey[300],
                                    //             child: DropdownButton<Purposes>(
                                    //               alignment: Alignment.topRight,
                                    //               value: logic.getPurposes(logic
                                    //                   .usersWillSendTo[pos].id),
                                    //               // icon: const Icon(
                                    //               //     Icons.arrow_downward),
                                    //               elevation: 16,
                                    //               underline: SizedBox(),
                                    //               hint: Text("اختار"),
                                    //               onChanged:
                                    //                   (Purposes? newValue) {
                                    //                 setPurposes(
                                    //                   logic
                                    //                       .usersWillSendTo[pos].id
                                    //                       .toString(),
                                    //                   newValue!,
                                    //                 );
                                    //                 //  dropdownValue = newValue!;
                                    //               },
                                    //               items: purposes?.map<
                                    //                       DropdownMenuItem<
                                    //                           Purposes>>(
                                    //                   (Purposes value) {
                                    //                 return DropdownMenuItem<
                                    //                     Purposes>(
                                    //                   value: value,
                                    //                   child: Text(value.value!),
                                    //                 );
                                    //               }).toList(),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 10,
                                    //         ),
                                    //         Expanded(
                                    //           child: Container(
                                    //               height: 40,
                                    //               color: Colors.grey[300],
                                    //               child: Row(
                                    //                 mainAxisAlignment:
                                    //                     MainAxisAlignment
                                    //                         .spaceBetween,
                                    //                 children: [
                                    //                   GestureDetector(
                                    //                     onTap: () async {
                                    //                       record.isRecording
                                    //                           ? stopMathod()
                                    //                           : recordMathod(
                                    //                               id: logic
                                    //                                   .usersWillSendTo[
                                    //                                       pos]
                                    //                                   .id,
                                    //                             );
                                    //                     },
                                    //                     child: Padding(
                                    //                       padding:
                                    //                           const EdgeInsets
                                    //                               .all(8.0),
                                    //                       child: GetBuilder<
                                    //                               DocumentController>(
                                    //                           id: "record", //autoRemove: false,
                                    //                           builder: (logic) {
                                    //                             return Icon(record
                                    //                                     .isRecording
                                    //                                 ? Icons.stop
                                    //                                 : Icons.mic);
                                    //                           }),
                                    //                     ),
                                    //                   ),
                                    //                   Padding(
                                    //                     padding:
                                    //                         const EdgeInsets.all(
                                    //                             8.0),
                                    //                     child: Obx(
                                    //                       () => InkWell(
                                    //                         onTap: () {
                                    //                           if (!isPlayingAudio
                                    //                               .value) {
                                    //                             playMathod(
                                    //                                 id: logic
                                    //                                     .usersWillSendTo[
                                    //                                         pos]
                                    //                                     .id);
                                    //                           } else {
                                    //                             isPlayingAudio
                                    //                                     .value =
                                    //                                 false;
                                    //                             audioPlayer!
                                    //                                 .stopPlayer();
                                    //                           }
                                    //                         },
                                    //                         child: Icon(
                                    //                           isPlayingAudio.value
                                    //                               ? Icons.stop
                                    //                               : Icons
                                    //                                   .play_arrow,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   )
                                    //                 ],
                                    //               )),
                                    //         )
                                    //       ],
                                    //     ),
                                    //     SizedBox(
                                    //       height: 8,
                                    //     ),
                                    //     Container(
                                    //       child: TextFormField(
                                    //         onChanged: (v) {
                                    //           multiTransferNode[logic
                                    //                   .usersWillSendTo[pos].id]
                                    //               ?.note = v;
                                    //           setNots(
                                    //               id: logic
                                    //                   .usersWillSendTo[pos].id!,
                                    //               not: v);
                                    //         },
                                    //         maxLines: 4,
                                    //       ),
                                    //       color: Colors.grey[300],
                                    //     ),
                                    //     SizedBox(
                                    //       height: 8,
                                    //     ),
                                    //   ]),
                                    // ),
                                    );
                              });
                        },
                      ),
                    )
                  ]),
            ),
            actions:
                transferPopupActions(context, transferID, correspondenceID),
          );
        });
  }

  Container userTransferListItem(context, pos) {
    return Container(
      color: Colors.grey[200],
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "name".tr,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: createMaterialColor(
                    const Color.fromRGBO(
                      77,
                      77,
                      77,
                      1,
                    ),
                  ),
                  fontSize: 15,
                ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(usersWillSendTo[pos].value ?? ""),
          ),
          SizedBox(
            width: 8,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if (usersWillSendTo.length < pos) {
                transfarForMany.remove(usersWillSendTo[pos].id);
                delTousersWillSendTo(user: usersWillSendTo[pos]);
              }
            },
            child: Image.asset(
              'assets/images/close_button.png',
              width: 20,
              height: 20,
            ),
          ),
        ]),
        SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Expanded(
              child: Text("action".tr),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text("audioNotes".tr),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                color: Colors.grey[300],
                child: DropdownButtonFormField<Purposes>(
                  decoration: InputDecoration.collapsed(hintText: ''),
                  alignment: Alignment.centerRight,
                  value: transfarForManyPurposes[usersWillSendTo[pos].id] ??
                      purposes![0],
                  //   elevation: 16,
                  // underline: SizedBox(),
                  hint: Text("اختار"),
                  onTap: () {
                    print("object");
                  },
                  onChanged: (Purposes? newValue) {
                    // setPurposes(
                    //   usersWillSendTo[pos].id.toString(),
                    //   newValue!,
                    // );
                    var user = usersWillSendTo[pos!].id.toString();
                    transfarForManyPurposes[user] = newValue!;
                    update();
                  },
                  onSaved: (Purposes? newValue) {
                    // setPurposes(
                    //   usersWillSendTo[pos].id.toString(),
                    //   newValue!,
                    // );
                    var user = usersWillSendTo![pos!].id.toString();
                    transfarForManyPurposes[user] = newValue!;
                    update();
                  },
                  items: purposes
                      ?.map<DropdownMenuItem<Purposes>>((Purposes value) {
                    return DropdownMenuItem<Purposes>(
                      value: value,
                      child: Text(value.value!),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                  height: 40,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          record.isRecording
                              ? stopMathod()
                              : recordMathod(
                                  id: usersWillSendTo[pos].id,
                                );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GetBuilder<DocumentController>(
                              id: "record", //autoRemove: false,
                              builder: (logic) {
                                return Icon(record.isRecording
                                    ? Icons.stop
                                    : Icons.mic);
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => InkWell(
                            onTap: () {
                              if (!isPlayingAudio.value) {
                                playMathod(id: usersWillSendTo[pos].id);
                              } else {
                                isPlayingAudio.value = false;
                                audioPlayer!.stopPlayer();
                              }
                            },
                            child: Icon(
                              isPlayingAudio.value
                                  ? Icons.stop
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          child: TextFormField(
            onChanged: (v) {
              multiTransferNode[usersWillSendTo[pos].id]?.note = v;
              setNots(id: usersWillSendTo[pos].id!, not: v);
            },
            maxLines: 4,
          ),
          color: Colors.grey[300],
        ),
        SizedBox(
          height: 8,
        ),
      ]),
    );
  }

  Row buildFavoitesBar(
      BuildContext context, String transferID, String correspondenceID) {
    return Row(
      children: [
        GetBuilder<DocumentController>(
            autoRemove: false,
            builder: (logic) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary)),
                child: DropdownButton<Recipients>(
                  value: selectlistfavoriteUser,
                  icon: const Icon(Icons.arrow_downward),
                  hint: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/pr.jpg"),
                          ),
                        ),
                      ),
                      Text("chooseaperson".tr),
                    ],
                  ),
                  iconSize: 24,
                  elevation: 16,
                  underline: SizedBox(),
                  onChanged: (v) {
                    Destination user =
                        Destination(value: v!.targetName, id: v.targetGctid);
                    addTousersWillSendTo(
                      user: user,
                    );
                  },
                  items: favoriteRecipientsResponse!.recipients!
                      .map<DropdownMenuItem<Recipients>>((Recipients value) {
                    return DropdownMenuItem<Recipients>(
                      value: value,
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/pr.jpg"),
                              ),
                            ),
                          ),
                          Text(value.targetName ?? ""),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            chooseFromUsersAndStructuresPopup(
                context, transferID, correspondenceID);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.add, size: 30, color: Colors.white),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            height: 75,
            width: 75,
          ),
        ),
      ],
    );
  }

  List<Widget> transferPopupActions(
      BuildContext context, String transferID, String correspondenceID) {
    return <Widget>[
      TextButton(
        onPressed: () async {
          showLoaderDialog(context);
          await multipleTransferspost(
            context: context,
            transferId: transferID,
            correspondenceId: correspondenceID,
          );
          // await multipleTransferspost(
          //   context: context,
          //   transferId: documentBaseModel!.correspondence!.transferId!,
          //   correspondenceId:
          //       documentBaseModel!.correspondence!.correspondenceId,
          // );
          Navigator.pop(context);
          Get.offAllNamed("/InboxPage");
        },
        child: Text(
          "refer".tr,
        ),
      ),
    ];
  }

  Row buildPopupHeader(BuildContext context, String image, String text) {
    return Row(children: [
      Image.asset(
        image,
        height: 20,
        width: 20,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.black.withOpacity(.5),
            fontSize: 18,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      const Spacer(),
      InkWell(
        onTap: () {
          filterWord = "";
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/images/close_button.png',
          width: 30,
          height: 30,
        ),
      ),
    ]);
  }

  chooseFromUsersAndStructuresPopup(
      context, String transferID, String correspondenceID) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: buildPopupHeader(
                context, 'assets/images/refer.png', "refer".tr),
            content: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'To',
                                  ),
                                  onChanged: filterUser,
                                ))),
                        const SizedBox(
                          width: 2,
                        ),
                        CustomButtonWithIcon(
                            icon: Icons.person,
                            onClick: () {
                              listOfUser(0);
                            }),
                        const SizedBox(
                          width: 2,
                        ),
                        CustomButtonWithIcon(
                            icon: Icons.account_balance,
                            onClick: () {
                              listOfUser(1);
                            }),
                        const SizedBox(
                          width: 2,
                        ),
                        CustomButtonWithIcon(
                            icon: Icons.person,
                            onClick: () {
                              listOfUser(2);
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("referTo".tr),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 300,
                        child: Row(
                          children: [
                            Expanded(
                                child: GetBuilder<DocumentController>(
                              autoRemove: false,
                              assignId: true, //tag: "alluser",
                              builder: (logic) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: users.length,
                                    itemBuilder: (context, pos) {
                                      List<String>? a =
                                          logic.users[pos].value?.split(" ");

                                      // bool a=logic.user?[pos].value?.contains(logic.filterWord)??false;
                                      if (logic.users[pos].value
                                              ?.contains(logic.filterWord) ??
                                          false) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              if (!usersWillSendTo
                                                  .contains(logic.users[pos])) {
                                                addTousersWillSendTo(
                                                    user: logic.users[pos]);
                                                SetMultipleReplyWithVoiceNoteRequestModel(
                                                    correspondencesId:
                                                        correspondenceID,
                                                    transferId: transferID,
                                                    id: logic.users[pos].id!);
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    width: 1),
                                              ),
                                              padding: EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                                    child: Center(
                                                      child: FittedBox(
                                                        child: Text(
                                                            "${a?[0][0]} ${a?[0][0] ?? ""}"),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2.0,
                                                            bottom: 2,
                                                            right: 8,
                                                            left: 8),
                                                    child: Text(
                                                      logic.users[pos].value ??
                                                          "",
                                                      maxLines: 3,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    });
                              },
                            )),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //     child: const Icon(Icons.clear),
                            //     height: 50,
                            //     width: 50,
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.grey,
                            //     ),
                            //   ),
                            // ),
                          ],
                        )),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ]),
            ),
            // actions: <Widget>[
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text("Ok"),
            //   ),
            // ],
          );
        });
  }
}

showDilog(
    {required context,
    required String massge,
    required VoidCallback yes,
    required VoidCallback no,
    subTitle = ""}) {
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
              subTitle != "" ? Text(subTitle) : Container(),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: yes,
              child: Text("Ok".tr),
            ),
            TextButton(
              onPressed: no,
              child: Text("Cancel".tr),
            ),
          ],
        );
      });
}

class ViewerAnnotation {
  String? id;
  String? page;
  String? X;
  String? Y;
  String type;
  String? width;
  String? height;
  String imageByte;
  String imageName;
  String? text;
  bool? readonly;
  String? userId;
  bool? hidden;

  ViewerAnnotation({
    this.id,
    this.page,
    this.X,
    this.Y,
    this.type = "",
    this.width,
    this.height,
    this.imageByte = "",
    this.imageName = "",
    this.text,
    this.readonly,
    this.userId,
    this.hidden,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': this.id,
      'Page': this.page,
      'X': this.X,
      'Y': this.Y,
      'Type': this.type,
      'Width': this.width,
      'Height': this.height,
      'ImageByte': this.imageByte,
      'ImageName': this.imageName,
      'Text': this.text,
      'Readonly': this.readonly,
      'UserId': this.userId,
      'Hidden': this.hidden,
    };
  }

  factory ViewerAnnotation.fromMap(Map<String, dynamic> map) {
    return ViewerAnnotation(
      id: map['Id'],
      page: map['Page'],
      X: map['X'],
      Y: map['Y'],
      type: map['Type'],
      width: map['Width'],
      height: map['Height'],
      imageByte: map['ImageByte'],
      imageName: map['ImageName'],
      text: map['Text'],
      readonly: map['Readonly'],
      userId: map['UserId'],
      hidden: map['Hidden'],
    );
  }
}
