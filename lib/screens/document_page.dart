//import 'dart:js';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cts/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/web_view_controller.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/utilitie.dart';
import '../viewer/controllers/viewerController.dart';
import '../viewer/pdfview.dart';
import '../widgets/custom_button_with_icon.dart';
import 'dart:developer';

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
                body: controller.canOpenDocumentModel == null
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
              controller.getIsAlreadyExportedAsPaperwork(
                  context: context,
                  correspondenceId:
                      controller.correspondences.correspondenceId!,
                  transferId: controller.correspondences.transferId!,
                  exportAction: "paper");
            },
          ),
          ListTile(
            leading: Icon(Icons.attachment),
            title: Text("electronicExport".tr),
            onTap: () {
              controller.isAlreadyExportedAsTransfer(
                  context: context,
                  correspondenceId:
                      controller.correspondences.correspondenceId!,
                  transferId: controller.correspondences.transferId!,
                  exportAction: "electronic");
            },
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text("paperAndElectronicExport".tr),
            onTap: () {
              controller.isAlreadyExportedAsTransfer(
                  context: context,
                  correspondenceId:
                      controller.correspondences.correspondenceId!,
                  transferId: controller.correspondences.transferId!,
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
            var all = ViewerController.to.allAnnotations.toList();
            //       var sall = ViewerController.to.movableItems.toJson();
            List<Map> data = [];
            all.forEach((element) {
              data.add(element.toMap());
            });
            print(data);
            Map<String, List<Map>> updated = {"1": data};
            var stringData = jsonEncode(updated);
            //log(jsonEncode(updated));
            log(stringData);
            //  var stringAnnotations = stringData.replaceAll('"', '"\\');

            await controller.SaveDocAnnotationsData(
                context: context,
                attachmentId: controller
                    .isOriginalMailAttachmentsList!.attachmentId
                    .toString(),
                correspondenceId: controller
                    .canOpenDocumentModel!.correspondence!.correspondenceId!,
                delegateGctId: "0",
                documentAnnotationsString: stringData,
                isOriginalMail: controller
                    .isOriginalMailAttachmentsList!.isOriginalMail!
                    .toString(),
                transferId: controller
                    .canOpenDocumentModel!.correspondence!.transferId!,
                userId: controller.secureStorage
                    .readIntSecureData(AllStringConst.UserId)
                    .toString());

            // log(updated);
          },
          icon: const Icon(Icons.save),
        ),
        ActionButton(
          onPressed: () {
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
            showLoaderDialog(context);
            _popUpMenuTransfer(context);
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    var title = "appTitle".tr;
    var ref = controller.correspondences.gridInfo![2].value;
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
    Orientation orientation = MediaQuery.of(context).orientation;

    // return PDFView(
    //     originalAnnotations: controller.annotations,
    //     url: controller.pdfAndSingData.first,
    //     color: Get.find<MController>().appcolor,
    //     size: s);

    // var documentViewer = GetBuilder<DocumentController>(
    //     autoRemove: false,
    //     builder: (logic) {
    // print(controller.documentEditedInOfficeId);
    Size size = MediaQuery.of(context).size;
    // var v = controller.correspondences.toJson();

    Size s = Size(size.width, size.height);
    if (controller.documentEditedInOfficeId.value != 0) {
      return Center(
        child: IconButton(
          onPressed: () async {
            showLoaderDialog(context);
            await controller.refreshOffice(context: context);

            await Get.find<InboxController>().canOpenDoc(
                context: context,
                correspondenceId: controller
                    .canOpenDocumentModel!.correspondence!.correspondenceId,
                transferId: controller
                    .canOpenDocumentModel!.correspondence!.transferId);
            await Future.delayed(Duration(seconds: 1));
            Navigator.of(context).pop();
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
    print(controller.correspondences.gridInfo![2].value);
    var ref = controller.correspondences.gridInfo![2].value;
    var url =
        controller.canOpenDocumentModel?.correspondence!.visualTrackingUrl!;

    if (ref != null && ref != "")
      Get.find<WebViewPageController>().title = ref;
    else
      Get.find<WebViewPageController>().title = "tracking".tr;
    Get.find<WebViewPageController>().url = url;
    Get.toNamed(
      "WebViewPage",
    );
  }

  _MetadataSideMenu(BuildContext context) {
    var cm = Get.find<InboxController>().correspondencesModel;
    int priorityID = int.parse(controller.correspondences.priorityId!);
    var priority =
        cm?.priorities?.where((element) => element.Value == priorityID).first;
    int privacyID = int.parse(controller.correspondences.privacyId!);
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
                  showLoaderDialog(context);
                  _popUpMenuTransfer(context);
                }),
                CTSActionButton('assets/images/up_arrow.png', "export".tr, () {
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
                CTSActionButton('assets/images/track.png', "audit".tr,
                    () async {
                  await clickOnSHowAuditLog(context);
                }),
                CTSActionButton('assets/images/track.png', "transferData".tr,
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
                                color:
                                    controller.correspondences.priorityId == "3"
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
                          width: 1,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                controller.correspondences.isLocked!
                                    ? Icons.lock
                                    : Icons.lock_open,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(
                              width: 4,
                            ),
                            if (controller.correspondences.isLocked ?? false)
                              Text("closed".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ...List.generate(controller.correspondences!.metadata!.length,
                (index) {
              var item = controller.correspondences!.metadata![index];
              return _itemSideMenu(
                context: context,
                title: item.label!,
                data: item.value ?? "",
              );
            }),
            if (controller.canOpenDocumentModel?.attachments?.hasVoice ?? false)
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
                              var base64 = controller.canOpenDocumentModel
                                  ?.attachments?.voiceNote!;

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
    var dialogTitle = "Transfers";
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
    var dialogTitle = "Transfers";
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
    //var data = controller.getDocumentTransfersModel!.documentTransfers;
    var dialogImage = Image.asset(
      'assets/images/ending.png',
      height: 20,
      width: 20,
    );
    var dialogTitle = "Transfers";
    List<DataColumn> columns = [
      DataColumn(label: Text('transferTo'.tr)),
      DataColumn(label: Text('transferDate'.tr)),
      DataColumn(label: Text('purpose'.tr)),
      DataColumn(label: Text('status'.tr)),
      DataColumn(label: Text('action'.tr)),
    ];
    List<DataRow> rows = List<DataRow>.generate(
      data!.length,
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
    var dialogTitle = "audit".tr;
    List<DataColumn> columns = [
      DataColumn(label: Text('type'.tr)),
      DataColumn(label: Text('date'.tr)),
      DataColumn(label: Text('by'.tr)),
      DataColumn(label: Text('details'.tr)),
    ];
    List<DataRow> rows = List<DataRow>.generate(
      data!.length,
      (index) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(data[index].dLACTIONNAME!)),
            DataCell(Text(data[index].actionDate!)),
            DataCell(Text(data[index].actionUser!)),
            DataCell(Text(data[index].dLDETAILS!)),
          ],
        );
      },
    );

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
          child: DataTable(
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }

  Future<void> openInOffice(BuildContext context) async {
    var fileURL =
        await controller.prepareOpenDocumentInOffice(context: context);
    await Future.delayed(Duration(seconds: 1));
    //fileURL =  "https://ecm-uat.mofa.gov.qa:444/sites/temp-office/Shared%20Documents/25648235/5726929_اجازة مرضية.docx";
    Navigator.of(context).pop();
    if (fileURL.isNotEmpty) {
      final Uri toLaunch = Uri.parse("ms-word:ofv|u|$fileURL|a|App");
      Navigator.pop(context);
      final box = context.findRenderObject() as RenderBox?;
      final Size size = MediaQuery.of(context).size;
      // final files = <XFile>[];
      // files.add(XFile(fileURL, name: "dc"));
      // await Share.share(fileURL,
      //     sharePositionOrigin:
      //         Rect.fromLTWH(0, 0, size.width, size.height / 2));
      // await Share.shareXFiles(files,
      //     sharePositionOrigin:
      //         Rect.fromLTWH(0, 0, size.width, size.height / 2));
      //Rect.fromLTWH(box.left + 40, box.top + 20, 2, 2));
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
    }
  }

  Future<dynamic> completeClick(BuildContext context) {
    Navigator.of(context).pop();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Image.asset(
            'assets/images/ending.png'
            //
            ,
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
                  'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${controller.canOpenDocumentModel!.correspondence!.correspondenceId}&transferId=${controller.canOpenDocumentModel!.correspondence!.transferId}&actionType=Complete&note=${Get.find<InboxController>().completeNote}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';

              // Navigator.of(ctx).pop();
              showLoaderDialog(context);
              await Get.find<InboxController>()
                  .completeInCorrespondence(context: context, data: data);
              Navigator.pop(context);
              //Get.back(closeOverlays: true);
              //  Get.back();
              Get.offAllNamed("/InboxPage");

              // Get.offNamed("InboxPage"); //.  Get.toNamed("/InboxPage");
              // Ge
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

  _popUpMenuTransfer(context) async {
    await controller.listFavoriteRecipients(context: context);
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Image.asset(
                'assets/images/refer.png'
                //
                ,
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "refer".tr,
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
            content: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("referTo".tr,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black.withOpacity(.5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * .8,
                      child: GetBuilder<DocumentController>(
                          autoRemove: false,
                          builder: (logic) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (controller
                                            .favoriteRecipientsResponse
                                            ?.recipients
                                            ?.length ??
                                        0) +
                                    1,
                                itemBuilder: (context, pos) {
                                  if (pos ==
                                      (controller.favoriteRecipientsResponse
                                              ?.recipients?.length ??
                                          0)) {
                                    return InkWell(
                                      onTap: () {
                                        _popUpMenuMore(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Icon(Icons.add,
                                            size: 30, color: Colors.white),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        height: 75,
                                        width: 75,
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Destination user = Destination(
                                              value: controller
                                                  .favoriteRecipientsResponse!
                                                  .recipients![pos]
                                                  .targetName,
                                              id: controller
                                                  .favoriteRecipientsResponse!
                                                  .recipients![pos]
                                                  .targetGctid);
                                          controller.addTousersWillSendTo(
                                              user: user);
                                        },
                                        child: Card(
                                          elevation: 8,
                                          child: Row(
                                            children: [
                                              controller
                                                      .favoriteRecipientsResponse!
                                                      .recipients![pos]
                                                      .targetPhotoBs64!
                                                      .trim()
                                                      .isEmpty
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    "assets/images/pr.jpg",
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                      height: 75,
                                                      width: 75,
                                                    )
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          image: DecorationImage(
                                                              image: MemoryImage(
                                                                  dataFromBase64String(controller
                                                                      .favoriteRecipientsResponse!
                                                                      .recipients![
                                                                          pos]
                                                                      .targetPhotoBs64!)),
                                                              fit: BoxFit
                                                                  .cover)),
                                                      height: 75,
                                                      width: 75,
                                                    ),
                                              Text(controller
                                                  .favoriteRecipientsResponse!
                                                  .recipients![pos]
                                                  .targetName!)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  //  CircleAvatar(backgroundColor: Colors.red,backgroundImage: AssetImage("assets/images/pr.jpg",),,radius: 30,);
                                });
                          }),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 300, // MediaQuery.of(context).size.height * .5,
                        child: GetBuilder<DocumentController>(
                          autoRemove: false,
                          //   assignId: true,//tag: "user",
                          builder: (logic) {
                            return //Text(logic.filterWord);

                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        controller.usersWillSendTo.length,
                                    itemBuilder: (context, pos) {
                                      return //Text(controller.filterWord);

                                          Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.grey[200],
                                          child: Column(children: [
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "name".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3!
                                                        .copyWith(
                                                          color:
                                                              createMaterialColor(
                                                            const Color
                                                                    .fromRGBO(
                                                                77, 77, 77, 1),
                                                          ),
                                                          fontSize: 15,
                                                        ),
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(logic
                                                            .usersWillSendTo[
                                                                pos]
                                                            .value ??
                                                        ""),
                                                    // child: Container(
                                                    //   height: 50,
                                                    //   width: 50,
                                                    //   // decoration: const BoxDecoration(
                                                    //   //   shape: BoxShape.circle,
                                                    //   //   color: Colors.grey,
                                                    //   // ),
                                                    // ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "i deeeeeeeeeeeeeeeeeeeeeeee");
                                                      controller.transfarForMany
                                                          .remove(logic
                                                              .usersWillSendTo[
                                                                  pos]
                                                              .id);
                                                      logic.delTousersWillSendTo(
                                                          user: logic
                                                                  .usersWillSendTo[
                                                              pos]);
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
                                                    child: DropdownButton<
                                                        CustomActions>(
                                                      alignment:
                                                          Alignment.topRight,
                                                      value: logic.getactions(
                                                          logic
                                                              .usersWillSendTo[
                                                                  pos]
                                                              .id),
                                                      // icon: const Icon(
                                                      //     Icons.arrow_downward),
                                                      elevation: 16,

                                                      underline: SizedBox(),
                                                      hint: Text("اختار"),
                                                      onChanged: (CustomActions?
                                                          newValue) {
                                                        controller.setactions(
                                                            logic
                                                                .usersWillSendTo[
                                                                    pos]
                                                                .id,
                                                            newValue!);
                                                        //  dropdownValue = newValue!;
                                                      },
                                                      items: controller
                                                          .customActions
                                                          ?.map<
                                                                  DropdownMenuItem<
                                                                      CustomActions>>(
                                                              (CustomActions
                                                                  value) {
                                                        return DropdownMenuItem<
                                                            CustomActions>(
                                                          value: value,
                                                          child:
                                                              Text(value.name!),
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              ///To Do Start and stop rec
                                                              controller.record
                                                                      .isRecording
                                                                  ? controller
                                                                      .stopMathod()
                                                                  : controller
                                                                      .recordMathod(
                                                                      id: logic
                                                                          .usersWillSendTo[
                                                                              pos]
                                                                          .id,
                                                                    );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: GetBuilder<
                                                                      DocumentController>(
                                                                  id: "record",
                                                                  autoRemove:
                                                                      false,
                                                                  builder:
                                                                      (logic) {
                                                                    return Icon(controller
                                                                            .record
                                                                            .isRecording
                                                                        ? Icons
                                                                            .stop
                                                                        : Icons
                                                                            .mic);
                                                                  }),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Obx(
                                                              () => InkWell(
                                                                onTap: () {
                                                                  if (!controller
                                                                      .isPlayingAudio
                                                                      .value)
                                                                    controller.playMathod(
                                                                        id: logic
                                                                            .usersWillSendTo[pos]
                                                                            .id);
                                                                  else {
                                                                    controller
                                                                        .isPlayingAudio
                                                                        .value = false;
                                                                    controller
                                                                        .audioPlayer!
                                                                        .stopPlayer();
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  controller
                                                                          .isPlayingAudio
                                                                          .value
                                                                      ? Icons
                                                                          .stop
                                                                      : Icons
                                                                          .play_arrow,
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
                                                  controller
                                                      .multiTransferNode[logic
                                                          .usersWillSendTo[pos]
                                                          .id]
                                                      ?.note = v;
                                                  controller.setNots(
                                                      id: logic
                                                          .usersWillSendTo[pos]
                                                          .id!,
                                                      not: v);
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
                                      );
                                    });
                          },
                        ))
                  ]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  ///ToDo
                  ///send to many

                  controller.multipleTransferspost(
                      context: context,
                      transferId: controller
                          .canOpenDocumentModel!.correspondence!.transferId!,
                      correspondenceId: controller.canOpenDocumentModel!
                          .correspondence!.correspondenceId);
                  Navigator.pop(context);

                  Navigator.pop(context);
                  //Get.back(closeOverlays: true);
                  //  Get.back();
                  Get.offAllNamed("/InboxPage");

                  // Get.offNamed("InboxPage"); //.  Get.toNamed("/InboxPage");
                  // Ge
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
                  "refer".tr,
                ),
              ),
            ],
          );
        });
  }

// الاحاله القديمة//
  _popUpMenuMore(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Image.asset(
                'assets/images/refer.png'
                //
                ,
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "refer".tr,
                style: Theme.of(context).textTheme.headline3!.copyWith(
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
                                  onChanged: controller.filterUser,
                                ))),
                        const SizedBox(
                          width: 2,
                        ),
                        CustomButtonWithIcon(
                            icon: Icons.person,
                            onClick: () {
                              controller.listOfUser(0);
                            }),
                        const SizedBox(
                          width: 2,
                        ),
                        CustomButtonWithIcon(
                            icon: Icons.account_balance,
                            onClick: () {
                              controller.listOfUser(1);
                            }),
                        const SizedBox(
                          width: 2,
                        ),
                        CustomButtonWithIcon(
                            icon: Icons.person,
                            onClick: () {
                              controller.listOfUser(2);
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("referTo".tr),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                                child: GetBuilder<DocumentController>(
                              autoRemove: false,
                              assignId: true, //tag: "alluser",
                              builder: (logic) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.users.length,
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
                                              if (!controller.usersWillSendTo
                                                  .contains(logic.users[pos])) {
                                                controller.addTousersWillSendTo(
                                                    user: logic.users[pos]);
                                                controller
                                                    .SetMultipleReplyWithVoiceNoteRequestModel(
                                                        correspondencesId:
                                                            controller
                                                                .correspondences
                                                                .correspondenceId!,
                                                        transferId: controller
                                                            .correspondences
                                                            .transferId!,
                                                        id: logic
                                                            .users[pos].id!);
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
                                                                "${a?[0][0]} ${a?[0][0] ?? ""}"))),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 2.0,
                                                              bottom: 2,
                                                              right: 8,
                                                              left: 8),
                                                      child: Text(
                                                        logic.users[pos]
                                                                .value ??
                                                            "",
                                                        maxLines: 3,
                                                        softWrap: true,
                                                      )),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: const Icon(Icons.clear),
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          );
        });
  }

  final List<_HomeItem> items = List.generate(
    5,
    (i) => _HomeItem(
      i,
      'Tile n°$i',
    ),
  );

  _popUpExportG2GDocument(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(""),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .8,
              child: GetBuilder<DocumentController>(
                  autoRemove: false,
                  builder: (logic) {
                    return SingleChildScrollView(
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text("to".tr)),
                            Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 150,
                                            child: Text("جهة رئيسية")),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: TypeAheadField<Parents>(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              controller: controller
                                                  .textEditingControllerToParent,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'To'),
                                            ),
                                            suggestionsCallback:
                                                (pattern) async {
                                              return controller
                                                  .g2gInfoForExportModel!
                                                  .parents!
                                                  .where(
                                                (element) => element.parentName!
                                                    .toLowerCase()
                                                    .contains(
                                                      pattern.toLowerCase(),
                                                    ),
                                              );
                                            },
                                            itemBuilder: (context, suggestion) {
                                              Parents v = suggestion;
                                              return // Te(v.originalName!);

                                                  ListTile(
                                                title:
                                                    FilterText(v.parentName!),
                                              );
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              Parents v = suggestion;
                                              controller.toParent = v;
                                              controller
                                                  .textEditingControllerToParent
                                                  .text = v.parentName!;
                                              // v
                                              // .cLASNAMEDISPLAY;
                                              // Navigator.of(context).push(MaterialPageRoute(
                                              //     builder: (context) => ProductPage(product: suggestion)
                                              // ));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            width: 150,
                                            child: Text("جهة فرعية")),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: DropdownButton<DepartmentList>(
                                            // value: dropdownValue,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,

                                            underline: Container(
                                              height: 2,
                                            ),
                                            onChanged:
                                                (DepartmentList? newValue) {
                                              controller.addtoDepartmentList(
                                                  department: newValue!);
                                            },
                                            items: controller
                                                .g2gInfoForExportModel
                                                ?.departmentList!
                                                .map<
                                                        DropdownMenuItem<
                                                            DepartmentList>>(
                                                    (DepartmentList value) {
                                                  return DropdownMenuItem<
                                                      DepartmentList>(
                                                    value: value,
                                                    child:
                                                        Text(value.childName!),
                                                  );
                                                })
                                                .toList()
                                                .where((element) =>
                                                    element.value?.parentGeid ==
                                                    controller
                                                        .toParent?.parentGeid)
                                                .toList(),
                                          ),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 150,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            // width: 400,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1)),
                                            child: ListView.builder(
                                                itemCount: controller
                                                    .toDepartmentList.length,
                                                itemBuilder: (context, pos) {
                                                  return Text(controller
                                                      .toDepartmentList[pos]
                                                      .childName!);
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text("نسخة الي")),
                            Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 150,
                                            child: Text("جهة رئيسية")),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: TypeAheadField<Parents>(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              controller: controller
                                                  .textEditingControllerToccParent,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'To'),
                                            ),
                                            suggestionsCallback:
                                                (pattern) async {
                                              return controller
                                                  .g2gInfoForExportModel!
                                                  .parents!
                                                  .where((element) => element
                                                      .parentName!
                                                      .toLowerCase()
                                                      .contains(pattern
                                                          .toLowerCase()));
                                            },
                                            itemBuilder: (context, suggestion) {
                                              Parents v = suggestion;

                                              return // Te(v.originalName!);

                                                  ListTile(
                                                title:
                                                    FilterText(v.parentName!),
                                              );
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              Parents v = suggestion;
                                              controller.ccToParent = v;
                                              controller
                                                  .textEditingControllerToccParent
                                                  .text = v.parentName!;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            width: 150,
                                            child: Text("جهة فرعية")),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: DropdownButton<DepartmentList>(
                                            // value: dropdownValue,
                                            icon: const Icon(
                                                Icons.arrow_downward),
                                            elevation: 16,

                                            underline: Container(
                                              height: 2,
                                            ),
                                            onChanged:
                                                (DepartmentList? newValue) {
                                              controller.addcctoDepartmentList(
                                                  department: newValue!);
                                            },
                                            items: controller
                                                .g2gInfoForExportModel
                                                ?.departmentList!
                                                .map<
                                                        DropdownMenuItem<
                                                            DepartmentList>>(
                                                    (DepartmentList value) {
                                                  return DropdownMenuItem<
                                                      DepartmentList>(
                                                    value: value,
                                                    child:
                                                        Text(value.childName!),
                                                  );
                                                })
                                                .toList()
                                                .where((element) =>
                                                    element.value?.parentGeid ==
                                                    controller
                                                        .toParent?.parentGeid)
                                                .toList(),
                                          ),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 150,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          height: 100,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: ListView.builder(
                                              itemCount: controller
                                                  .cctoDepartmentList.length,
                                              itemBuilder: (context, pos) {
                                                return Text(controller
                                                    .cctoDepartmentList[pos]
                                                    .childName!);
                                              }),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text("الملاحظات")),
                            Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(width: 150, child: Text(" ")),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 1)),
                                                child: TextField(
                                                  maxLines: 6,
                                                  controller: controller
                                                      .textEditingControllerG2gNotes,
                                                ))),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text("المرفقات")),
                            Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(width: 150, child: Text(" ")),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 150,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1)),
                                            child: ListView.builder(
                                                itemCount: controller
                                                    .g2gInfoForExportModel
                                                    ?.attachments!
                                                    .length,
                                                itemBuilder: (context, pos) {
                                                  // return Tile(items![pos], controller.deleteItem);
                                                  return Tile(
                                                      controller
                                                          .g2gInfoForExportModel!
                                                          .attachments![pos],
                                                      controller.deleteItem);
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ]),
                    );
                  }),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  print(controller.textEditingControllerG2gNotes.text);
                  controller.exportUsingG2g(
                      context: context,
                      notes: controller.textEditingControllerG2gNotes.text);
                  Navigator.pop(context, true);
                },
                child: Text("ارسال"),
              ),
            ],
          );
        });
  }
}

class Tile extends StatefulWidget {
  // final DocModel.AttachmentsList item;
  final AttachmentsG2gInfoExport item;
  final Function delete;

  Tile(this.item, this.delete);

  @override
  State<StatefulWidget> createState() => _TileState(item, delete);
}

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

class _TileState extends State<Tile> {
  // final DocModel.AttachmentsList item;
  final AttachmentsG2gInfoExport item;
  final Function delete;

  _TileState(this.item, this.delete);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                // Navigator.pop(context,true);
                print("leading");
                delete(item);
              }), // for Right
          // trailing: Icon(Icons.close),  // for Left
          key: ValueKey(item.FileKey),
          title: Text("${item.FileName}"),
          // subtitle: Text("${item.fonam}"),
          // onTap: () => delete(item),
        ),
        Divider(), //                           <-- Divider
      ],
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
