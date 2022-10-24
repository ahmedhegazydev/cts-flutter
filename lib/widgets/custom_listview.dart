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

import 'hourizontal_list_view_colors.dart';

class CustomListView extends GetView<InboxController> {
  CustomListView(
      {this.function,
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

  Future<void>? function;

  VoidCallback onClickItem;
  List<Correspondence> correspondences;
  //List<Correspondences> allCorrespondences;
  ScrollController scrollController;
  bool haveMoreData = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    Get.put(DocumentController());
    var r = Get.find<InboxController>().correspondencesModel;
    // return Container(color: Colors.pink);
    return Container(
      height: height - 100,
      child: RefreshIndicator(
        onRefresh: () => function!,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, pos) {
                      if (pos < correspondences.length) {
                        return InkWell(
                          onTap: () async {
                            var correspondence = correspondences[pos];
                            controller.openDocument(
                              context: context,
                              correspondence: correspondence,
                            );
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
                                                      // softWrap: true,
                                                      // maxLines: 2,
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
                                                                                  if (Get.find<DocumentController>().record.isRecording) {
                                                                                    print(" ايقاف التشغيل");
                                                                                    Get.find<DocumentController>().stopMathod();
                                                                                  } else {
                                                                                    print(" بداء  التشغيل");
                                                                                    Get.find<DocumentController>().recordMathod(id: 222);
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
                                                                                  child: GetBuilder<DocumentController>(
                                                                                      id: "id",
                                                                                      builder: (logic) {
                                                                                        return Icon(Get.find<DocumentController>().recording ? Icons.stop : Icons.mic);
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
                                                                                    if (!Get.find<DocumentController>().isPlayingAudio.value)
                                                                                      Get.find<DocumentController>().playMathod(id: 222);
                                                                                    else {
                                                                                      Get.find<DocumentController>().isPlayingAudio.value = false;
                                                                                      Get.find<DocumentController>().audioPlayer!.stopPlayer();
                                                                                    }
                                                                                  },
                                                                                  child: Icon(Get.find<DocumentController>().isPlayingAudio.value ? Icons.stop : Icons.play_arrow),
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
                                                                          DocumentController>()
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

                                                var corresp = controller
                                                    .allCorrespondences[pos];
                                                Get.find<DocumentController>()
                                                    .transferPopup(
                                                  context,
                                                  corresp.transferId!,
                                                  corresp.correspondenceId!,
                                                );
                                              } else if (v == 3) {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Row(
                                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
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
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineMedium!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .5),
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            textAlign: TextAlign
                                                                .center,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const Spacer(),
                                                          InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .filterWord = "";
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/close_button.png',
                                                              width: 30,
                                                              height: 30,
                                                            ),
                                                          ),
                                                        ]),
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
                                                                    controller:
                                                                        controller
                                                                            .completeNote,
                                                                    onChanged:
                                                                        (v) {
                                                                      Get.find<
                                                                              InboxController>()
                                                                          .completeNote
                                                                          .text = v;
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
                                                              'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${correspondences[pos].correspondenceId}&transferId=${correspondences[pos].transferId}&actionType=Complete&note=${Get.find<InboxController>().completeNote.text}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';
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
                                                        child: Text(
                                                          "ending".tr,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else if (v == 4) {
                                                //correspondences[pos].

                                              } else if (v == 5) {
                                                await showAllBasketsDialog(
                                                    context);
                                                await Get.find<
                                                        InboxController>()
                                                    .getFetchBasketList(
                                                        context: null);
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
          // if (correspondences[pos].showLock!)
          //   Icon(correspondences[pos].isLocked! ? Icons.lock : Icons.lock_open,
          //       color: Theme.of(context).colorScheme.primary),

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

  Future<String?> showInputDialog(
      BuildContext context, String title, String defaultInput, String message) {
    var textController = TextEditingController(text: defaultInput);
    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Text(message), TextField(controller: textController)
        // CreateNewBasket(),

        Form(
            child: Column(
          children: [
            Container(
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
                                await Get.find<InboxController>()
                                    .addDocumentsToBasket(
                                        context: context, basketId: basket.iD);
                              },
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
