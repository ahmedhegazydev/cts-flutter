import 'dart:convert';
import 'dart:typed_data';

import 'package:cts/screens/resize_sing.dart';
import 'package:cts/screens/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:signature/signature.dart';

//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/document_controller.dart';
import '../controllers/main_controller.dart';
import '../services/json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';
import '../services/json_model/inopendocModel/save_document_annotation_model.dart';
import '../services/json_model/login_model.dart';
import '../services/models/signature_info.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/utilitie.dart';
import '../widgets/Custom_button_with_image.dart';
import '../widgets/custom_button_with_icon.dart';
import '../widgets/custom_side_button_menu.dart';
import 'dart:developer';

class DocumentPage extends GetWidget<DocumentController> {
  bool portraitIsActive = false;
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildBody(context)));
  }

  /// ToDo get the print
  _buildBody(BuildContext context) {
    Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    Size size = MediaQuery
        .of(context)
        .size;
    // print(controller.correspondences?.toJson())
    // ;
    var v = controller.correspondences.toJson();
    log(v.toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //  mainAxisSize: MainAxisSize.max,
      children: [
        _buildTopBar(context),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                  color: Colors.grey[400],
                  height: 80,
                  width: size.width * .1,
                  child: Center(
                    child: Image.asset(
                      returnImageNameBasedOnDirection(
                          "assets/images/arrow", context, "png"),
                      color: Colors.white,
                      height: 50,
                      width: 50,
                    ),
                  )),
              const SizedBox(
                width: 4,
              ),
              if (controller
                  .canOpenDocumentModel?.correspondence?.hasAttachments ??
                  true)
                InkWell(
                  onTap: () {
                    _popUpMenuhasAttachments(context);
                  },
                  child: CustomButtonWithImage(
                    // onClick: () {},
                    image: 'assets/images/refer.png',
                    label: "hasAttachments".tr,
                  ),
                ),
              InkWell(
                onTap: () {
                  controller.filePickerR();
                },
                child: CustomButtonWithImage(
                  //onClick: () {},
                  image: 'assets/images/refer.png',
                  label: "Add Attachments".tr,
                ),
              ),
              if (controller
                  .canOpenDocumentModel?.correspondence?.hasSummaries ??
                  true)
                InkWell(
                  onTap: () {
                    _popUpExportG2GDocument(context);
                  },
                  child: CustomButtonWithImage(
                    //onClick: () {},
                    image: 'assets/images/refer.png',
                    label: "hasSummaries".tr,
                  ),
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
                              correspondenceId:
                              controller.correspondences.correspondenceId!,
                              transferId:
                              controller.correspondences.transferId!,
                              exportAction: "paper");
                        }),
                    PopupMenuItem(
                        child: Text("electronicExport".tr),
                        onTap: () {
                          controller.getIsAlreadyExportedAsPaperwork(
                              context: context,
                              correspondenceId:
                              controller.correspondences.correspondenceId!,
                              transferId:
                              controller.correspondences.transferId!,
                              exportAction: "electronic");
                          print("electronicExport");
                        }),
                    PopupMenuItem(
                        child: Text("paperAndElectronicExport".tr),
                        onTap: () {
                          controller.getIsAlreadyExportedAsPaperwork(
                              context: context,
                              correspondenceId:
                              controller.correspondences.correspondenceId!,
                              transferId:
                              controller.correspondences.transferId!,
                              exportAction: "paperAndelectronic");
                          print("paperAndElectronicExport");
                        }),
                  ];
                },
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey[800],
              ),
              CustomButtonWithImage(
                // onClick: () {},
                image: 'assets/images/ending.png',
                label: "ending".tr,
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey[800],
              ),
              CustomButtonWithImage(
                // onClick: () {},
                image: 'assets/images/track.png',
                label: "tracking".tr,
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey[800],
              ),
              CustomButtonWithImage(
                //    onClick: () {},
                image: 'assets/images/referrals.png',
                label: "referrals".tr,
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.grey[800],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: size.width,
          color: Colors.grey,
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * .8,
                  width: size.width * .1,
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.max,
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                          ),
                          CustomSideButtonMenu(
                            onClick: () {},
                            label: "comment".tr,
                            image: 'assets/images/comment.png',
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),
                          CustomSideButtonMenu(
                            onClick: () {
                              print("object");
                              showDialog(
                                context: context,
                                builder: (ctx) =>
                                    AlertDialog(
                                      title: Text(" "),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              .5,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              .5,
                                          color: Colors.grey[200],
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 300,
                                                    width: double.infinity,
                                                    child: Signature(
                                                      controller:
                                                      controller.controller,
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          controller.controller
                                                              .clear();
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          size: 50,
                                                        )),
                                                    InkWell(
                                                        onTap: () async {
                                                          final key = GlobalKey();

                                                          final Uint8List? data =
                                                          await controller
                                                              .controller
                                                              .toPngBytes();
                                                          controller
                                                              .addWidgetToPdfAndSing(
                                                              ResizebleWidget(
                                                                child: Image
                                                                    .memory(
                                                                  data!,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  key: key,
                                                                  width: 100,
                                                                  height: 100,
                                                                ),
                                                              ));
                                                          RenderBox? box = key
                                                              .currentContext
                                                              ?.findRenderObject()
                                                          as RenderBox?;

                                                          Offset? pos =
                                                          box?.localToGlobal(
                                                              Offset.zero);

                                                          controller
                                                              .singpic[key] =
                                                              base64.encode(
                                                                  data); //SignatureInfo(offset:pos , signature: 'hguyggyuguy', size: box?.size);

                                                          //
                                                          //
                                                          //
                                                          //
                                                          //
                                                          //

                                                          controller.controller
                                                              .toPngBytes();
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
                                                  child: GetBuilder<
                                                      DocumentController>(
                                                    assignId: true,
                                                    builder: (logic) {
                                                      return GridView.builder(
                                                        itemCount: controller
                                                            .multiSignatures
                                                            .length,
                                                        gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing:
                                                            4.0,
                                                            mainAxisSpacing:
                                                            4.0),
                                                        itemBuilder:
                                                            (
                                                            BuildContext context,
                                                            int index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              final key =
                                                              GlobalKey();
                                                              controller
                                                                  .addWidgetToPdfAndSing(
                                                                  ResizebleWidget(
                                                                    child: Image
                                                                        .memory(
                                                                      dataFromBase64String(
                                                                          controller
                                                                              .multiSignatures[
                                                                          index]
                                                                              .signature),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      key: key,
                                                                    ),
                                                                  ));

                                                              controller
                                                                  .singpic[
                                                              key] =
                                                              controller
                                                                  .multiSignatures[
                                                              index]
                                                                  .signature!;

                                                              Get.back();
                                                            },
                                                            child: Image.memory(
                                                                dataFromBase64String(
                                                                    controller
                                                                        .multiSignatures[
                                                                    index]
                                                                        .signature)),
                                                          );
                                                        },
                                                      );

                                                      // ListView.builder(
                                                      //   itemCount: controller
                                                      //       .multiSignatures
                                                      //       .length,
                                                      //   itemBuilder: (context,
                                                      //       pos) {
                                                      //     return Padding(
                                                      //       padding: const EdgeInsets
                                                      //           .all(8.0),
                                                      //       child:
                                                      //     GestureDetector(
                                                      //         onTap: () {
                                                      //           controller
                                                      //               .addWidgetToPdfAndSing(
                                                      //               ResizebleWidget(
                                                      //                 child: Image
                                                      //                     .memory(
                                                      //                   dataFromBase64String(
                                                      //                       controller
                                                      //                           .multiSignatures[pos]
                                                      //                           .signature),
                                                      //                   fit: BoxFit.fill),));
                                                      //           Get.back();
                                                      //         },
                                                      //         child: Image
                                                      //             .memory(
                                                      //             dataFromBase64String(
                                                      //                 controller
                                                      //                     .multiSignatures[pos]
                                                      //                     .signature)),
                                                      //       ),
                                                      //     );
                                                      //   });
                                                    },
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("Ok"),
                                        ),
                                      ],
                                    ),
                              );

                              //controller.pdfAndSing
                            },
                            label: "signature".tr,
                            image: 'assets/images/signature.png',
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),
                          CustomSideButtonMenu(
                            onClick: () {},
                            label: "marking".tr,
                            image: 'assets/images/A.png',
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),
                          CustomSideButtonMenu(
                            onClick: () async {
                              List<DocumentAnnotations>listofdocumentAnnotations=[];
                              RenderBox? pdfViewerRenderBox = controller.pdfViewerkey.currentContext
                                  ?.findRenderObject() as RenderBox?;
                               controller.singpic.forEach((key, value) async {
                                print("image 64  => $value");
                                RenderBox? box = key.currentContext
                                    ?.findRenderObject() as RenderBox?;

                                Offset? pos = box?.localToGlobal(Offset.zero);
                                print(box?.size.width);
                                print(box?.size.height);
                                print(box?.size.height);
                                print(pos?.dy);
                                print(pos?.dx);
                                DocumentAnnotations d = DocumentAnnotations(
                                    FontSize
                                    :12,
                                    ForceViewers
                                    :"",
                                    Height
                                    :box?.size.height,
                                    ImageByte
                                    :value,
                                    ImageName
                                    :"",
                                    Text
                                    :"",
                                    ParentWidth
                                    :pdfViewerRenderBox?.size.width,
                                    ParentHeight
                                    :pdfViewerRenderBox?.size.height,
                                    Page
                                    :controller.pdfViewerController.pageNumber,
                                    IsExclusive
                                    :false,
                                    Type
                                    :3.toString(),
                                    Viewers
                                    :  "Everyone",
                                    Width
                                    :box?.size.width,
                                    X
                                    :pos?.dx,
                                    Y
                                    :pos?.dy);
                             listofdocumentAnnotations.add(d );
                              });


                               print("listofdocumentAnnotations=>${listofdocumentAnnotations.length}");
                              print("listofdocumentAnnotations=>${listofdocumentAnnotations}");
                              await controller.getSaveDocAnnotationsData(
                                  attachmentId
                                      : controller
                                      .isOriginalMailAttachmentsList!
                                      .attachmentId,
                                  correspondenceId
                                      : controller.canOpenDocumentModel!
                                      .correspondence!.correspondenceId,
                                  delegateGctId
                                      : "0",
                                  documentAnnotationsString
                                      : listofdocumentAnnotations ,
                                  isOriginalMail
                                      : controller
                                      .isOriginalMailAttachmentsList!
                                      .isOriginalMail,
                                  transferId
                                      : controller.canOpenDocumentModel!
                                      .correspondence!.transferId,
                                  userId
                                      : controller.secureStorage
                                      .readIntSecureData(AllStringConst.UserId).toString());  },
                            label: "save".tr,
                            image: 'assets/images/save.png',
                          )
                        ]),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.grey,
                ),
                GetBuilder<DocumentController>(builder: (logic) {
                  return Expanded(
                      flex: 4,
                      child: Container(
                        child: Stack(children: [
                          ...controller.pdfAndSing

                          //                 ,    ResizebleWidget(
                          //                       child: Text(
                          //                         '''I've just did simple prototype to show main idea.
                          // 1. Draw size handlers with container;
                          // 2. Use GestureDetector to get new variables of sizes
                          // 3. Refresh the main container size.''',
                          //                       ),
                          //                     ),
                        ]),
                        //  color: Colors.red,
                        //     child: SfPdfViewer.network(
                        //   'http://africau.edu/images/default/sample.pdf',
                        // )

                        // GetBuilder<DocumentController>(builder: (logic) {
                        //     return //Container();
                        //
                        //       SfPdfViewer.network(
                        //           'http://africau.edu/images/default/sample.pdf',
                        //           password: 'syncfusion');
                        //
                        //   // Center(
                        //       //   child: controller.doc == null
                        //       //       ? const Center(child: CircularProgressIndicator())
                        //       //       : PDFViewer(document: controller.doc!));
                        //   }
                        // ),
                      ));
                }),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "sender1".tr,
                          //     data:
                          //         controller.correspondences.fromUser ?? ""),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "correspondenceId".tr,
                          //     data: controller
                          //             .correspondences.correspondenceId ??
                          //         ""),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "has Summaries".tr,
                          //     data: controller!.correspondences!.hasSummaries!
                          //         ? "yes"
                          //         : "no"),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "has Attachments".tr,
                          //     data:
                          //         controller!.correspondences!.hasAttachments!
                          //             ? "yes"
                          //             : "no"),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "is High Priority".tr,
                          //     data:
                          //         controller!.correspondences!.isHighPriority!
                          //             ? "yes"
                          //             : "no"),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "hasAttachmentsToBeDelivered".tr,
                          //     data: controller!.correspondences!
                          //             .hasAttachmentsToBeDelivered!
                          //         ? "yes"
                          //         : "no"),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "isCC".tr,
                          //     data: controller!.correspondences!.isCC!
                          //         ? "yes"
                          //         : "no"),
                          Expanded(
                            child: ListView.builder(
                              //shrinkWrap: true,
                                itemCount:
                                controller.correspondences.metadata?.length,
                                itemBuilder: (context, pos) {
                                  return _itemSideMenu(
                                      context: context,
                                      title: controller.correspondences
                                          .metadata?[pos].label ??
                                          "",
                                      data: controller.correspondences
                                          .metadata?[pos].value ??
                                          "");
                                }),
                          ),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "assignedFrom".tr,
                          //     data:
                          //         controller.correspondences.fromStructure ??
                          //             ""),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "referDate".tr,
                          //     data: controller.correspondences.tsfDueDate ??
                          //         ""),
                          // _itemSideMenu(
                          //     context: context,
                          //     title: "assignmentNotes".tr,
                          //     data:
                          //         controller.correspondences.comments ?? ""),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  _itemSideMenu({context, required String title, required String data}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.grey, fontSize: 15),
          textAlign: TextAlign.start,
        ),
        Text(
          data,
          style: Theme
              .of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.black, fontSize: 15),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  _buildTopBar(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
        padding: const EdgeInsets.all(10),
        height: 100,
        width: size.width,
        color: Get
            .find<MController>()
            .appcolor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "appTitle".tr,
              style: Theme
                  .of(context)
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
              ),
            ),
          ],
        ));
  }

  _popUpMenu(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row( //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3!
                        .copyWith(
                      color: createMaterialColor(
                        const Color.fromRGBO(77, 77, 77, 1),
                      ),
                      fontSize: 15,
                    ),
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
                      width: 20,
                      height: 20,
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
                                        color: Theme
                                            .of(context)
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .8,
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                                child: GetBuilder<DocumentController>(
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
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (!controller
                                                      .usersWillSendTo
                                                      .contains(
                                                      logic.users[pos])) {
                                                    controller
                                                        .addTousersWillSendTo(
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
                                                        color: Theme
                                                            .of(context)
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
                                                          shape: BoxShape
                                                              .circle,
                                                          color: Theme
                                                              .of(context)
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                        child: Center(
                                                            child: FittedBox(
                                                                child: Text(
                                                                    "${a?[0][0]} ${a?[0][0] ??
                                                                        ""}"))),
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
                    SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .8,
                        height: 300, // MediaQuery.of(context).size.height * .5,
                        child: GetBuilder<DocumentController>(
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
                                                  Text(
                                                    "name",
                                                    style: Theme
                                                        .of(context)
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
                                                      logic
                                                          .delTousersWillSendTo(
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
                                                      icon: const Icon(
                                                          Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                      ),
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
                                                              controller
                                                                  .recording
                                                                  ? controller
                                                                  .stopForMany(
                                                                  id: logic
                                                                      .usersWillSendTo[
                                                                  pos]
                                                                      .id!)
                                                                  : controller
                                                                  .recordForMany();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: GetBuilder<
                                                                  DocumentController>(
                                                                  builder:
                                                                      (logic) {
                                                                    return Icon(
                                                                        controller
                                                                            .recording
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
                                                                controller
                                                                    .playRec();
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
                  print("i click ok");
                  print(
                      "Get.find<InboxController>().   =>   ${controller
                          .transfarForMany.length}");

                  controller.transfarForMany.forEach((key, value) {
                    print("$key      ${value.toMap()}");
                  });
                  //  Navigator.of(context).pop();
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
              " Get.find<DocumentController>() .canOpenDocumentModel?.attachments?.attachments?.length=>${Get
                  .find<DocumentController>()
                  .canOpenDocumentModel
                  ?.attachments
                  ?.attachments
                  ?.length}");
          return AlertDialog(
            title: Text("Attachments"),
            content: SizedBox(
              height: 150,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .7,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Get
                      .find<DocumentController>()
                      .folder2
                      .length,
                  itemBuilder: (context, pos) {
                    String key = Get
                        .find<DocumentController>()
                        .folder2
                        .keys
                        .elementAt(pos);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity, color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary, child: Text(key)),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount:
                                  Get
                                      .find<DocumentController>()
                                      .folder2[key]!
                                      .length,
                                  itemBuilder: (context, indx) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(onTap: () {
                                        Get.find<DocumentController>()
                                            .getAttachmentItemlocal(
                                            context: context);
                                        //  _popShowAttachments(context);
                                      },
                                        child: Text(Get
                                            .find<
                                            DocumentController>()
                                            .folder2[key]![indx]
                                            .fileName!),
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .7,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .7,
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

  _popUpExportG2GDocument(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(""),
            content: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .8,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .8,
              child: GetBuilder<DocumentController>(builder: (logic) {
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 150, child: Text("جهة رئيسية")),
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
                                        suggestionsCallback: (pattern) async {
                                          return controller
                                              .g2gInfoForExportModel!.parents!
                                              .where((element) =>
                                              element
                                                  .parentName!
                                                  .toLowerCase()
                                                  .contains(
                                                  pattern.toLowerCase()));

                                          //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          Parents v = suggestion as Parents;

                                          return // Te(v.originalName!);

                                            ListTile(
                                              title: FilterText(v.parentName!),
                                            );
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          Parents v = suggestion as Parents;
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
                                        width: 150, child: Text("جهة فرعية")),
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
                                            onChanged: (
                                                DepartmentList? newValue) {
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
                                                    child: Text(
                                                        value.childName!),
                                                  );
                                                })
                                                .toList()
                                                .where((element) =>
                                            element.value?.parentGeid ==
                                                controller.toParent?.parentGeid)
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
                                              .toDepartmentList.length,
                                          itemBuilder: (context, pos) {
                                            return Text(controller
                                                .toDepartmentList[pos]
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 150, child: Text("جهة رئيسية")),
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
                                        suggestionsCallback: (pattern) async {
                                          return controller
                                              .g2gInfoForExportModel!.parents!
                                              .where((element) =>
                                              element
                                                  .parentName!
                                                  .toLowerCase()
                                                  .contains(
                                                  pattern.toLowerCase()));

                                          //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          Parents v = suggestion as Parents;

                                          return // Te(v.originalName!);

                                            ListTile(
                                              title: FilterText(v.parentName!),
                                            );
                                        },
                                        onSuggestionSelected: (suggestion) {
                                          Parents v = suggestion as Parents;
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
                                        width: 150, child: Text("جهة فرعية")),
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
                                            onChanged: (
                                                DepartmentList? newValue) {
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
                                                    child: Text(
                                                        value.childName!),
                                                  );
                                                })
                                                .toList()
                                                .where((element) =>
                                            element.value?.parentGeid ==
                                                controller.toParent?.parentGeid)
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: 150, child: Text(" ")),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1)),
                                            child: TextField(
                                              maxLines: 6,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: 150, child: Text(" ")),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    // Container(height: 150,width: double.infinity,
                                    //     decoration: BoxDecoration(
                                    //         border: Border.all(width: 1)),
                                    //     child:
                                    //
                                    //     ListView.builder(
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemCount: 10,
                                    //         itemBuilder: (context, pos) {
                                    //           return Padding(
                                    //             padding: const EdgeInsets.all(8.0),
                                    //             child: Card(
                                    //                 elevation: 8,
                                    //                 child: Column(
                                    //                   children: [
                                    //                     Expanded(
                                    //                         child: Padding(
                                    //                           padding: const EdgeInsets.all(8.0),
                                    //                           child: Icon(Icons.note, size: 80),
                                    //                         )),
                                    //                     Expanded(
                                    //                         child: Padding(
                                    //                           padding: const EdgeInsets.all(8.0),
                                    //                           child: Text("Attachment number $pos"),
                                    //                         ))
                                    //                   ],
                                    //                 )),
                                    //           );
                                    //         }),
                                    //
                                    //
                                    //
                                    //
                                    // ),
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
