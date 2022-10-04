import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../utility/utilitie.dart' as u;
import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';

import '../controllers/landing_page_controller.dart';
import '../controllers/my_cart/create_basket_controller.dart';
import '../models/CorrespondencesModel.dart';
import '../services/apis/reply_with_voice_note_api.dart';
import '../services/json_model/basket/fetch_basket_list_model.dart';
import '../services/json_model/favorites/list_all/ListFavoriteRecipients_response.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/reply_with_voicenote_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../utility/all_const.dart';
import '../utility/utilitie.dart';
import 'custom_button.dart';
import 'custom_button_with_icon.dart';
import 'package:cts/utility/Extenstions.dart';

class CustomListView extends GetView<InboxController> {
  CustomListView(
      {required this.function,
      //  required this.allCorrespondences,
      required this.correspondences,
      required this.scrollController,
      required this.haveMoreData,
      required this.onClickItem,
      required this.functionComplet,
      required this.functionReply,
      required this.functionSummary,
      required this.functionTrunsfer //,required this.openMenu
      ,
      required this.customActions});

  VoidCallback functionComplet;
  VoidCallback functionTrunsfer;
  VoidCallback functionReply;
  VoidCallback functionSummary;
  List<CustomActions>? customActions = [];

  // VoidCallback openMenu;

  Future<void> function;

  VoidCallback onClickItem;
  List<Correspondences> correspondences;
  //List<Correspondences> allCorrespondences;
  ScrollController scrollController;
  bool haveMoreData = true;

