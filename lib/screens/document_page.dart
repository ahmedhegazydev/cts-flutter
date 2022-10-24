import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/web_view_controller.dart';
import '../services/apis/reply_with_voice_note_api.dart';
import '../services/json_model/reply_with_voicenote_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/utilitie.dart';
import '../viewer/controllers/viewerController.dart';
import '../viewer/pdfview.dart';
import '../widgets/custom_button_with_icon.dart';

class DocumentPage extends GetWidget<DocumentController> {
  bool portraitIsActive = false;
  List<Widget> list = [];
  Rect? rect;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<DocumentController>(
            autoRemove: false,
            builder: (logic) {
              return Scaffold(
                appBar: _buildAppBar(context),
                body: controller.documentBaseModel == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Obx(
                        () => _buildBody(context),
                      ),
                drawer: _buildDrawer(context),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniStartFloat,
                floatingActionButton: _buildFAB(context),
              );
            }));
  }

  showExportDialog(BuildContext context) {
    Get.defaultDialog(
      title: "export".tr,
      radius: 5,
      content: Column(
        children: [
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text("paperExport".tr),
            onTap: () {
              controller.StartExportAsPaperowrk(
                  context: context,
                  correspondenceId: controller
                      .documentBaseModel!.correspondence!.correspondenceId!,
                  transferId:
                      controller.documentBaseModel!.correspondence!.transferId!,
                  exportAction: "paper");
            },
          ),
          ListTile(
            leading: Icon(Icons.attachment),
            title: Text("electronicExport".tr),
            onTap: () {
              controller.StartExportAsTransfer(
                  context: context,
                  correspondenceId: controller
                      .documentBaseModel!.correspondence!.correspondenceId!,
                  transferId:
                      controller.documentBaseModel!.correspondence!.transferId!,
                  exportAction: "electronic");
            },
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text("paperAndElectronicExport".tr),
            onTap: () {
              controller.StartExportAsTransfer(
                  context: context,
                  correspondenceId: controller
                      .documentBaseModel!.correspondence!.correspondenceId!,
                  transferId:
                      controller.documentBaseModel!.correspondence!.transferId!,
                  exportAction: "paperAndelectronic");
              print("paperAndElectronicExport");
            },
          ),
        ],
      ),
    );
  }

  ExpandableFab _buildFAB(BuildContext context) {
    return ExpandableFab(
      distance: 122.0,
      children: [
        ActionButton(
          onPressed: () async {
            await saveDocumentAnnotations(context);
          },
          icon: const Icon(Icons.save),
        ),
        ActionButton(
          onPressed: () async {
            await saveDocumentAnnotations(context);
            showExportDialog(context);
          },
          icon: const Icon(Icons.upload),
        ),
        ActionButton(
          onPressed: () {
            showLoaderDialog(context);
            completeClick(context);
          },
          icon: const Icon(Icons.archive),
        ),
        ActionButton(
          onPressed: () => clickOnSign(context),
          icon: const Icon(Icons.edit),
        ),
        ActionButton(
          onPressed: () {
            var corresp = controller.documentBaseModel!.correspondence!;
            controller.transferPopup(
                context, corresp.transferId!, corresp.correspondenceId!);
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  Future<void> saveDocumentAnnotations(BuildContext context) async {
    showLoaderDialog(context);
    var all = ViewerController.to.allAnnotations.toList();
    List<Map> data = [];
    all.forEach((element) {
      element.height = element.height * 2;
      element.width = element.width * 2;
      data.add(element.toMap());
    });
    Map<String, List<Map>> updated = {"1": data};
    var stringData = jsonEncode(updated);

    await controller.SaveDocAnnotationsData(
        context: context,
        attachmentId:
            controller.isOriginalMailAttachmentsList!.attachmentId.toString(),
        correspondenceId:
            controller.documentBaseModel!.correspondence!.correspondenceId!,
        delegateGctId: "0",
        documentAnnotationsString: stringData,
        isOriginalMail: controller
            .isOriginalMailAttachmentsList!.isOriginalMail!
            .toString(),
        transferId: controller.documentBaseModel!.correspondence!.transferId!,
        userId: controller.secureStorage
            .readIntSecureData(AllStringConst.UserId)
            .toString(),
        docURL: controller.pdfAndSingData.first);
    ViewerController.to.allAnnotations.clear();
    Navigator.of(context).pop();
  }

  AppBar _buildAppBar(BuildContext context) {
    var title = "appTitle".tr;
    var ref = controller.documentBaseModel!.correspondence!.gridInfo![2].value;
    if (ref != null && ref != "") {
      title = ref;
    }
    return AppBar(
      toolbarHeight: 100,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.start,
      ),
      actions: <Widget>[
        SizedBox(
          width: 100,
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'back',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  _buildDrawer(BuildContext context) {
    return Drawer(child: _MetadataSideMenu(context));
  }

  /// ToDo get the print
  Widget _buildBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size s = Size(size.width, size.height);
    if (controller.documentEditedInOfficeId.value != 0) {
      return Center(
        child: IconButton(
          onPressed: () async {
            showLoaderDialog(context);
            await controller.refreshOffice(context: context);

            // await getDocumentAttachments(
            //     context: context,
            //     docId: correspondence.correspondenceId!,
            //     transferId: correspondence.transferId!);
            Navigator.pop(context);
            await Get.find<InboxController>().openDocument(
                context: context,
                correspondence: controller.documentBaseModel!.correspondence!);

            // await Future.delayed(Duration(seconds: 1));
            // Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.refresh,
          ),
        ),
      );
    }
    if (controller.pdfAndSingData.length > 0) {
      print("fi data ");
      print(controller.pdfAndSingData.first);
      return SizedBox(
        width: size.width,
        height: size.height - 100,
        child: PDFView(
            originalAnnotations: controller.annotations,
            url: controller.pdfAndSingData.first,
            color: Get.find<MController>().appcolor,
            size: s),
      );
    }
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.black,
      ),
    );
    //  });

    //  return documentViewer;
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   //  mainAxisSize: MainAxisSize.max,
    //   children: [documentViewer],
    // );
  }

  void _openVisualTracking() {
    Get.find<WebViewPageController>().isPdf = false;
    var ref = controller.documentBaseModel?.correspondence!.gridInfo![2].value;
    var url = controller.documentBaseModel?.correspondence!.visualTrackingUrl!;

    if (ref != null && ref != "")
      Get.find<WebViewPageController>().title = ref;
    else
      Get.find<WebViewPageController>().title = "tracking".tr;
    Get.find<WebViewPageController>().url = url;
    Get.toNamed(
      "WebViewPage",
    );
  }

  bool correspondanceHasAction(String name) {
    var r = controller.documentBaseModel?.correspondence?.controlList;
    if (r == null) return false;
    for (var element in r.toolbarItems) {
      if (element!.name!.toLowerCase() == name) {
        return true;
      }
    }
    return false;
  }

  _MetadataSideMenu(BuildContext context) {
    var cm = Get.find<InboxController>().correspondencesModel;
    var correspondence = controller.documentBaseModel!.correspondence!;
    int priorityID = int.parse(correspondence.priorityId!);
    var priority =
        cm?.priorities?.where((element) => element.Value == priorityID).first;
    int privacyID = int.parse(correspondence.privacyId ?? "0");
    var privacy =
        cm?.privacies?.where((element) => element.Value == privacyID).first;

    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                )

                //action":
              ],
            ),
            Text(
              "action".tr,
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CTSActionButton('assets/images/refer.png', "refer".tr, () {
                  // loader
                  // showLoaderDialog(context);
                  var corresp = controller.documentBaseModel!.correspondence!;
                  controller.transferPopup(
                      context, corresp.transferId!, corresp.correspondenceId!);
                }),
                if (correspondanceHasAction("export"))
                  CTSActionButton('assets/images/up_arrow.png', "export".tr,
                      () async {
                    await saveDocumentAnnotations(context);
                    showExportDialog(context);
                  }),
                CTSActionButton('assets/images/ending.png', "ending".tr, () {
                  // loader
                  showLoaderDialog(context);
                  completeClick(context);
                }),
                // edit
                if (controller.canOpenInOffice())
                  CTSActionButton('assets/images/A.png', "marking".tr,
                      () async {
                    // loader
                    showLoaderDialog(context);
                    await openInOffice(context);
                  }),
                CTSActionButton('assets/images/track.png', "tracking".tr, () {
                  _openVisualTracking();
                }),
                CTSActionButton('assets/images/track.png', "Reply".tr, () {
                  replyClick(context);
                }),
                if (controller.notoragnalFileDoc)
                  CTSActionButton('assets/images/track.png', "tracking".tr, () {
                    controller.backTooragnalFileDocpdf();
                  }),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "data".tr,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CTSActionButton('assets/images/track.png', 'processes'.tr,
                    () async {
                  await clickOnSHowAuditLog(context);
                }),
                CTSActionButton('assets/images/track.png', "transferDetails".tr,
                    () {
                  clickOnSHowTransferData(context);
                }),
                CTSActionButton('assets/images/track.png', "links".tr, () {
                  getDocumentLinks(context);
                }),
                CTSActionButton('assets/images/track.png', "recievers".tr, () {
                  clickOnRecieversData(context);
                }),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "data".tr,
            ),
            const Divider(
              thickness: 1,
            ),
            Wrap(
              // mainAxisAlignment:
              //     MainAxisAlignment
              //         .spaceAround,
              children: [
                // if (controller.correspondences.priorityId == "1")
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.priority_high,
                                color: correspondence.priorityId == "3"
                                    ? AppColor
                                    : RedColor),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              Get.locale?.languageCode == "en"
                                  ? priority!.Text!
                                  : priority!.TextAr!,
                              //     "veryimportant".tr,
                              style: TextStyle(color: AppColor),
                            ),
                          ]),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning, color: AppColor),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              Get.locale?.languageCode == "en"
                                  ? privacy!.Text!
                                  : privacy!.TextAr!,
                              style: TextStyle(color: AppColor),
                            ),
                          ]),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                correspondence.isLocked!
                                    ? Icons.lock
                                    : Icons.lock_open,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(
                              width: 4,
                            ),
                            if (correspondence.isLocked ?? false)
                              Text(
                                "closed".tr,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ...List.generate(correspondence.metadata!.length, (index) {
              var item = correspondence.metadata![index];
              return _itemSideMenu(
                context: context,
                title: item.label!,
                data: item.value ?? "",
              );
            }),
            if (controller.documentBaseModel?.attachments?.hasVoice ?? false)
              Container(
                height: 40,
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.grey,
                    )),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            print("object");
                            if (!controller.isPlayingAudio.value) {
                              controller.isPlayingAudio.toggle();
                              FlutterSoundPlayer audioPlayer =
                                  FlutterSoundPlayer();

                              audioPlayer.openPlayer();
                              var base64 = controller
                                  .documentBaseModel?.attachments?.voiceNote!;

                              await audioPlayer.startPlayer(
                                fromDataBuffer: base64Decode(base64!),
                                whenFinished: () {
                                  controller.isPlayingAudio.toggle();
                                },
                              );
                            } else {
                              controller.isPlayingAudio.value = false;
                              controller.audioPlayer!.stopPlayer();
                            }
                          },
                          child: Icon(
                            controller.isPlayingAudio.value
                                ? Icons.stop
                                : Icons.play_arrow,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> clickOnRecieversData(BuildContext context) async {
    showLoaderDialog(context);
    var result = await controller.getRecieversData(context);
    Navigator.of(context).pop();
    if (result == null) return;
    var data = result.documentReceivers!;
    //var data = controller.getDocumentTransfersModel!.documentTransfers;
    var dialogImage = Image.asset(
      'assets/images/ending.png',
      height: 20,
      width: 20,
    );
    var dialogTitle = "recievers".tr;
    List<DataColumn> columns = [
      DataColumn(label: Text('name2'.tr)),
      DataColumn(label: Text('structure'.tr)),
      DataColumn(label: Text('date2'.tr)),
    ];
    List<DataRow> rows = List<DataRow>.generate(
      data.length,
      (index) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(data[index].rCNTNAME!)),
            DataCell(Text(data[index].rSTCNAME!)),
            DataCell(Text(data[index].strRDate!)),
          ],
        );
      },
    );

    Navigator.pop(context);
    generateListingDialog(context, dialogImage, dialogTitle, columns, rows);
  }

  Future<void> getDocumentLinks(BuildContext context) async {
    showLoaderDialog(context);
    var result = await controller.getLinks(context);
    Navigator.of(context).pop();
    if (result == null) return;
    var data = result.links!;
    //var data = controller.getDocumentTransfersModel!.documentTransfers;
    var dialogImage = Image.asset(
      'assets/images/ending.png',
      height: 20,
      width: 20,
    );
    var dialogTitle = "links".tr;
    List<DataColumn> columns = [
      DataColumn(label: Text('ref'.tr)),
      DataColumn(label: Text('bookDate'.tr)),
      DataColumn(label: Text('privacy'.tr)),
      DataColumn(label: Text('user'.tr)),
    ];
    List<DataRow> rows = List<DataRow>.generate(
      data.length,
      (index) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(data[index].docReference!)),
            DataCell(Text(data[index].docDate!)),
            DataCell(Text(data[index].privacy!)),
            DataCell(Text(data[index].linkedBy!)),
          ],
        );
      },
    );

    Navigator.pop(context);
    generateListingDialog(context, dialogImage, dialogTitle, columns, rows);
  }

  Future<void> clickOnSHowTransferData(BuildContext context) async {
    showLoaderDialog(context);
    var result = await controller.getTransfersData(context);
    Navigator.of(context).pop();
    if (result == null) return;
    var data = result.documentTransfers!;
    var dialogImage = Image.asset(
      'assets/images/ending.png',
      height: 20,
      width: 20,
    );
    var dialogTitle = "transferDetails".tr;
    List<DataColumn> columns = [
      DataColumn(label: Text('transferTo'.tr)),
      DataColumn(label: Text('transferDate'.tr)),
      DataColumn(label: Text('purpose'.tr)),
      DataColumn(label: Text('status'.tr)),
      DataColumn(label: Text('action'.tr)),
    ];
    List<DataRow> rows = List<DataRow>.generate(
      data.length,
      (index) {
        return DataRow(
          cells: <DataCell>[
            DataCell(
              Text(data[index].transferReceivedByStructure!.fullNameAr! +
                  " | " +
                  data[index].transferReceivedByUser!.fullNameAr!),
            ),
            DataCell(Text(data[index].strTransferDate!)),
            DataCell(Text(data[index].purpose!.textAr!)),
            DataCell(Text(data[index].transferStatusId!.toString())),
            DataCell(Text("")),
          ],
        );
      },
    );

    Navigator.pop(context);
    generateListingDialog(context, dialogImage, dialogTitle, columns, rows);
  }

  Future<void> clickOnSHowAuditLog(BuildContext context) async {
    showLoaderDialog(context);

    var result = await controller.getAuditLog(context);
    Navigator.of(context).pop();
    if (result == null) return;
    var data = result.documentLogs!;
    var dialogImage = Image.asset(
      'assets/images/ending.png',
      height: 20,
      width: 20,
    );
    var dialogTitle = 'processes'.tr;
    List<DataColumn> columns = [
      DataColumn(label: Text('type'.tr)),
      DataColumn(label: Text('date'.tr)),
      DataColumn(label: Text('by'.tr)),
      DataColumn(label: Text('details'.tr)),
    ];
    List<DataRow> rows = List<DataRow>.generate(
      data.length,
      (index) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(data[index].dLACTIONNAME ?? "")),
            DataCell(Text(data[index].actionDate ?? "")),
            DataCell(Text(data[index].actionUser ?? "")),
            DataCell(Text(data[index].dLDETAILS ?? "")),
          ],
        );
      },
    );

    //rows.add(rows[0]);

    Navigator.pop(context);
    generateListingDialog(context, dialogImage, dialogTitle, columns, rows);
  }

  void generateListingDialog(BuildContext context, Image dialogImage,
      String dialogTitle, List<DataColumn> columns, List<DataRow> rows) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          dialogImage,
          const SizedBox(
            width: 8,
          ),
          Text(
            dialogTitle,
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
              controller.filterWord = "";
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/close_button.png',
              width: 30,
              height: 30,
            ),
          ),
        ]),
        // title: Text(" "),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: DataTable(
              columns: columns,
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openInOffice(BuildContext context) async {
    var fileURL =
        await controller.prepareOpenDocumentInOffice(context: context);
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();
    if (fileURL.isNotEmpty) {
      final Uri toLaunch = Uri.parse("ms-word:ofv|u|$fileURL|a|App");
      Navigator.pop(context);

      final bool nativeAppLaunchSucceeded = await launchUrl(
        toLaunch,
        mode: LaunchMode.externalApplication,
      );

      if (!nativeAppLaunchSucceeded) {
        final bool otherLaunchSucceeded = await launchUrl(
          toLaunch,
        );
        // Navigator.pop(context);
        // show error alert
        if (!otherLaunchSucceeded) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "tryAgainLater".tr,
            ),
          );
        }
      }
    } else {
      CustomSnackBar.error(
        message: "tryAgainLater".tr,
      );
    }
  }

  Future<dynamic> completeClick(BuildContext context) {
    Navigator.of(context).pop();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          Image.asset(
            'assets/images/ending.png',
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            "ending".tr,
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
              controller.filterWord = "";
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/close_button.png',
              width: 30,
              height: 30,
            ),
          ),
        ]),
        // title: Text(" "),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("note"),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: TextFormField(
                        maxLines: 4,
                      ),
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              print(Get.find<InboxController>().completeCustomActions?.name);
              print(Get.find<InboxController>().completeCustomActions?.icon);

              String data =
                  'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${controller.documentBaseModel!.correspondence!.correspondenceId}&transferId=${controller.documentBaseModel!.correspondence!.transferId}&actionType=Complete&note=${Get.find<InboxController>().completeNote}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';

              showLoaderDialog(context);
              await Get.find<InboxController>()
                  .completeInCorrespondence(context: context, data: data);
              Navigator.pop(context);
              Get.offAllNamed("/InboxPage");

              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  icon: Container(),
                  backgroundColor: Colors.lightGreen,
                  message: "EndedSuccess".tr,
                ),
              );
            },
            child: Text(
              "ending".tr,
            ),
          ),
        ],
      ),
    );
  }

