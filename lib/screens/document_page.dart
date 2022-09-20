import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cts/models/DocumentModel.dart';
import 'package:cts/screens/resize_sing.dart';
import 'package:cts/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:get/get.dart';
import 'package:signature/signature.dart';

//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/web_view_controller.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';
import '../services/json_model/inopendocModel/g2g/g2g_export_dto.dart';
import '../services/json_model/inopendocModel/save_document_annotation_model.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../viewer/controllers/viewerController.dart';
import '../viewer/pdfview.dart';
import '../viewer/static/AnnotationTypes.dart';
import '../widgets/Custom_button_with_image.dart';
import '../widgets/custom_button_with_icon.dart';
import '../widgets/custom_side_button_menu.dart';
import 'dart:developer';
import 'package:cts/models/DocumentModel.dart' as DocModel;

class DocumentPage extends GetWidget<DocumentController> {
  bool portraitIsActive = false;
  List<Widget> list = [];

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
                    : _buildBody(context),
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
          onPressed: () {
            showExportDialog(context);
          },
          icon: const Icon(Icons.upload),
        ),
        ActionButton(
          onPressed: () => completeClick(context),
          icon: const Icon(Icons.archive),
        ),
        ActionButton(
          onPressed: () => clickOnSign(context),
          icon: const Icon(Icons.edit),
        ),
        ActionButton(
          onPressed: () => _popUpMenu(context),
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
            .copyWith(color: Colors.white, fontSize: 25),
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
  _buildBody(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    var v = controller.correspondences.toJson();
    log(v.toString());
    Size s = Size(size.width, size.height - 150);
    var documentViewer = GetBuilder<DocumentController>(
        autoRemove: false,
        builder: (logic) {
          return SizedBox(
            width: size.width,
            height: size.height - 199,
            child: Container(
              color: Colors.amber,
              child: controller.pdfAndSingData.length > 0
                  ? PDFView(
                      url: controller.pdfAndSingData.first,
                      color: Get.find<MController>().appcolor,
                      size: s)
                  : CircularProgressIndicator.adaptive(),
            ),
          );
        });
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //  mainAxisSize: MainAxisSize.max,
      children: [
        // _buildTopBar(context),
        GetBuilder<DocumentController>(
          //autoRemove: false,
          autoRemove: false,
          builder: (logic) {
            var singleChildScrollView = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    width: 4,
                    height: 50,
                  ),

                  InkWell(
                    onTap: () {
                      _popUpMenu(context);
                    },
                    child: CustomButtonWithImage(
                      //onClick: () {},
                      image: 'assets/images/refer.png',
                      label: "refer".tr,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey[800],
                  ),
                  PopupMenuButton(
                    elevation: 4,
                    child: CustomButtonWithImage(
                      image: 'assets/images/up_arrow.png',
                      label: "export".tr,
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text("paperExport".tr),
                          onTap: () {
                            controller.getIsAlreadyExportedAsPaperwork(
                                context: context,
                                correspondenceId: controller
                                    .correspondences.correspondenceId!,
                                transferId:
                                    controller.correspondences.transferId!,
                                exportAction: "paper");
                          },
                        ),
                        PopupMenuItem(
                          child: Text("electronicExport".tr),
                          onTap: () {
                            controller.isAlreadyExportedAsTransfer(
                                context: context,
                                correspondenceId: controller
                                    .correspondences.correspondenceId!,
                                transferId:
                                    controller.correspondences.transferId!,
                                exportAction: "electronic");
                            print("electronicExport");
                          },
                        ),
                        PopupMenuItem(
                          child: Text("paperAndElectronicExport".tr),
                          onTap: () {
                            controller.isAlreadyExportedAsTransfer(
                                context: context,
                                correspondenceId: controller
                                    .correspondences.correspondenceId!,
                                transferId:
                                    controller.correspondences.transferId!,
                                exportAction: "paperAndelectronic");
                            print("paperAndElectronicExport");
                          },
                        ),
                      ];
                    },
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey[800],
                  ),
                  GestureDetector(
                    child: CustomButtonWithImage(
                      // onClick: () {},
                      image: 'assets/images/ending.png',
                      label: "ending".tr,
                    ),
                    onTap: () {
                      print("ending");
                      // showLoaderDialog(context);
                      completeClick(context);
                    },
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey[800],
                  ),
                  GestureDetector(
                    child: CustomButtonWithImage(
                      // onClick: () {},
                      label: "marking".tr,
                      image: 'assets/images/A.png',
                    ),
                    onTap: () async {
                      String url =
                          "https://intaliocom-my.sharepoint.com/:w:/r/personal/izzat_hajj_intalio_com/_layouts/15/Doc.aspx?sourcedoc=%7B433EEEF0-A155-4F05-B1BF-B9FBEEF77575%7D&file=5833639______%20____%20____%20(1).docx&action=default&mobileredirect=true";
                      final Uri toLaunch =
                          Uri.parse("ms-word:ofe|u|$url|a|App");

                      final bool nativeAppLaunchSucceeded = await launchUrl(
                        toLaunch,
                        mode: LaunchMode.externalApplication,
                      );
                      print("was able to launch ? $nativeAppLaunchSucceeded");
                    },
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey[800],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.find<WebViewPageController>().isPdf = false;
                      print(controller.correspondences.gridInfo![2].value);
                      var ref = controller.correspondences.gridInfo![2].value;
                      if (ref != null && ref != "")
                        Get.find<WebViewPageController>().title = ref;
                      else
                        Get.find<WebViewPageController>().title = "tracking".tr;
                      Get.find<WebViewPageController>().url = controller
                          .canOpenDocumentModel
                          ?.correspondence!
                          .visualTrackingUrl!;
                      Get.toNamed(
                        "WebViewPage",
                      );
                    },
                    child: CustomButtonWithImage(
                      // onClick: () {},
                      image: 'assets/images/track.png',
                      label: "tracking".tr,
                    ),
                  ),
                  // Container(
                  //   height: 30,
                  //   width: 1,
                  //   color: Colors.grey[800],
                  // ),
                  // CustomButtonWithImage(
                  //   //    onClick: () {},
                  //   image: 'assets/images/referrals.png',
                  //   label: "referrals".tr,
                  // ),
                  // Container(
                  //   height: 30,
                  //   width: 1,
                  //   color: Colors.grey[800],
                  // ),
                  if (controller.notoragnalFileDoc)
                    GestureDetector(
                      onTap: () {
                        controller.backTooragnalFileDocpdf();
                      },
                      child: Icon(
                        Icons.home,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            );
            return singleChildScrollView;
          },
        ),

        //ACTIONS

        documentViewer
      ],
    );
  }

  Expanded _MetadataSideMenu(BuildContext context) {
    return Expanded(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "data".tr,
                            ),
                            Image.asset(
                              'assets/images/metadata.png',
                              height: 20,
                              width: 20,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),

                        Wrap(
                          // mainAxisAlignment:
                          //     MainAxisAlignment
                          //         .spaceAround,
                          children: [
                            if (controller.correspondences.priorityId == "1")
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.warning, color: RedColor),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          if (controller
                                                  .correspondences.priorityId ==
                                              "1")
                                            Text(
                                              "veryimportant".tr,
                                              style: TextStyle(color: RedColor),
                                            ),
                                        ]),
                                  ),
                                ),
                              ),

                            if (controller.correspondences.showLock ?? false)
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.lock),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text("secret".tr),
                                        ]),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 4,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            controller.correspondences.isLocked!
                                                ? Icons.lock
                                                : Icons.lock_open,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        if (controller
                                                .correspondences.isLocked ??
                                            false)
                                          Text("closed".tr,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary)),
                                      ]),
                                ),
                              ),
                            ),

                            //   correspondences[pos].priorityId
                            //  correspondences[pos].purposeId

                            // Text("sender".tr),
                            // SizedBox(
                            //   width: 4,
                            // ),
                            // Text(
                            //     correspondences[pos]
                            //         .fromUser ??
                            //         ""),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        _itemSideMenu(
                            context: context,
                            title: "title".tr,
                            data:
                                controller.correspondences.gridInfo![0].value ??
                                    ""),
                        SizedBox(
                          height: 8,
                        ),
                        _itemSideMenu(
                            context: context,
                            title: "sender1".tr,
                            data: controller.correspondences.fromUser ?? ""),
                        SizedBox(
                          height: 8,
                        ),
                        _itemSideMenu(
                            context: context,
                            title: "assignedFrom".tr,
                            data:
                                controller.correspondences.metadata![3].value!),
                        SizedBox(
                          height: 8,
                        ),
                        _itemSideMenu(
                            context: context,
                            title: "referDate".tr,
                            data:
                                controller.correspondences.gridInfo![3].value!),
                        SizedBox(
                          height: 8,
                        ),

                        //    if(controller!.canOpenDocumentModel?.attachments?.hasVoice??false)
                        Text("assignmentNotes".tr),
                        // if(controller!.canOpenDocumentModel?.attachments?.hasVoice??false)
                        //  Text(controller.correspondences.comments ?? ""),
                        Text(controller.canOpenDocumentModel?.correspondence
                                ?.comments ??
                            ""),

                        if (controller
                                .canOpenDocumentModel?.attachments?.hasVoice ??
                            false)
                          Container(
                              height: 40,
                              color: Colors.grey[300],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        print("object");

                                        /// هنشغل ملف الصوت هنا
                                        FlutterSoundPlayer audioPlayer =
                                            FlutterSoundPlayer();

                                        audioPlayer!.openPlayer();
                                        String filePath =
                                            await createFileFromString(
                                                controller.canOpenDocumentModel
                                                    ?.attachments?.voiceNote);

                                        print(filePath);
                                        await audioPlayer!
                                            .startPlayer(fromURI: filePath);
                                      },
                                      child: Icon(Icons.play_arrow,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  )
                                ],
                              )),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<dynamic> completeClick(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(" "),
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
            onPressed: () {
              print(Get.find<InboxController>().completeCustomActions?.name);
              print(Get.find<InboxController>().completeCustomActions?.icon);

              String data =
                  'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${controller.canOpenDocumentModel!.correspondence!.correspondenceId}&transferId=${controller.canOpenDocumentModel!.correspondence!.transferId}&actionType=Complete&note=${Get.find<InboxController>().completeNote}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';

              Navigator.of(ctx).pop();
              showLoaderDialog(context);
              Get.find<InboxController>()
                  .completeInCorrespondence(context: context, data: data);
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<void> clickOnSign(BuildContext context) async {
    print("object");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(" "),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .5,
            color: Colors.grey[200],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 300,
                      width: double.infinity,
                      child: Signature(
                        controller: controller.controller,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.controller.clear();
                          },
                          child: Icon(
                            Icons.clear,
                            size: 50,
                          )),
                      InkWell(
                          onTap: () async {
                            //     ViewerController.to.prepareToAddAnnotationOnTap(
                            //     AnnotationBaseTypes.signature);
                            final key = GlobalKey();

                            final Uint8List? data =
                                await controller.controller.toPngBytes();
                            ViewerController.to
                                .prepareToAddSignatureAnnotationOnTap(
                                    Image.memory(
                              data!,
                              fit: BoxFit.fill,
                              key: key,
                              width: 100,
                              height: 100,
                            ));

                            Get.back();
                          },
                          child: Icon(
                            Icons.save,
                            size: 50,
                          )),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Expanded(
                    child: GetBuilder<DocumentController>(
                      assignId: true,
                      autoRemove: false,
                      builder: (logic) {
                        return GridView.builder(
                          itemCount: controller.multiSignatures.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                final key = GlobalKey();

                                final Uint8List? data =
                                    await controller.controller.toPngBytes();
                                ViewerController.to
                                    .prepareToAddSignatureAnnotationOnTap(
                                        Image.memory(
                                  data!,
                                  fit: BoxFit.fill,
                                  key: key,
                                  width: 100,
                                  height: 100,
                                ));
                                Get.back();
                              },
                              child: Image.memory(dataFromBase64String(
                                  controller.multiSignatures[index].signature)),
                            );
                          },
                        );
                      },
                    ),
                  )
                ]),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Ok"),
          ),
        ],
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

  _buildTopBar(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(10),
        height: 100,
        width: size.width,
        color: Get.find<MController>().appcolor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "appTitle".tr,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.start,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                'assets/images/menu.png',
                height: 50,
                width: 50,
              ),
            ),
          ],
        ));
  }

  _popUpMenu(context) async {
    await controller.listFavoriteRecipients(context: context);
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
                                                              ///
                                                              ///
                                                              ///
                                                              // controller.canOpenDocumentModel.correspondence.docDueDate
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
                                                            child: InkWell(
                                                              onTap: () {
                                                                controller.playMathod(
                                                                    id: logic
                                                                        .usersWillSendTo[
                                                                            pos]
                                                                        .id);
                                                              },
                                                              child: Icon(Icons
                                                                  .play_arrow),
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
                },
                child: Text("Ok"),
              ),
            ],
          );
        });

    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) => CupertinoAlertDialog(
    //           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //             Image.asset(
    //               'assets/images/refer.png'
    //               //
    //               ,
    //               height: 20,
    //               width: 20,
    //             ),
    //             const SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "refer".tr,
    //               style: Theme.of(context).textTheme.headline3!.copyWith(
    //                     color: createMaterialColor(
    //                       const Color.fromRGBO(77, 77, 77, 1),
    //                     ),
    //                     fontSize: 15,
    //                   ),
    //               textAlign: TextAlign.center,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             const Spacer(),
    //             Image.asset(
    //               'assets/images/close_button.png',
    //               width: 20,
    //               height: 20,
    //             ),
    //           ]),
    //           content: Container(width: MediaQuery.of(context).size.width*.8,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Text("referTo".tr),
    //                   Container(
    //                       height: 100,
    //                       child: Row(
    //                         children: [
    //
    //                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,pos){
    //                        return Container(
    //                          height: 30,
    //                          width: 30,
    //                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
    //                        );
    //                      }))  , Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               height: 30,
    //                               width: 30,
    //                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
    //                             ),
    //                           ), ],
    //                       ))
    //                 ]),
    //           ),
    //           actions: [],
    //         ));
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
                                                      )

                                                      //
                                                      // Container(
                                                      //   height: 50,
                                                      //   width: 50,
                                                      //   decoration: const BoxDecoration(
                                                      //       shape: BoxShape.circle,
                                                      //       color: Colors.green),
                                                      // ),
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
                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width * .8,
                    //     height: 300, // MediaQuery.of(context).size.height * .5,
                    //     child: GetBuilder<DocumentController>(
                    //       //   assignId: true,//tag: "user",
                    //       builder: (logic) {
                    //         return //Text(logic.filterWord);
                    //
                    //             ListView.builder(
                    //                 scrollDirection: Axis.vertical,
                    //                 itemCount:
                    //                     controller.usersWillSendTo.length,
                    //                 itemBuilder: (context, pos) {
                    //                   return //Text(controller.filterWord);
                    //
                    //                       Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Container(
                    //                       color: Colors.grey[200],
                    //                       child: Column(children: [
                    //                         Row(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.center,
                    //                             children: [
                    //                               Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: Text(logic
                    //                                         .usersWillSendTo[
                    //                                             pos]
                    //                                         .value ??
                    //                                     ""),
                    //                                 // child: Container(
                    //                                 //   height: 50,
                    //                                 //   width: 50,
                    //                                 //   // decoration: const BoxDecoration(
                    //                                 //   //   shape: BoxShape.circle,
                    //                                 //   //   color: Colors.grey,
                    //                                 //   // ),
                    //                                 // ),
                    //                               ),
                    //                               SizedBox(
                    //                                 width: 8,
                    //                               ),
                    //                               Text(
                    //                                 "name",
                    //                                 style: Theme.of(context)
                    //                                     .textTheme
                    //                                     .headline3!
                    //                                     .copyWith(
                    //                                       color:
                    //                                           createMaterialColor(
                    //                                         const Color
                    //                                                 .fromRGBO(
                    //                                             77, 77, 77, 1),
                    //                                       ),
                    //                                       fontSize: 15,
                    //                                     ),
                    //                                 textAlign: TextAlign.center,
                    //                                 overflow:
                    //                                     TextOverflow.ellipsis,
                    //                               ),
                    //                               Spacer(),
                    //                               GestureDetector(
                    //                                 onTap: () {
                    //                                   print(
                    //                                       "i deeeeeeeeeeeeeeeeeeeeeeee");
                    //                                   controller.transfarForMany
                    //                                       .remove(logic
                    //                                           .usersWillSendTo[
                    //                                               pos]
                    //                                           .id);
                    //                                   logic.delTousersWillSendTo(
                    //                                       user: logic
                    //                                               .usersWillSendTo[
                    //                                           pos]);
                    //                                 },
                    //                                 child: Image.asset(
                    //                                   'assets/images/close_button.png',
                    //                                   width: 20,
                    //                                   height: 20,
                    //                                 ),
                    //                               ),
                    //                             ]),
                    //                         SizedBox(
                    //                           height: 4,
                    //                         ),
                    //                         Row(
                    //                           children: [
                    //                             Expanded(
                    //                               child: Text("action".tr),
                    //                             ),
                    //                             SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             Expanded(
                    //                               child: Text("audioNotes".tr),
                    //                             )
                    //                           ],
                    //                         ),
                    //                         Row(
                    //                           children: [
                    //                             Expanded(
                    //                               child: Container(
                    //                                 height: 40,
                    //                                 color: Colors.grey[300],
                    //                                 child: DropdownButton<
                    //                                     CustomActions>(
                    //                                   alignment:
                    //                                       Alignment.topRight,
                    //                                   value: logic.getactions(
                    //                                       logic
                    //                                           .usersWillSendTo[
                    //                                               pos]
                    //                                           .id),
                    //                                   icon: const Icon(
                    //                                       Icons.arrow_downward),
                    //                                   elevation: 16,
                    //                                   style: const TextStyle(
                    //                                       color: Colors
                    //                                           .deepPurple),
                    //                                   underline: Container(
                    //                                     height: 2,
                    //                                     color: Colors
                    //                                         .deepPurpleAccent,
                    //                                   ),
                    //                                   hint: Text("اختار"),
                    //                                   onChanged: (CustomActions?
                    //                                       newValue) {
                    //                                     controller.setactions(
                    //                                         logic
                    //                                             .usersWillSendTo[
                    //                                                 pos]
                    //                                             .id,
                    //                                         newValue!);
                    //                                     //  dropdownValue = newValue!;
                    //                                   },
                    //                                   items: controller
                    //                                       .customActions
                    //                                       ?.map<
                    //                                               DropdownMenuItem<
                    //                                                   CustomActions>>(
                    //                                           (CustomActions
                    //                                               value) {
                    //                                     return DropdownMenuItem<
                    //                                         CustomActions>(
                    //                                       value: value,
                    //                                       child:
                    //                                           Text(value.name!),
                    //                                     );
                    //                                   }).toList(),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             const SizedBox(
                    //                               width: 10,
                    //                             ),
                    //                             Expanded(
                    //                               child: Container(
                    //                                   height: 40,
                    //                                   color: Colors.grey[300],
                    //                                   child: Row(
                    //                                     mainAxisAlignment:
                    //                                         MainAxisAlignment
                    //                                             .spaceBetween,
                    //                                     children: [
                    //                                       GestureDetector(
                    //                                         onTap: () async {
                    //                                           ///To Do Start and stop rec
                    //                                           controller
                    //                                                   .recording
                    //                                               ? controller.stopForMany(
                    //                                                   id: logic
                    //                                                       .usersWillSendTo[
                    //                                                           pos]
                    //                                                       .id!)
                    //                                               : controller
                    //                                                   .recordForMany();
                    //                                         },
                    //                                         child: Padding(
                    //                                           padding:
                    //                                               const EdgeInsets
                    //                                                   .all(8.0),
                    //                                           child: GetBuilder<
                    //                                                   DocumentController>(
                    //                                               builder:
                    //                                                   (logic) {
                    //                                             return Icon(controller
                    //                                                     .recording
                    //                                                 ? Icons.stop
                    //                                                 : Icons
                    //                                                     .mic);
                    //                                           }),
                    //                                         ),
                    //                                       ),
                    //                                       Padding(
                    //                                         padding:
                    //                                             const EdgeInsets
                    //                                                 .all(8.0),
                    //                                         child: InkWell(
                    //                                           onTap: () {
                    //                                             controller
                    //                                                 .playRec();
                    //                                           },
                    //                                           child: Icon(Icons
                    //                                               .play_arrow),
                    //                                         ),
                    //                                       )
                    //                                     ],
                    //                                   )),
                    //                             )
                    //                           ],
                    //                         ),
                    //                         SizedBox(
                    //                           height: 8,
                    //                         ),
                    //                         Container(
                    //                           child: TextFormField(
                    //                             onChanged: (v) {
                    //                               controller.setNots(
                    //                                   id: logic
                    //                                       .usersWillSendTo[pos]
                    //                                       .id!,
                    //                                   not: v);
                    //                             },
                    //                             maxLines: 4,
                    //                           ),
                    //                           color: Colors.grey[300],
                    //                         ),
                    //                         SizedBox(
                    //                           height: 8,
                    //                         ),
                    //                       ]),
                    //                     ),
                    //                   );
                    //                 });
                    //       },
                    //     ))
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

    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) => CupertinoAlertDialog(
    //           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //             Image.asset(
    //               'assets/images/refer.png'
    //               //
    //               ,
    //               height: 20,
    //               width: 20,
    //             ),
    //             const SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "refer".tr,
    //               style: Theme.of(context).textTheme.headline3!.copyWith(
    //                     color: createMaterialColor(
    //                       const Color.fromRGBO(77, 77, 77, 1),
    //                     ),
    //                     fontSize: 15,
    //                   ),
    //               textAlign: TextAlign.center,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             const Spacer(),
    //             Image.asset(
    //               'assets/images/close_button.png',
    //               width: 20,
    //               height: 20,
    //             ),
    //           ]),
    //           content: Container(width: MediaQuery.of(context).size.width*.8,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Text("referTo".tr),
    //                   Container(
    //                       height: 100,
    //                       child: Row(
    //                         children: [
    //
    //                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,pos){
    //                        return Container(
    //                          height: 30,
    //                          width: 30,
    //                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
    //                        );
    //                      }))  , Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               height: 30,
    //                               width: 30,
    //                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
    //                             ),
    //                           ), ],
    //                       ))
    //                 ]),
    //           ),
    //           actions: [],
    //         ));
  }

  _popUpMenuhasAttachments(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          print(
              " Get.find<DocumentController>() .canOpenDocumentModel?.attachments?.attachments?.length=>${Get.find<DocumentController>().canOpenDocumentModel?.attachments?.attachments?.length}");
          return AlertDialog(
            title: Text("Attachments"),
            content: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width * .7,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.folder2.length,
                  itemBuilder: (context, pos) {
                    String key = controller.folder2.keys.elementAt(pos);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  color: Theme.of(context).colorScheme.primary,
                                  child: Text(key)),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: controller.folder2[key]!.length,
                                  itemBuilder: (context, indx) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Get.find<DocumentController>()
                                          //     .getAttachmentItemlocal(
                                          //     context: context);
                                          controller.getAttachmentItem(
                                              context: context,
                                              transferId: controller
                                                  .folder2[key]![pos]
                                                  .transferId,
                                              attachmentId: controller
                                                  .folder2[key]![pos]
                                                  .attachmentId,
                                              documentId: controller
                                                  .folder2[key]![pos].docId);

                                          Get.back();
                                          //  _popShowAttachments(context);
                                        },
                                        child: Text(controller
                                            .folder2[key]![indx].fileName!),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                    // return GestureDetector(onTap: (){
                    //   _popShowAttachments(context);
                    // },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Card(
                    //         elevation: 8,
                    //         child: Column(
                    //           children: [
                    //             Container(child: Text(),)
                    //             Expanded(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: Text(Get.find<DocumentController>() .canOpenDocumentModel?.attachments?.attachments?[pos].fileName??""),
                    //                 ))
                    //           ],
                    //         )),
                    //   ),
                    // );
                  }),
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

    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) => CupertinoAlertDialog(
    //           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //             Image.asset(
    //               'assets/images/refer.png'
    //               //
    //               ,
    //               height: 20,
    //               width: 20,
    //             ),
    //             const SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "refer".tr,
    //               style: Theme.of(context).textTheme.headline3!.copyWith(
    //                     color: createMaterialColor(
    //                       const Color.fromRGBO(77, 77, 77, 1),
    //                     ),
    //                     fontSize: 15,
    //                   ),
    //               textAlign: TextAlign.center,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             const Spacer(),
    //             Image.asset(
    //               'assets/images/close_button.png',
    //               width: 20,
    //               height: 20,
    //             ),
    //           ]),
    //           content: Container(width: MediaQuery.of(context).size.width*.8,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Text("referTo".tr),
    //                   Container(
    //                       height: 100,
    //                       child: Row(
    //                         children: [
    //
    //                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,pos){
    //                        return Container(
    //                          height: 30,
    //                          width: 30,
    //                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
    //                        );
    //                      }))  , Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               height: 30,
    //                               width: 30,
    //                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
    //                             ),
    //                           ), ],
    //                       ))
    //                 ]),
    //           ),
    //           actions: [],
    //         ));
  }

  _popShowAttachments(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Attachments"),
            content: SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                width: MediaQuery.of(context).size.width * .7,
                child: SfPdfViewer.network(
                    'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')),
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

    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) => CupertinoAlertDialog(
    //           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //             Image.asset(
    //               'assets/images/refer.png'
    //               //
    //               ,
    //               height: 20,
    //               width: 20,
    //             ),
    //             const SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "refer".tr,
    //               style: Theme.of(context).textTheme.headline3!.copyWith(
    //                     color: createMaterialColor(
    //                       const Color.fromRGBO(77, 77, 77, 1),
    //                     ),
    //                     fontSize: 15,
    //                   ),
    //               textAlign: TextAlign.center,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             const Spacer(),
    //             Image.asset(
    //               'assets/images/close_button.png',
    //               width: 20,
    //               height: 20,
    //             ),
    //           ]),
    //           content: Container(width: MediaQuery.of(context).size.width*.8,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Text("referTo".tr),
    //                   Container(
    //                       height: 100,
    //                       child: Row(
    //                         children: [
    //
    //                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,pos){
    //                        return Container(
    //                          height: 30,
    //                          width: 30,
    //                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
    //                        );
    //                      }))  , Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               height: 30,
    //                               width: 30,
    //                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
    //                             ),
    //                           ), ],
    //                       ))
    //                 ]),
    //           ),
    //           actions: [],
    //         ));
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
                                              // autofocus: true,
                                              // style: DefaultTextStyle.of(context)
                                              //     .style
                                              //     .copyWith(fontStyle: FontStyle.italic),
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

                                              //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
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
                        // Container(height: 150,
                        //   decoration: BoxDecoration(
                        //       border: Border.all(width: 1)),
                        //   child:
                        //
                        //   ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: controller.toDepartmentList.length,
                        //       itemBuilder: (context, pos) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Card(
                        //               elevation: 8,
                        //               child: Column(
                        //                 children: [
                        //                 Text(controller.toDepartmentList[pos].parentName!)
                        //                 ],
                        //               )),
                        //         );
                        //       }),
                        //
                        //
                        //
                        //
                        // ),
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
                                              // autofocus: true,
                                              // style: DefaultTextStyle.of(context)
                                              //     .style
                                              //     .copyWith(fontStyle: FontStyle.italic),
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

                                              //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
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
                        // Container(height: 150,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: controller.cctoDepartmentList.length,
                        //       itemBuilder: (context, pos) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Card(
                        //               elevation: 8,
                        //               child: Column(
                        //                 children: [
                        //                   Text(controller.cctoDepartmentList[pos].parentName!)
                        //                 ],
                        //               )),
                        //         );
                        //       }),
                        // ),
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
                                            child:
                                                // Text(
                                                //     "${controller.g2gInfoForExportModel?.attachments!.length}"
                                                //     // "Ahmed "
                                                // )
                                                ListView.builder(
                                                    // scrollDirection: Axis.horizontal,
                                                    //   itemCount: 1,
                                                    itemCount: controller
                                                        .g2gInfoForExportModel
                                                        ?.attachments!
                                                        .length,
                                                    itemBuilder:
                                                        (context, pos) {
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

    // showCupertinoDialog(
    //     context: context,
    //     builder: (context) => CupertinoAlertDialog(
    //           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //             Image.asset(
    //               'assets/images/refer.png'
    //               //
    //               ,
    //               height: 20,
    //               width: 20,
    //             ),
    //             const SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "refer".tr,
    //               style: Theme.of(context).textTheme.headline3!.copyWith(
    //                     color: createMaterialColor(
    //                       const Color.fromRGBO(77, 77, 77, 1),
    //                     ),
    //                     fontSize: 15,
    //                   ),
    //               textAlign: TextAlign.center,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             const Spacer(),
    //             Image.asset(
    //               'assets/images/close_button.png',
    //               width: 20,
    //               height: 20,
    //             ),
    //           ]),
    //           content: Container(width: MediaQuery.of(context).size.width*.8,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Text("referTo".tr),
    //                   Container(
    //                       height: 100,
    //                       child: Row(
    //                         children: [
    //
    //                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,pos){
    //                        return Container(
    //                          height: 30,
    //                          width: 30,
    //                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
    //                        );
    //                      }))  , Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               height: 30,
    //                               width: 30,
    //                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
    //                             ),
    //                           ), ],
    //                       ))
    //                 ]),
    //           ),
    //           actions: [],
    //         ));
  }
}

//
// Column(
// children: [
// Container(height: 300,
// width: double.infinity,
// child: Signature(controller: controller.controller,)),
// Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
// InkWell(onTap: () {
// controller.controller.clear();
// }, child: Icon(Icons.clear,size: 50,)),
// InkWell(onTap: () {}, child: Icon(Icons.save,size: 50,)),
// ],),
// Divider(color: Colors.grey)
// , Expanded(
// child: GetBuilder<SignaturePageController>(
// assignId: true,
// builder: (logic) {
// return ListView.builder(
// itemCount: controller.multiSignatures.length,
// itemBuilder: (context, pos) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Image.memory(dataFromBase64String(controller
//     .multiSignatures[pos].signature)),
// );
// });
// },
// ),
// )
// ],
// )

class Tile extends StatefulWidget {
  // final DocModel.AttachmentsList item;
  final AttachmentsG2gInfoExport item;
  final Function delete;

  Tile(this.item, this.delete);

  @override
  State<StatefulWidget> createState() => _TileState(item, delete);
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