  @override
  Widget build(BuildContext context) {
    var r = Get.find<InboxController>().correspondencesModel;
    // return Container(color: Colors.pink);
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => function,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, pos) {
                      if (pos < correspondences.length) {
                        // print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");

                        return
                            // correspondences[pos].isNew??false?

                            InkWell(
                          onTap: () {
                            Get.find<InboxController>().canOpenDoc(
                                context: context,
                                docId: correspondences[pos].purposeId,
                                correspondenceId:
                                    correspondences[pos].correspondenceId,
                                transferId: correspondences[pos].transferId);

                            Get.find<DocumentController>().correspondences =
                                correspondences[pos];

                            //  Get.find<DocumentController>().loadPdf();

                            //  Get.find<DocumentController>().loadPdf();
                            //Get.toNamed("/DocumentPage");
                          },
                          child: SizedBox(
                            //height: MediaQuery.of(context).size.height*.3,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          height: 15,
                                                          width: 15,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              shape: BoxShape
                                                                  .circle)),
                                                    ),
                                                    Text(
                                                      correspondences[pos]
                                                              .gridInfo?[0]
                                                              .value ??
                                                          "",
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(.7),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                correspondences[pos]
                                                        .gridInfo?[3]
                                                        .value ??
                                                    "",
                                                //   softWrap: true,
                                                //      maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.4),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 2,
                                          // ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Container(
                                              //   height: 15,
                                              //   width: 15,
                                              //   decoration: BoxDecoration(
                                              //       shape: BoxShape.circle),
                                              // ),
                                              // SizedBox(
                                              //   width: 2,
                                              // ),
                                              Text(
                                                "sender".tr,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.5),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                correspondences[pos].fromUser ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.5),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              //       Spacer(),
                                            ],
                                          ),
                                          buildPriorities(pos, context)
                                        ],
                                      ),
                                    ),
                                    Get.find<InboxController>().edit
                                        ? InkWell(
                                            onTap: () {
                                              print(
                                                  "is select      ${correspondences[pos].isSelect}");

                                              print(Get.find<InboxController>()
                                                  .listSelectCorrespondences
                                                  .length);

                                              if (correspondences[pos]
                                                  .isSelect) {
                                                correspondences[pos].isSelect =
                                                    false;
                                              } else {
                                                correspondences[pos].isSelect =
                                                    true;
                                              }
                                              if (correspondences[pos]
                                                  .isSelect) {
                                                Get.find<InboxController>()
                                                    .listSelectCorrespondences
                                                    .add(int.parse(
                                                        correspondences[pos]
                                                            .correspondenceId!));
                                              } else {
                                                Get.find<InboxController>()
                                                    .listSelectCorrespondences
                                                    .remove(
                                                        correspondences[pos]);
                                              }

                                              Get.find<InboxController>()
                                                  .update();
                                            },
                                            child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Image.asset(correspondences[
                                                                pos]
                                                            .isSelect
                                                        ? "assets/images/check.png"
                                                        : "assets/images/uncheck.png"))),
                                          )
                                        : PopupMenuButton(
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .forward_rounded,
                                                            color:
                                                                Colors.orange),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text("Reply".tr),
                                                      ],
                                                    ),
                                                    value: 1,
                                                    onTap:
                                                        () {}, //functionReply,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .account_circle,
                                                            color: Colors.red),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text("Transfer".tr),
                                                      ],
                                                    ),
                                                    value: 2,
                                                    onTap:
                                                        () {}, //functionTrunsfer,
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.bookmark,
                                                            color:
                                                                Colors.orange),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text("Complete".tr),
                                                      ],
                                                    ),
                                                    onTap:
                                                        () {}, // functionComplet,
                                                    value: 3,
                                                  ),
                                                  if (correspondences[pos]
                                                          .hasSummaries ??
                                                      false)
                                                    PopupMenuItem(
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.menu,
                                                              color: Colors
                                                                  .blueAccent),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text("Summary".tr),
                                                        ],
                                                      ),
                                                      onTap:
                                                          () {}, // functionSummary,
                                                      value: 4,
                                                    ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .backpack_sharp,
                                                            color: Colors
                                                                .blueAccent),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text("addtoBasket".tr),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      // Get.find<InboxController>()
                                                      //     .getFetchBasketList(
                                                      //     context: context);
                                                    },
                                                    value: 5,
                                                  ),
                                                ],
                                            enableFeedback: true,
                                            onSelected: (v) async {
                                              if (v == 1) {
                                                controller.isPrivate = true;
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
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary)),
                                                        Spacer(),
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                            child: Image.asset(
                                                              "assets/images/close_button.png",
                                                              height: 24,
                                                              width: 24,
                                                            ))
                                                      ],
                                                    ),
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .5,
                                                        color: Colors.grey[200],
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        "name"
                                                                            .tr,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline3!
                                                                            .copyWith(
                                                                              color: createMaterialColor(
                                                                                const Color.fromRGBO(77, 77, 77, 1),
                                                                              ),
                                                                              fontSize: 15,
                                                                            ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(correspondences[pos].fromUser ??
                                                                            ""),
                                                                      ),
                                                                      Spacer(),
                                                                      CircleAvatar(
                                                                        backgroundImage:
                                                                            AssetImage("assets/images/pr.jpg"),
                                                                        backgroundColor:
                                                                            Colors.cyan,
                                                                        maxRadius:
                                                                            30,
                                                                        minRadius:
                                                                            30,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      )
                                                                    ]),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                          "audioNotes"
                                                                              .tr),
                                                                    ),
                                                                    Spacer(),
                                                                    Text("private"
                                                                        .tr),
                                                                    GetBuilder<
                                                                        InboxController>(
                                                                      id: "pr",
                                                                      assignId:
                                                                          true,
                                                                      autoRemove:
                                                                          false,
                                                                      builder:
                                                                          (logic) {
                                                                        return Checkbox(
                                                                          value:
                                                                              logic.isPrivate,
                                                                          onChanged:
                                                                              logic.updateISPrivate,
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
                                                                                  if (Get.find<InboxController>().record.isRecording) {
                                                                                    print(" ايقاف التشغيل");
                                                                                    Get.find<InboxController>().stopMathod();
                                                                                  } else {
                                                                                    print(" بداء  التشغيل");
                                                                                    Get.find<InboxController>().recordMathod();
                                                                                  }
                                                                                  //دي القديم الي كنت بستخدمه في الرد
                                                                                  // Get
                                                                                  //     .find<
                                                                                  //     InboxController>()
                                                                                  //     .recording
                                                                                  //     ? Get
                                                                                  //     .find<
                                                                                  //     InboxController>()
                                                                                  //     .stop2()
                                                                                  //     : Get
                                                                                  //     .find<
                                                                                  //     InboxController>()
                                                                                  //     .record2();
                                                                                  // Get
                                                                                  //     .find<
                                                                                  //     InboxController>()
                                                                                  //     .update(
                                                                                  //     [
                                                                                  //       "id"
                                                                                  //     ]);
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: GetBuilder<InboxController>(
                                                                                      id: "id",
                                                                                      builder: (logic) {
                                                                                        return Icon(Get.find<InboxController>().recording ? Icons.stop : Icons.mic);
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
                                                                                    Get.find<InboxController>().playMathod();
                                                                                  },
                                                                                  child: Icon(Icons.play_arrow, color: Theme.of(context).colorScheme.primary),
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
                                                                  child:
                                                                      TextFormField(
                                                                    decoration: InputDecoration(
                                                                        hintText:
                                                                            " ادخل الرد",
                                                                        contentPadding:
                                                                            EdgeInsets.all(16)),
                                                                    onChanged:
                                                                        (v) {
                                                                      Get.find<
                                                                              InboxController>()
                                                                          .replyNote = v;
                                                                    },
                                                                    maxLines: 4,
                                                                  ),
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
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
                                                          ReplyWithVoiceNoteRequestModel
                                                              v;
                                                          String?
                                                              audioFileBes64 =
                                                              await audiobase64String(
                                                                  file: Get.find<
                                                                          InboxController>()
                                                                      .recordFile);

                                                          ReplyWithVoiceNoteApi
                                                              replayAPI =
                                                              ReplyWithVoiceNoteApi(
                                                                  context);
                                                          if (Get.find<
                                                                      InboxController>()
                                                                  .recordFile !=
                                                              null) {
                                                            v = ReplyWithVoiceNoteRequestModel(
                                                                userId: correspondences[pos]
                                                                    .fromUserId
                                                                    .toString(),
                                                                transferId:
                                                                    correspondences[pos]
                                                                        .transferId,
                                                                token: Get.find<
                                                                        InboxController>()
                                                                    .secureStorage
                                                                    .token(),
                                                                correspondencesId:
                                                                    correspondences[pos]
                                                                        .correspondenceId,
                                                                language: Get
                                                                            .locale
                                                                            ?.languageCode ==
                                                                        "en"
                                                                    ? "en"
                                                                    : "ar",
                                                                voiceNote:
                                                                    audioFileBes64,
                                                                notes: Get.find<
                                                                        InboxController>()
                                                                    .replyNote,
                                                                voiceNoteExt:
                                                                    "m4a",
                                                                voiceNotePrivate:
                                                                    Get.find<InboxController>()
                                                                        .isPrivate);
                                                          } else {
                                                            v = ReplyWithVoiceNoteRequestModel(
                                                                userId: correspondences[pos]
                                                                    .fromUserId
                                                                    .toString(),
                                                                transferId: correspondences[pos]
                                                                    .transferId,
                                                                token: Get.find<
                                                                        InboxController>()
                                                                    .secureStorage
                                                                    .token(),
                                                                correspondencesId:
                                                                    correspondences[
                                                                            pos]
                                                                        .correspondenceId,
                                                                language:
                                                                    Get.locale
                                                                                ?.languageCode ==
                                                                            "en"
                                                                        ? "en"
                                                                        : "ar",
                                                                voiceNote: null,
                                                                notes: Get.find<
                                                                        InboxController>()
                                                                    .replyNote,
                                                                voiceNoteExt:
                                                                    null,
                                                                voiceNotePrivate:
                                                                    false);
                                                          }

                                                          print(v.toMap());
                                                          showLoaderDialog(
                                                              context);
                                                          await replayAPI
                                                              .post(v.toMap())
                                                              .then((value) {
                                                            Navigator.pop(
                                                                context);
                                                            ReplyWithVoiceNoteModel
                                                                v = value
                                                                    as ReplyWithVoiceNoteModel;
                                                            if (v.status == 1) {
                                                              Get.snackbar("",
                                                                  "تمت العمليه بنجاح");
                                                            }
                                                            // Get.       getDashboardStats()
                                                            Get.find<
                                                                    LandingPageController>()
                                                                .getDashboardStats(
                                                                    context:
                                                                        context);
                                                            Get.find<
                                                                    InboxController>()
                                                                .getCorrespondencesData(
                                                                    context:
                                                                        context,
                                                                    inboxId: Get.find<
                                                                            InboxController>()
                                                                        .inboxId,
                                                                    pageSize:
                                                                        20,
                                                                    showThumbnails:
                                                                        false);
                                                          });

                                                          /// ToDo send Replay
                                                          Get.find<InboxController>()
                                                                  .recordFile =
                                                              null;
                                                          Get.find<
                                                                  InboxController>()
                                                              .replyNote = "";
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("send".tr,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else if (v == 2) {
                                                ///ToDo   عمل تحويل زي الي في داخل الدكيومنت

                                                _popUpMenu(context, pos);
                                              } else if (v == 3) {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Text(" "),
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .8,
                                                        color: Colors.grey[200],
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text("note"),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      TextFormField(
                                                                    onChanged:
                                                                        (v) {
                                                                      Get.find<
                                                                              InboxController>()
                                                                          .completeNote = v;
                                                                    },
                                                                    maxLines: 4,
                                                                  ),
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
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
                                                          print(Get.find<
                                                                  InboxController>()
                                                              .completeCustomActions
                                                              ?.name);
                                                          print(Get.find<
                                                                  InboxController>()
                                                              .completeCustomActions
                                                              ?.icon);

                                                          String data =
                                                              'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${correspondences[pos].correspondenceId}&transferId=${correspondences[pos].transferId}&actionType=Complete&note=${Get.find<InboxController>().completeNote}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';
                                                          Navigator.of(ctx)
                                                              .pop();
                                                          showLoaderDialog(
                                                              context);
                                                          await Get.find<
                                                                  InboxController>()
                                                              .completeInCorrespondence(
                                                                  context:
                                                                      context,
                                                                  data: data);
                                                          Get.find<
                                                                  LandingPageController>()
                                                              .getDashboardStats(
                                                                  context:
                                                                      context);
                                                          Get.find<
                                                                  InboxController>()
                                                              .getCorrespondencesData(
                                                                  context:
                                                                      context,
                                                                  inboxId: Get.find<
                                                                          InboxController>()
                                                                      .inboxId,
                                                                  pageSize: 20,
                                                                  showThumbnails:
                                                                      false);
                                                        },
                                                        child: Text("Ok"),
                                                      ),
                                                    ],
                                                  ),
                                                );

                                                print(
                                                    Get.find<InboxController>()
                                                        .customAction
                                                        ?.name);

                                                print(
                                                    "  Correspondences[pos].purposeId =>   ${correspondences[pos].purposeId}");
                                                print(
                                                    " Correspondences[pos].correspondenceId =>   ${correspondences[pos].correspondenceId}");
                                                print(
                                                    "   Correspondences[pos].transferId =>   ${correspondences[pos].transferId}");

                                                print("ppp" * 10);
                                                print(
                                                    Get.find<InboxController>()
                                                        .customAction
                                                        ?.name);
                                              } else if (v == 4) {
                                                //correspondences[pos].

                                              } else if (v == 5) {
                                                await showAllBasketsDialog(
                                                    context);
                                                await Get.find<
                                                        InboxController>()
                                                    .getFetchBasketList(
                                                        context: null);
                                                print(
                                                    "Get.find<InboxController>().getFetchBasketList()");
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (ctx) => AlertDialog(
                                                //     title: Text(" "),
                                                //     content: Padding(
                                                //       padding:
                                                //           const EdgeInsets.all(
                                                //               8.0),
                                                //       child: Container(
                                                //           width: MediaQuery.of(
                                                //                       context)
                                                //                   .size
                                                //                   .width *
                                                //               .3,
                                                //           color: Colors.grey[200],
                                                //           child: ListView.builder(
                                                //               itemCount: Get.find<
                                                //                       InboxController>()
                                                //                   .fetchBasketListModel
                                                //                   ?.baskets
                                                //                   ?.length,
                                                //               itemBuilder:
                                                //                   (context, pos) {
                                                //                 return InkWell(
                                                //                   onTap:
                                                //                       () async {
                                                //                     Get.find<
                                                //                             InboxController>()
                                                //                         .listSelectCorrespondences
                                                //                         .add(int.parse(
                                                //                             correspondences[pos]
                                                //                                 .correspondenceId!));
                                                //
                                                //                     await Get.find<InboxController>().addDocumentsToBasket(
                                                //                         context:
                                                //                             context,
                                                //                         basketId: Get.find<
                                                //                                 InboxController>()
                                                //                             .fetchBasketListModel
                                                //                             ?.baskets?[
                                                //                                 pos]
                                                //                             .iD);
                                                //                     Get.back();
                                                //                   },
                                                //                   child: Card(
                                                //                     elevation: 10,
                                                //                     color: Get.find<
                                                //                             InboxController>()
                                                //                         .fetchBasketListModel
                                                //                         ?.baskets?[
                                                //                             pos]
                                                //                         .color
                                                //                         ?.toColor(),
                                                //                     child: Column(
                                                //                         children: [
                                                //                           Text(Get.find<InboxController>().fetchBasketListModel?.baskets?[pos].name ??
                                                //                               ""),
                                                //                           Text(Get.find<InboxController>().fetchBasketListModel?.baskets?[pos].nameAr ??
                                                //                               ""),
                                                //                           Text(
                                                //                               "color :${Get.find<InboxController>().fetchBasketListModel?.baskets?[pos].color}")
                                                //                         ]),
                                                //                   ),
                                                //                 );
                                                //               })),
                                                //     ),
                                                //     actions: <Widget>[
                                                //       TextButton(
                                                //         onPressed: () async {
                                                //           /// ToDo send Replay
                                                //           print(
                                                //               "77777777777777777777777777777777777777777777777777");
                                                //           Navigator.of(ctx).pop();
                                                //         },
                                                //         child: Text("Ok"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // );
                                              }
                                            }),
                                  ],
                                )),
                          ),
                        );

                        ///:SizedBox();
                      } else {
                        return haveMoreData
                            ? const SizedBox(
                                height: 50,
                                width: 50,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : const SizedBox();
                      }
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: correspondences.length + 1),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Padding buildPriorities(int pos, BuildContext context) {
    var ic = Get.find<InboxController>();
    var cm = ic.correspondencesModel;
    int priorityID = int.parse(correspondences[pos].priorityId!);
    var priority =
        cm!.priorities!.where((element) => element.Value == priorityID).first;
    int privacyID = int.parse(correspondences[pos].privacyId!);
    var privacy =
        cm.privacies!.where((element) => element.Value == privacyID).first;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.priority_high,
            color:
                correspondences[pos].priorityId != "3" ? AppColor : Colors.red,
            size: 25,
          ),

          Text(
            Get.locale?.languageCode == "en"
                ? priority.Text!
                : priority.TextAr!,
            //     "veryimportant".tr,
            style: TextStyle(
              color:
                  correspondences[pos].priorityId != "3" ? AppColor : RedColor,
              fontSize: 10,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.warning,
            color: AppColor,
            size: 25,
          ),
          Text(
            Get.locale?.languageCode == "en" ? privacy.Text! : privacy.TextAr!,
            style: TextStyle(
              color: AppColor,
              fontSize: 10,
            ),
          ),

          // if (correspondences[pos].priorityId == "3")
          SizedBox(
            width: 50,
          ),
          if (correspondences[pos].showLock!)
            Icon(correspondences[pos].isLocked! ? Icons.lock : Icons.lock_open,
                color: Theme.of(context).colorScheme.primary),

          SizedBox(
            width: 50,
          ),

          // if (correspondences[pos].isLocked)
          //   Text("closed".tr,
          //       style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          // //   correspondences[pos].priorityId
          //  correspondences[pos].purposeId

          SizedBox(
            width: 50,
          ),
          if (correspondences[pos].hasAttachments!)
            Icon(Icons.attachment, color: AppColor),
        ],
      ),
    );
  }

  InboxController inboxController = Get.put<InboxController>(InboxController());
  LandingPageController landingPageController =
      Get.put<LandingPageController>(LandingPageController());

  // Future<void> showAllBasketsDialog(BuildContext context) async {
  //   showLoaderDialog(context);
  //   await inboxController.getFetchBasketList(context: context);
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Text(" "),
  //       content: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //             width: MediaQuery.of(context).size.width * .3,
  //             color: Colors.grey[200],
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Spacer(),
  //                     // controller.isSavingOrder
  //                     //     ? IconButton(
  //                     //         icon: Icon(Icons.check), onPressed: () {})
  //                     //     : Container(),
  //                   ],
  //                 ),
  //                 GetBuilder<LandingPageController>(builder: (logic) {
  //                   print("inboxController.fetchBasketListModel");
  //
  //                   return Expanded(
  //                       child: ReorderableListView(
  //                     buildDefaultDragHandles: true,
  //                     // buildDefaultDragHandles: false,
  //                     padding: const EdgeInsets.symmetric(horizontal: 40),
  //                     children: addBasketData(context),
  //                     onReorder: (int oldIndex, int newIndex) {
  //                       print("onReorder = $oldIndex - $newIndex");
  //                       if (oldIndex < newIndex) {
  //                         newIndex -= 1;
  //                       }
  //                       final Baskets item = inboxController
  //                           .fetchBasketListModel!.baskets!
  //                           .removeAt(oldIndex);
  //                       inboxController.fetchBasketListModel!.baskets!
  //                           .insert(newIndex, item);
  //                     },
  //                     onReorderStart: (int index) {
  //                       //0-1-2-....
  //                       print("onReorderStart = $index");
  //                       inboxController.setOldIndex(index);
  //                       // print("onReorderStart = ${inboxController.fetchBasketListModel!.baskets![index].canBeReOrder}");
  //                       // if (inboxController
  //                       //         .fetchBasketListModel!.baskets![index].canBeReOrder ==
  //                       //     false) {
  //                       //
  //                       // }else{
  //                       //
  //                       // }
  //                     },
  //                     onReorderEnd: (int index) {
  //                       landingPageController.setSavingOrder(true);
  //                       //get the item that will be replaced
  //                       //check if ite canBeReorder or not
  //                       //2-3-4-...
  //                       print("onReorderEnd = $index");
  //                       if (inboxController.fetchBasketListModel!
  //                               .baskets![index].canBeReOrder ==
  //                           false) {
  //                         showTopSnackBar(
  //                           context,
  //                           CustomSnackBar.error(
  //                             // icon: Container(),
  //                             message:
  //                                 "${inboxController.fetchBasketListModel!.baskets![index].name} canBeReOrder = false",
  //                           ),
  //                         );
  //                       } else {
  //                         // print("fetchBasketListModel__ = ${inboxController.fetchBasketListModel?.baskets.toString()}");
  //                         // inboxController.fetchBasketListModel?.baskets?.forEach((element) {
  //                         //   print(element.orderBy);
  //                         // });
  //                         if (inboxController.oldIndex != index) {
  //                           showLoaderDialog(context);
  //                           print(
  //                               inboxController.fetchBasketListModel?.toJson());
  //                           landingPageController.reOrderBaskets(
  //                               context: context,
  //                               baskets: inboxController
  //                                   .fetchBasketListModel!.baskets);
  //                         }
  //                       }
  //                     },
  //                   ));
  //                 }),
  //               ],
  //             )
  //
  //             // child: ListView.builder(
  //             //     // itemCount: inboxController
  //             //     //     .fetchBasketListModel
  //             //     //     ?.baskets
  //             //     //     ?.length,
  //             //     itemCount: 5,
  //             //     itemBuilder: (context, pos) {
  //             //       return InkWell(
  //             //         onTap: () async {
  //             //           print(
  //             //               "${inboxController.fetchBasketListModel?.baskets?[pos].iD}");
  //             //
  //             //           Get.find<BasketController>().getBasketInbox(
  //             //               id: inboxController
  //             //                   .fetchBasketListModel!
  //             //                   .baskets![pos]
  //             //                   .iD!,
  //             //               pageSize: 20,
  //             //               pageNumber: 0);
  //             //
  //             //           Get.back();
  //             //
  //             //           Get.toNamed("MyPocketsScreen");
  //             //         },
  //             //         child: Card(
  //             //           elevation: 10,
  //             //           child: Column(children: [
  //             //             Text(inboxController
  //             //                 .fetchBasketListModel
  //             //                 ?.baskets?[pos]
  //             //                 .name ??
  //             //                 ""),
  //             //             Text(inboxController
  //             //                 .fetchBasketListModel
  //             //                 ?.baskets?[pos]
  //             //                 .nameAr ??
  //             //                 ""),
  //             //             // Text( "color :${inboxController
  //             //             //     .fetchBasketListModel
  //             //             //     ?.baskets?[pos].color}",style: TextStyle( color:  HexColor(inboxController
  //             //             //     .fetchBasketListModel
  //             //             //     ?.baskets?[pos].color??"#000000"))),
  //             //
  //             //             GestureDetector(
  //             //                 onTap: () {
  //             //                   //هنا هنعمل دليت
  //             //                   controller.removeBasket(
  //             //                       basketId:
  //             //                       inboxController
  //             //                           .fetchBasketListModel
  //             //                           ?.baskets?[pos]
  //             //                           .iD);
  //             //                 },
  //             //                 child: Icon(Icons.delete)),
  //             //           ]),
  //             //         ),
  //             //       );
  //             //     })
  //
  //             ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () async {
  //             Navigator.of(ctx).pop();
  //           },
  //           child: Text("Ok".tr),
  //         ),
  //         // Visibility(
  //         //     visible: controller.isSavingOrder,
  //         //     child: FlatButton(
  //         //       onPressed: () async {
  //         //         // Navigator.of(ctx).pop();
  //         //         // Get.to(BasketPage());
  //         //       },
  //         //       child: Text("Save Order"),
  //         //     )),
  //         TextButton(
  //           onPressed: () async {
  //             //هنا هنكريت الباسكت
  //
  //             showInputDialog(
  //                 context, 'CreateNewBasket'.tr, 'default inpit', 'message');
  //           },
  //           child: Text("new Basket".tr),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<String?> showInputDialog(
      BuildContext context, String title, String defaultInput, String message) {
    var textController = TextEditingController(text: defaultInput);
    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Text(message), TextField(controller: textController)
        // CreateNewBasket(),

        Form(
            // key: controller.createBasketFormKey,
            // child: LayoutBuilder(builder: (context, constraint) {
            //   return Container(
            child: Column(
          children: [
            // Spacer(),
            // CustomInputTextFiled(
            //     validator: controller.validators.nameValidator,
            //     textEditingController: controller.englishName,
            //     label: "english_name".tr),
            // CustomInputTextFiled(
            //     validator: controller.validators.nameValidator,
            //     textEditingController: controller.arabicName,
            //     label: "arabic_name".tr),

            Container(
              // padding: EdgeInsets.only(right: 10, left: 10),
              padding: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                  child: TextField(
                    controller:
                        landingPageController.textEditingControllerEnglishName,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "english_name".tr,
                    ),
                  )),
            ),

            Container(
              // padding: EdgeInsets.only(right: 10, left: 10),
              padding: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                  child: TextField(
                    controller:
                        landingPageController.textEditingControllerArabicName,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "arabic_name".tr,
                    ),
                  )),
            ),

            Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              width: MediaQuery.of(context).size.width * .3,
              child: ElevatedButton(
                  onPressed: () {
                    // inboxController.applyFilter();
                    // Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                "pick your Color".tr,
                              ),
                              content: Container(
                                width: MediaQuery.of(context).size.width * .3,
                                height: MediaQuery.of(context).size.height * .5,
                                child: Column(children: [
                                  buildHorizontalListViewCircleColors(context),

                                  // ColorPicker(
                                  //   pickerColor:
                                  //       Get.find<CreateBasketController>()
                                  //           .pickerColor,
                                  //   onColorChanged: (Color color) {
                                  //     Get.find<CreateBasketController>()
                                  //         .setPickerColor(color);
                                  //   },
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 8.0, bottom: 8, right: 20, left: 20),
                                  //   child: Row(children: []),
                                  // ),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width * .7,
                                  //   padding: const EdgeInsets.only(
                                  //       left: 0, right: 0, top: 0, bottom: 0),
                                  //   height: 60,
                                  //   decoration: BoxDecoration(
                                  //       color:
                                  //       Theme.of(context).colorScheme.primary,
                                  //       borderRadius: const BorderRadius.all(
                                  //           Radius.circular(6))),
                                  //   child: ElevatedButton(
                                  //       onPressed: () {
                                  //         // Get.find<SecureStorage>().writeSecureData(
                                  //         //     AllStringConst.AppColor,
                                  //         //     Get.find<MController>().appcolor.value);
                                  //         Navigator.of(context).pop();
                                  //       },
                                  //       child: GestureDetector(
                                  //         onTap: () {},
                                  //         child: Text(
                                  //           "save".tr,
                                  //           textAlign: TextAlign.center,
                                  //         ),
                                  //       )),
                                  // )
                                ]),
                              ),
                            ));
                  },
                  child: GetBuilder<CreateBasketController>(
                    init: CreateBasketController(),
                    builder: (_) {
                      return Text("pick your Color".tr,
                          style: TextStyle(
                              // backgroundColor: _.pickerColor,
                              color: _.pickerColor));
                    },
                  )),
            ),

            Container(
              height: 40,
              padding: EdgeInsets.only(right: 10, left: 10),
              width: MediaQuery.of(context).size.width * .3,
              child: CustomButton(
                  name: 'register'.tr,
                  onPressed: () {
                    //filter max

                    showLoaderDialog(context);
                    // controller.createNewBasket();

                    var basket = Baskets(
                        color: Get.find<CreateBasketController>()
                            .pickerColor
                            .toHex(),
                        canBeReOrder: true,
                        orderBy: 0,
                        nameAr: landingPageController
                            .textEditingControllerArabicName.text,
                        name: landingPageController
                            .textEditingControllerEnglishName.text);
                    inboxController.fetchBasketListModel!.baskets?.add(basket);

                    landingPageController.addEditBasket(
                        context: context, basket: basket);
                  }),
            ),
          ],
          // ),
          // );
          // }
        ))
      ],
    );
    // var content = CreateNewBasket();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        var mediaQuery = MediaQuery.of(context);

        return AnimatedContainer(
          padding: mediaQuery.padding,
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            title: Text(title),
            content: content,
            scrollable: true,
            // actions: <Widget>[
            //   TextButton(
            //     child: const Text('Cancel'),
            //     onPressed: () => Navigator.pop(context),
            //   ),
            //   TextButton(
            //     child: const Text('Okay'),
            //     onPressed: () => Navigator.pop(context, textController.text),
            //   ),
            // ],
          ),
        );
      },
    );
  }

  Future<void> _showMyDialogDeleteConfirm(
      BuildContext context, Baskets basket) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('SureToDelete'.tr),
                // Text('Would you like to confirm this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'.tr),
              onPressed: () {
                showLoaderDialog(context);
                landingPageController.removeBasket(
                  context: context,
                  basketId: basket.iD,
                  onSuccess: (String message) {
                    // Navigator.pop(context);
                    // Get.back();
                    // showAllBasketsDialog(context);
                    return null;
                  },
                );
                inboxController.fetchBasketListModel!.baskets?.remove(basket);
                controller.update();
                print('Confirmed');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAllBasketsDialog(BuildContext context) async {
    u.showLoaderDialog(context);
    await inboxController.getFetchBasketList(context: context);
    showBasketView(context);
  }

  Future<dynamic> showBasketView(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Basket".tr,
        ),
        content: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .6,
            // color: Colors.grey[200],
            child: Column(
              children: [
                GetBuilder<LandingPageController>(builder: (logic) {
                  return Expanded(
                    child: ReorderableListView(
                      buildDefaultDragHandles: true,
                      //    padding: const EdgeInsets.symmetric(horizontal: 40),
                      children: <Widget>[
                        for (final basket
                            in inboxController.fetchBasketListModel!.baskets!)
                          Card(
                            key: ValueKey(basket),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              dense: false,
                              // shape: ,

                              onLongPress: !(basket.canBeReOrder ?? false)
                                  ? () {
                                      print(basket.iD);
                                    }
                                  : null,
                              onTap: () async {
                                // Get.find<InboxController>().clearFilter();
                                // Get.find<InboxController>().isAllOrNot = true;
                                // Get.find<InboxController>().getBasketInbox(
                                //   context: context,
                                //   id: basket.iD!,
                                // );
                                // Get.find<InboxController>().selectUserFilter =
                                // null;
                                // Get.find<InboxController>().userFilter.clear();
                                // Get.toNamed("/InboxPage");

                                await Get.find<InboxController>()
                                    .addDocumentsToBasket(
                                        context: context, basketId: basket.iD);
                              },
                              //: null,
                              //  enabled: !(basket.canBeReOrder ?? false),
                              enableFeedback: !(basket.canBeReOrder ?? false),
                              leading: Icon(
                                Icons.wallet,
                                color: basket.color?.toColor(),
                                size: 50,
                              ),
                              trailing: (basket.canBeReOrder ?? false)
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.color,
                                      ),
                                      onPressed: () {
                                        _showMyDialogDeleteConfirm(
                                            context, basket);
                                      },
                                    )
                                  : null,

                              visualDensity: VisualDensity.comfortable,
                              title: Text(
                                basket.nameAr ?? "",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              //    subtitle: Text(basket.nameAr ?? ""),
                              style: ListTileStyle.list,
                            ),
                          ),
                      ],
                      onReorder: (int oldIndex, int newIndex) {
                        print("onReorder = $oldIndex - $newIndex");
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final Baskets item = inboxController
                            .fetchBasketListModel!.baskets!
                            .removeAt(oldIndex);
                        inboxController.fetchBasketListModel!.baskets!
                            .insert(newIndex, item);
                      },
                      onReorderStart: (int index) {
                        //0-1-2-....
                        print("onReorderStart = $index");
                        inboxController.setOldIndex(index);
                      },
                      onReorderEnd: (int index) {
                        controller.setSavingOrder(true);
                        print("onReorderEnd = $index");
                        if (inboxController.fetchBasketListModel!
                                .baskets![index].canBeReOrder ==
                            false) {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message:
                                  "${inboxController.fetchBasketListModel!.baskets![index].name} canBeReOrder = false",
                            ),
                          );
                        } else {
                          if (inboxController.oldIndex != index) {
                            u.showLoaderDialog(context);
                            print(
                                inboxController.fetchBasketListModel?.toJson());
                            controller.reOrderBaskets(
                                context: context,
                                baskets: inboxController
                                    .fetchBasketListModel!.baskets);
                          }
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
            },
            child: Text("Ok".tr),
          ),
          // Visibility(
          //     visible: controller.isSavingOrder,
          //     child: FlatButton(
          //       onPressed: () async {
          //         // Navigator.of(ctx).pop();
          //         // Get.to(BasketPage());
          //       },
          //       child: Text("Save Order"),
          //     )),
          TextButton(
            onPressed: () async {
              //هنا هنكريت الباسكت

              showInputDialog(
                  context, 'CreateNewBasket'.tr, 'default inpit', 'message');
            },
            child: Text("new Basket".tr),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalListViewCircleColors(BuildContext context) {
    List<Color> colorArray = [
      Color(0xFFFF6633),
      Color(0xFFFFB399),
      Color(0xFFFF33FF),
      Color(0xFFFFFF99),
      Color(0xFF00B3E6),
      Color(0xFFE6B333),
      Color(0xFF3366E6),
      Color(0xFF999966),
      Color(0xFF99FF99),
      Color(0xFFB34D4D),
      Color(0xFF80B300),
      Color(0xFF809900),
      Color(0xFFE6B3B3),
      Color(0xFF6680B3),
      Color(0xFF66991A),
      Color(0xFFFF99E6),
      Color(0xFFCCFF1A),
      Color(0xFFFF1A66),
      Color(0xFFE6331A),
      Color(0xFF33FFCC),
      Color(0xFF66994D),
      Color(0xFFB366CC),
      Color(0xFF4D8000),
      Color(0xFFB33300),
      Color(0xFFCC80CC),
      Color(0xFF66664D),
      Color(0xFF991AFF),
      Color(0xFFE666FF),
      Color(0xFF4DB3FF),
      Color(0xFF1AB399),
      Color(0xFFE666B3),
      Color(0xFF33991A),
      Color(0xFFCC9999),
      Color(0xFFB3B31A),
      Color(0xFF00E680),
      Color(0xFF4D8066),
      Color(0xFF809980),
      Color(0xFFE6FF80),
      Color(0xFF1AFF33),
      Color(0xFF999933),
      Color(0xFFFF3380),
      Color(0xFFCCCC00),
      Color(0xFF66E64D),
      Color(0xFF4D80CC),
      Color(0xFF9900B3),
      Color(0xFFE64D66),
      Color(0xFF4DB380),
      Color(0xFFFF4D4D),
      Color(0xFF99E6E6),
      Color(0xFF6666FF)
    ];
    return Container(
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .5,
        // height: 100,
        child:
            // ListView(
            //   scrollDirection: Axis.horizontal,
            //   children: <Widget>[
            //     Container(
            //       width: 60,
            //       height: 60,
            //       // child: Icon(CustomIcons.option, size: 20,),
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: Color(0xFFe0f2f1)),
            //     ),
            //
            //   ],
            // ),
            GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemBuilder: (_, index) => Center(
              child: GestureDetector(
            child: Container(
              width: 60,
              height: 60,
              // child: Icon(CustomIcons.option, size: 20,),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: colorArray[index]),
            ),
            onTap: () {
              var selectedColor = colorArray[index];
              Get.find<CreateBasketController>().setPickerColor(selectedColor);
              Navigator.pop(context);
            },
          )),
          itemCount: colorArray.length,
        ));
  }

  Widget iconAndText(
      {required IconData iconData,
      required String title,
      required Color iconColor}) {
    return Row(
      children: [
        Text(title),
        const SizedBox(
          width: 3,
        ),
        Icon(
          iconData,
          color: iconColor,
        )
      ],
    );
  }

  _popUpMenu(context, thepos) async {
    showLoaderDialog(context);
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
                    // Container(
                    //   height: 100,
                    //   width: MediaQuery.of(context).size.width * .8,
                    //   child: GetBuilder<InboxController>(//autoRemove: false,
                    //
                    //       builder: (logic) {
                    //     return ListView.builder(
                    //         scrollDirection: Axis.horizontal,
                    //         itemCount: (controller.favoriteRecipientsResponse
                    //                     ?.recipients?.length ??
                    //                 0) +
                    //             1,
                    //         itemBuilder: (context, pos) {
                    //           if (pos ==
                    //               (controller.favoriteRecipientsResponse
                    //                       ?.recipients?.length ??
                    //                   0)) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 _popUpMenuMore(context);
                    //               },
                    //               child: Container(
                    //                 padding: EdgeInsets.all(8),
                    //                 child: Icon(Icons.add,
                    //                     size: 30, color: Colors.white),
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color:
                    //                       Theme.of(context).colorScheme.primary,
                    //                 ),
                    //                 height: 75,
                    //                 width: 75,
                    //               ),
                    //             );
                    //           } else {
                    //             return Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   Destination user = Destination(
                    //                       value: controller
                    //                           .favoriteRecipientsResponse!
                    //                           .recipients![pos]
                    //                           .targetName,
                    //                       id: controller
                    //                           .favoriteRecipientsResponse!
                    //                           .recipients![pos]
                    //                           .targetGctid);
                    //                   controller.addTousersWillSendTo(
                    //                       user: user, thepos: thepos);
                    //                 },
                    //                 child: Card(
                    //                   elevation: 8,
                    //                   child: Row(
                    //                     children: [
                    //                       controller
                    //                               .favoriteRecipientsResponse!
                    //                               .recipients![pos]
                    //                               .targetPhotoBs64!
                    //                               .trim()
                    //                               .isEmpty
                    //                           ? Container(
                    //                               padding: EdgeInsets.all(8),
                    //                               decoration: BoxDecoration(
                    //                                   shape: BoxShape.circle,
                    //                                   color: Theme.of(context)
                    //                                       .colorScheme
                    //                                       .primary,
                    //                                   image: DecorationImage(
                    //                                       image: AssetImage(
                    //                                         "assets/images/pr.jpg",
                    //                                       ),
                    //                                       fit: BoxFit.cover)),
                    //                               height: 75,
                    //                               width: 75,
                    //                             )
                    //                           : Container(
                    //                               padding: EdgeInsets.all(8),
                    //                               decoration: BoxDecoration(
                    //                                   shape: BoxShape.circle,
                    //                                   color: Theme.of(context)
                    //                                       .colorScheme
                    //                                       .primary,
                    //                                   image: DecorationImage(
                    //                                       image: MemoryImage(
                    //                                           dataFromBase64String(controller
                    //                                               .favoriteRecipientsResponse!
                    //                                               .recipients![
                    //                                                   pos]
                    //                                               .targetPhotoBs64!)),
                    //                                       fit: BoxFit.cover)),
                    //                               height: 75,
                    //                               width: 75,
                    //                             ),
                    //                       Text(controller
                    //                           .favoriteRecipientsResponse!
                    //                           .recipients![pos]
                    //                           .targetName!)
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           }
                    //
                    //           //  CircleAvatar(backgroundColor: Colors.red,backgroundImage: AssetImage("assets/images/pr.jpg",),,radius: 30,);
                    //         });
                    //   }),
                    // ),

                    Row(
                      children: [
                        GetBuilder<InboxController>(
                            autoRemove: false,
                            builder: (logic) {
                              return Container(
                                // height: 50,
                                // width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                child: DropdownButton<Recipients>(
                                  value: controller.selectlistfavoriteUser,
                                  icon: const Icon(Icons.arrow_downward),
                                  hint: Row(
                                    children: [
                                      Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/pr.jpg")))),
                                      Text("chooseaperson".tr),
                                    ],
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  underline: SizedBox(),
                                  onChanged: (v) {
                                    Destination user = Destination(
                                        value: v!.targetName,
                                        id: v.targetGctid);
                                    controller.addTousersWillSendTo(
                                        user: user, thepos: thepos);
                                  },
                                  items: controller.listfavoriteUser
                                      .map<DropdownMenuItem<Recipients>>(
                                          (Recipients value) {
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
                                                      image: AssetImage(
                                                          "assets/images/pr.jpg")))),
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
                            _popUpMenuMore(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child:
                                Icon(Icons.add, size: 30, color: Colors.white),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            height: 75,
                            width: 75,
                          ),
                        ),
                      ],
                    ),

                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 300, // MediaQuery.of(context).size.height * .5,
                        child: GetBuilder<InboxController>(
                          //autoRemove: false,
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
                                                                      .stopMathod2()
                                                                  : controller
                                                                      .recordMathod2(
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
                                                                      InboxController>(
                                                                  id:
                                                                      "record", //autoRemove: false,
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
                                                                controller.playMathod2(
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

                  controller.multipleTransferspost2(
                      context: context,
                      transferId:
                          controller.allCorrespondences[thepos].transferId!,
                      correspondenceId: controller
                          .allCorrespondences[thepos].correspondenceId);
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
                                child: GetBuilder<InboxController>(
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
                                                        correspondencesId: controller
                                                            .allCorrespondences[
                                                                pos]
                                                            .correspondenceId!,
                                                        transferId: controller
                                                            .allCorrespondences[
                                                                pos]
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

  ///ToDo    الي انا هشتغل عليهههههههههههههههههههههههههه
  List<Widget> addBasketData(BuildContext context) {
    List<Widget> list = [];
    for (int index = 0;
        index < inboxController.fetchBasketListModel!.baskets!.length;
        index += 1) {
      var basket = inboxController.fetchBasketListModel!.baskets![index];
      // for (final basket in inboxController.fetchBasketListModel!.baskets!)
      list.add(ListTile(
        // key: Key('$index'),
        key: ValueKey(basket),
        // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
        onLongPress: !(basket.canBeReOrder ?? false)
            ? () {
                print(basket.iD);
              }
            : null,
        onTap: !(basket.canBeReOrder ?? false)
            ? () async {
                print(basket.iD);
                showLoaderDialog(context);
                // Get
                //     .find<
                //     InboxController>()
                //     .listSelectCorrespondences
                //     .add(int
                //     .parse(
                //     correspondences[index]
                //         .correspondenceId!));
                Get.back();
                await Get.find<InboxController>().addDocumentsToBasket(
                    context: context, basketId: basket.iD);
              }
            : null,
        enabled: !(basket.canBeReOrder ?? false),
        enableFeedback: !(basket.canBeReOrder ?? false),
        title: Card(
          elevation: 10,
          color: basket.color?.toColor(),
          child: Column(children: [
            Text(basket.name ?? ""),
            Text(basket.nameAr ?? ""),
            // Text( "color :${inboxController
            //     .fetchBasketListModel
            //     ?.baskets?[pos].color}",style: TextStyle( color:  HexColor(inboxController
            //     .fetchBasketListModel
            //     ?.baskets?[pos].color??"#000000"))),

            GestureDetector(
              onTap: () {
                //هنا هنعمل دليت
                _showMyDialogDeleteConfirm(context, basket);

                // showTopSnackBar(
                // icon: Container(),
                //   context,
                //   CustomSnackBar.success(
                // backgroundColor: Colors.lightGreen,
                //     message:
                //     "Good job, basket have been deleted",
                //   ),
                // );
              },
              // child:  Icon(Icons.delete, color: (basket.canBeReOrder ?? false) ? Colors.black: Colors.transparent,) ,
              child: (basket.canBeReOrder ?? false)
                  ? Icon(Icons.delete)
                  : Container(),
            ),
          ]),
        ),
      ));
    }
    return list; // all widget added now retrun the list here
  }
}