// signature design
  Future<void> clickOnSign(BuildContext context) async {
    print("object");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Row(
          children: [
            IconButton(
              onPressed: () {
                // open new signature pad
                Get.close(1);
                newSignaturePad(context);
              },
              icon: Icon(
                Icons.add_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            ),
            Wrap(
              direction: Axis.vertical,
              children: [
                Text(
                  "chooseSign".tr,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * .375,
                  width: MediaQuery.of(context).size.width * .5,
                  color: Colors.grey[200],
                  child: GetBuilder<DocumentController>(
                    assignId: true,
                    autoRemove: false,
                    builder: (logic) {
                      return GridView.builder(
                        itemCount: controller.multiSignatures.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              final key = GlobalKey();
                              final Uint8List? data = base64Decode(
                                  controller.multiSignatures[index].signature!);
                              ViewerController.to
                                  .prepareToAddSignatureAnnotationOnTap(
                                      Image.memory(
                                        data!,
                                        fit: BoxFit.fill,
                                        key: key,
                                        width: 100,
                                        height: 100,
                                      ),
                                      controller
                                          .multiSignatures[index].signature!,
                                      "8");
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                ),
                              ),
                              child: Image.memory(
                                dataFromBase64String(controller
                                    .multiSignatures[index].signature),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("close".tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  newSignaturePad(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Container(
          height: orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * .5
              : MediaQuery.of(context).size.height * .35,
          width: MediaQuery.of(context).size.width * .8,
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: Signature(
                  controller: controller.controller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.controller.clear();
                      },
                      child: Icon(
                        Icons.clear,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 40),
                    InkWell(
                      onTap: () async {
                        //     ViewerController.to.prepareToAddAnnotationOnTap(
                        //     AnnotationBaseTypes.signature);
                        final key = GlobalKey();
                        final Uint8List? data =
                            await controller.controller.toPngBytes();
                        String base64String = base64Encode(data!);
                        ViewerController.to
                            .prepareToAddSignatureAnnotationOnTap(
                                Image.memory(
                                  data,
                                  fit: BoxFit.fill,
                                  key: key,
                                  width: 100,
                                  height: 100,
                                ),
                                base64String,
                                "7");
                        //             var ann = ViewerController.to.allAnnotations.value;
                        Get.back();
                      },
                      child: Icon(
                        Icons.save,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _itemSideMenu({context, required String title, required String data}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.grey, fontSize: 15),
          textAlign: TextAlign.start,
        ),
        Text(
          data,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.black, fontSize: 15),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  final List<_HomeItem> items = List.generate(
    5,
    (i) => _HomeItem(
      i,
      'Tile n°$i',
    ),
  );

  void replyClick(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Image.asset(
              'assets/images/refer.png'
              //
              ,
              height: 20,
              width: 20,
            ),
            SizedBox(
              width: 16,
            ),
            Text("Reply".tr,
                style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary)),
            Spacer(),
            InkWell(
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: Image.asset(
                  "assets/images/close_button.png",
                  height: 24,
                  width: 24,
                ))
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(
                    "name".tr,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: createMaterialColor(
                            const Color.fromRGBO(77, 77, 77, 1),
                          ),
                          fontSize: 15,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(controller
                            .documentBaseModel!.correspondence!.fromUser ??
                        ""),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/pr.jpg"),
                    backgroundColor: Colors.cyan,
                    maxRadius: 30,
                    minRadius: 30,
                  ),
                  SizedBox(
                    width: 8,
                  )
                ]),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("audioNotes".tr),
                    ),
                    Spacer(),
                    Text("private".tr),
                    GetBuilder<InboxController>(
                      id: "pr",
                      assignId: true,
                      autoRemove: false,
                      builder: (logic) {
                        return Checkbox(
                          value: logic.isPrivate,
                          onChanged: logic.updateISPrivate,
                        );
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 40,
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  controller.record.isRecording
                                      ? controller.stopMathod()
                                      : controller.recordMathod(
                                          id: controller.documentBaseModel!
                                              .correspondence!.fromUserId!,
                                        );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GetBuilder<DocumentController>(
                                      id: "id",
                                      builder: (logic) {
                                        return Icon(
                                            Get.find<DocumentController>()
                                                    .recording
                                                ? Icons.stop
                                                : Icons.mic);
                                      }),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: 1,
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.playMathod(
                                        id: controller.documentBaseModel!
                                            .correspondence!.fromUserId!);
                                  },
                                  child: Icon(Icons.play_arrow,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                    decoration: InputDecoration(
                        hintText: " ادخل الرد",
                        contentPadding: EdgeInsets.all(16)),
                    onChanged: (v) {
                      controller.replyNote = v;
                    },
                    maxLines: 4,
                  ),
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 8,
                ),
              ]),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              ReplyWithVoiceNoteRequestModel v;
              String? audioFileBes64 =
                  await audiobase64String(file: controller.recordFile);

              ReplyWithVoiceNoteApi replayAPI = ReplyWithVoiceNoteApi(context);
              if (controller.recordFile != null) {
                v = ReplyWithVoiceNoteRequestModel(
                    userId: controller
                        .documentBaseModel!.correspondence!.fromUserId
                        .toString(),
                    transferId: controller
                        .documentBaseModel!.correspondence!.transferId,
                    token: Get.find<InboxController>().secureStorage.token(),
                    correspondencesId: controller
                        .documentBaseModel!.correspondence!.correspondenceId,
                    language: Get.locale?.languageCode == "en" ? "en" : "ar",
                    voiceNote: audioFileBes64,
                    notes: controller.replyNote,
                    voiceNoteExt: "m4a",
                    voiceNotePrivate: Get.find<InboxController>().isPrivate);
              } else {
                v = ReplyWithVoiceNoteRequestModel(
                    userId: controller
                        .documentBaseModel!.correspondence!.fromUserId
                        .toString(),
                    transferId: controller
                        .documentBaseModel!.correspondence!.transferId,
                    token: Get.find<InboxController>().secureStorage.token(),
                    correspondencesId: controller
                        .documentBaseModel!.correspondence!.correspondenceId,
                    language: Get.locale?.languageCode == "en" ? "en" : "ar",
                    voiceNote: null,
                    notes: controller.replyNote,
                    voiceNoteExt: null,
                    voiceNotePrivate: false);
              }

              print(v.toMap());
              showLoaderDialog(context);
              await replayAPI.post(v.toMap()).then((value) {
                Navigator.pop(context);
                ReplyWithVoiceNoteModel v = value as ReplyWithVoiceNoteModel;
                if (v.status == 1) {
                  Get.snackbar("", "تمت العمليه بنجاح");
                }
                // Get.       getDashboardStats()
                Get.find<LandingPageController>()
                    .getDashboardStats(context: context);
                Get.find<InboxController>().getCorrespondencesData(
                    context: context,
                    inboxId: Get.find<InboxController>().inboxId,
                    pageSize: 20,
                    showThumbnails: false);
              });

              /// ToDo send Replay
              Get.find<InboxController>().recordFile = null;
              Get.find<InboxController>().replyNote = "";
              // Navigator.of(ctx).pop();
              Get.offAllNamed("/InboxPage");
            },
            child: Text("send".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// class Tile extends StatefulWidget {
//   // final DocModel.AttachmentsList item;
//   final AttachmentsG2gInfoExport item;
//   final Function delete;

//   Tile(this.item, this.delete);

//   @override
//   State<StatefulWidget> createState() => _TileState(item, delete);
// }

class CTSActionButton extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback action;
  const CTSActionButton(this.image, this.name, this.action, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Column(
        children: [
          CircleAvatar(
            child: Image.asset(
              color: Colors.white,
              image,
              height: 20,
              width: 20,
            ),
          ),
          Text(
            name,
          )
        ],
      ),
    );
  }
}

class _HomeItem {
  const _HomeItem(
    this.index,
    this.title,
  );

  final int index;
  final String title;
}
