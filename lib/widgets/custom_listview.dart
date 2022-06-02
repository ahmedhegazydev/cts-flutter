import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';

import '../models/CorrespondencesModel.dart';
import '../services/json_model/login_model.dart';
import '../utility/utilitie.dart';

class CustomListView extends StatelessWidget {
  CustomListView(
      {required this.function,    required this.allCorrespondences,
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
  List<Correspondences> allCorrespondences;
  ScrollController scrollController;
  bool haveMoreData = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => function,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 80,
              child: TabBar(onTap: (index) {}, tabs: [
                Tab(
                  icon: Icon(
                    Icons.mark_email_unread,
                    color: Colors.black,
                  ),
                  child: Text("new", style: TextStyle(color: Colors.black)),
                  // text: "all",
                ),
                Tab(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  child: Text("all", style: TextStyle(color: Colors.black)),
                  // text: "all",
                ),
              ]),
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, pos) {
                      if (pos < correspondences.length) {
                        // print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");
                        return
                            // correspondences[pos].isNew??false?

                            InkWell(
                          onTap: () {
                            Get.find<InboxController>().canOpenDoc(
                                correspondenceId:
                                    correspondences[pos].correspondenceId,
                                transferId: correspondences[pos].transferId);
                            Get.find<DocumentController>().correspondences =
                                correspondences[pos];

                            Get.find<DocumentController>().loadPdf();
                            //  Get.find<DocumentController>().loadPdf();
                            Get.toNamed("/DocumentPage");
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
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: correspondences[pos]
                                                    .gridInfo
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              .1,
                                                          child: Text(
                                                            correspondences[pos]
                                                                .gridInfo?[
                                                            index]
                                                                .label ??
                                                                "",
                                                            softWrap: true,
                                                            maxLines: 3,
                                                          )),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          // width: MediaQuery.of(
                                                          //     context)
                                                          //     .size
                                                          //     .width *
                                                          //     .3,
                                                          child: Text(
                                                            correspondences[pos]
                                                                .gridInfo?[
                                                            index]
                                                                .value ??
                                                                "",
                                                            softWrap: true,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );

                                                  // Column(
                                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                                  //     children: [
                                                  //       // Text(correspondences[pos].fromStructure ??
                                                  //       //     ""),
                                                  //       Row(
                                                  //         mainAxisAlignment:
                                                  //         MainAxisAlignment.spaceBetween,
                                                  //         children: [
                                                  //           Text(correspondences[pos]. ??
                                                  //               ""),
                                                  //           Text(correspondences[pos].docDueDate ??
                                                  //               " "),
                                                  //         ],
                                                  //       ),
                                                  //       Row(
                                                  //         mainAxisAlignment:
                                                  //         MainAxisAlignment.spaceBetween,
                                                  //         children: [
                                                  //           Text(correspondences[pos].docDueDate ??
                                                  //               ""),
                                                  //         ],
                                                  //       ),
                                                  //       Row(
                                                  //         children: [
                                                  //           if (correspondences[pos]
                                                  //               .isHighPriority ??
                                                  //               false)
                                                  //             iconAndText(
                                                  //                 iconColor: AppColor,
                                                  //                 iconData: Icons.lock,
                                                  //                 title: 'secret'.tr),
                                                  //           if (correspondences[pos].isLocked ??
                                                  //               false)
                                                  //             iconAndText(
                                                  //                 iconColor: AppColor,
                                                  //                 iconData:
                                                  //                 Icons.person_add_disabled,
                                                  //                 title: 'closed'.tr),
                                                  //         ],
                                                  //       )
                                                  //     ]);
                                                }),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(correspondences[pos]
                                                        .isLocked!
                                                    ? Icons.lock
                                                    : Icons.lock_open),
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color: correspondences[
                                                                      pos]
                                                                  .priorityId ==
                                                              "1"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      shape: BoxShape.circle),
                                                )

                                                //   correspondences[pos].priorityId
                                                //  correspondences[pos].purposeId

                                                ,
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(correspondences[pos]
                                                        .fromUser ??
                                                    ""),
                                                if (correspondences[pos]
                                                        .hasAttachments ??
                                                    false)
                                                  Icon(Icons.attachment),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.forward_rounded,
                                                        color: Colors.orange),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text("Reply"),
                                                  ],
                                                ),
                                                value: 1,
                                                onTap: functionReply,
                                              ),
                                              PopupMenuItem(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.account_circle,
                                                        color: Colors.red),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text("Transfar"),
                                                  ],
                                                ),
                                                value: 2,
                                                onTap: functionTrunsfer,
                                              ),
                                              PopupMenuItem(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.bookmark,
                                                        color: Colors.orange),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text("Complete"),
                                                  ],
                                                ),
                                                onTap: functionComplet,
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
                                                      Text("Summary"),
                                                    ],
                                                  ),
                                                  onTap: functionSummary,
                                                  value: 4,
                                                ),
                                            ],
                                        enableFeedback: true,
                                        onSelected: (v) {
                                          print("*" * 50);
                                          print(correspondences[pos]
                                              .hasSummaries);
                                          print(correspondences[pos]
                                              .correspondenceId);

                                          print(
                                              correspondences[pos].transferId);

                                          print("*" * 50);

                                          if (v == 1) {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text(" "),
                                                content: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .8,
                                                    color: Colors.grey[200],
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(children: [
                                                        Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                    correspondences[pos]
                                                                            .fromUser ??
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
                                                                "الاسم",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline3!
                                                                    .copyWith(
                                                                      color:
                                                                          createMaterialColor(
                                                                        const Color.fromRGBO(
                                                                            77,
                                                                            77,
                                                                            77,
                                                                            1),
                                                                      ),
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Spacer(),
                                                              GestureDetector(
                                                                onTap: () {},
                                                                child:
                                                                    Image.asset(
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
                                                              child: Text(
                                                                  "action".tr),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                  "audioNotes"
                                                                      .tr),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height: 40,
                                                                color: Colors
                                                                    .grey[300],
                                                                child: DropdownButton<
                                                                    CustomActions>(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  //   value: CustomActions,
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .arrow_downward),
                                                                  elevation: 16,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .deepPurple),
                                                                  underline:
                                                                      Container(
                                                                    height: 2,
                                                                    color: Colors
                                                                        .deepPurpleAccent,
                                                                  ),
                                                                  hint: Text(
                                                                      "اختار"),
                                                                  onChanged:
                                                                      (CustomActions?
                                                                          newValue) {
                                                                    //  dropdownValue = newValue!;
                                                                  },
                                                                  items: customActions?.map<
                                                                      DropdownMenuItem<
                                                                          CustomActions>>((CustomActions
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                        CustomActions>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value
                                                                              .name!),
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
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          Get.find<InboxController>().recording
                                                                              ? Get.find<InboxController>().stop2()
                                                                              : Get.find<InboxController>().record2();
                                                                          Get.find<InboxController>()
                                                                              .update([
                                                                            "id"
                                                                          ]);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: GetBuilder<InboxController>(
                                                                              id: "id",
                                                                              builder: (logic) {
                                                                                print("5555");
                                                                                return Icon(Get.find<InboxController>().recording ? Icons.stop : Icons.mic);
                                                                              }),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            // controller
                                                                            //     .playRec();
                                                                          },
                                                                          child:
                                                                              Icon(Icons.play_arrow),
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
                                                            maxLines: 4,
                                                          ),
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text("Ok"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else if (v == 2) {
                                          }
                                          else if (v == 3) {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text(" "),
                                                content: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .8,
                                                    color: Colors.grey[200],
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                  "action".tr),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 40,
                                                              color: Colors
                                                                  .grey[300],
                                                              child: GetBuilder<
                                                                  InboxController>(
                                                                assignId: true,
                                                                builder:
                                                                    (logic) {
                                                                  return DropdownButton<
                                                                      CustomActions>(
                                                                    value: Get.find<
                                                                            InboxController>()
                                                                        .completeCustomActions,
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    //   value: CustomActions,
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .arrow_downward),
                                                                    elevation:
                                                                        16,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .deepPurple),
                                                                    underline:
                                                                        Container(
                                                                      height: 2,
                                                                      color: Colors
                                                                          .deepPurpleAccent,
                                                                    ),
                                                                    hint: Text(
                                                                        "اختار"),
                                                                    onChanged:
                                                                        (CustomActions?
                                                                            newValue) {
                                                                      logic.updatecompleteCustomActions(
                                                                          newValue!);
                                                                    },
                                                                    items: logic
                                                                        .customActions
                                                                        ?.map<
                                                                            DropdownMenuItem<
                                                                                CustomActions>>((CustomActions
                                                                            value) {
                                                                      return DropdownMenuItem<
                                                                          CustomActions>(
                                                                        value:
                                                                            value,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            //  Image.memory(dataFromBase64String(value.icon!)),
                                                                            SizedBox(
                                                                              width: 4,
                                                                            ),
                                                                            Text(value.name!),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Container(
                                                          child: TextFormField(
                                                            maxLines: 4,
                                                          ),
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      print(Get.find<
                                                              InboxController>()
                                                          .completeCustomActions
                                                          ?.name);
                                                      print(Get.find<
                                                              InboxController>()
                                                          .completeCustomActions
                                                          ?.icon);

                                                      String data =
                                                          'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${  correspondences[pos]
                                                          .correspondenceId}&transferId=${    correspondences[pos]
                                                          .transferId}&actionType=${Get.find<InboxController>().completeCustomActions?.name??""}&note=${Get.find<InboxController>().completeNote}&language=${Get.locale
                                                          ?.languageCode == "en"
                                                          ? "en"
                                                          : "ar"}';

                                                      Get.find<
                                                              InboxController>()
                                                          .completeInCorrespondence(data: data);


                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text("Ok"),
                                                  ),
                                                ],
                                              ),
                                            );

                                            print(Get.find<InboxController>()
                                                .customAction
                                                ?.name);
                                          } else if (v == 4) {
                                            //correspondences[pos].

                                          }

                                          print("the val idssss");
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
                ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, pos) {
                      if (pos < allCorrespondences.length) {
                        //  print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");
                        return InkWell(
                          onTap: () {
                            Get.find<InboxController>().canOpenDoc(
                                correspondenceId:
                                allCorrespondences[pos].correspondenceId,
                                transferId: allCorrespondences[pos].transferId);
                            Get.find<DocumentController>().correspondences =
                            allCorrespondences[pos];

                            Get.find<DocumentController>().loadPdf();
                            Get.toNamed("/DocumentPage");
                          },
                          child: SizedBox(
                            //height: MediaQuery.of(context).size.height*.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: allCorrespondences[pos]
                                                  .gridInfo
                                                  ?.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .1,
                                                        child: Text(
                                                            allCorrespondences[pos]
                                                                    .gridInfo?[
                                                                        index]
                                                                    .label ??
                                                                "")),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        // width: MediaQuery.of(
                                                        //   context)
                                                        //   .size
                                                        //   .width *
                                                        //   .5,
                                                        child: Text(allCorrespondences[pos]
                                                                .gridInfo?[index]
                                                                .value ??
                                                            ""),
                                                      ),
                                                    ),
                                                  ],
                                                );

                                                // Column(
                                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                                //     children: [
                                                //       // Text(correspondences[pos].fromStructure ??
                                                //       //     ""),
                                                //       Row(
                                                //         mainAxisAlignment:
                                                //         MainAxisAlignment.spaceBetween,
                                                //         children: [
                                                //           Text(correspondences[pos]. ??
                                                //               ""),
                                                //           Text(correspondences[pos].docDueDate ??
                                                //               " "),
                                                //         ],
                                                //       ),
                                                //       Row(
                                                //         mainAxisAlignment:
                                                //         MainAxisAlignment.spaceBetween,
                                                //         children: [
                                                //           Text(correspondences[pos].docDueDate ??
                                                //               ""),
                                                //         ],
                                                //       ),
                                                //       Row(
                                                //         children: [
                                                //           if (correspondences[pos]
                                                //               .isHighPriority ??
                                                //               false)
                                                //             iconAndText(
                                                //                 iconColor: AppColor,
                                                //                 iconData: Icons.lock,
                                                //                 title: 'secret'.tr),
                                                //           if (correspondences[pos].isLocked ??
                                                //               false)
                                                //             iconAndText(
                                                //                 iconColor: AppColor,
                                                //                 iconData:
                                                //                 Icons.person_add_disabled,
                                                //                 title: 'closed'.tr),
                                                //         ],
                                                //       )
                                                //     ]);
                                              })),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(allCorrespondences[pos].isLocked!
                                                ? Icons.lock
                                                : Icons.lock_open),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: allCorrespondences[pos]
                                                              .priorityId ==
                                                          "1"
                                                      ? Colors.green
                                                      : Colors.red,
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                                allCorrespondences[pos].fromUser ??
                                                    ""),
                                            if (allCorrespondences[pos]
                                                    .hasAttachments ??
                                                false)
                                              Icon(Icons.attachment),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                PopupMenuButton(
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.forward_rounded,
                                                    color: Colors.orange),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text("Reply"),
                                              ],
                                            ),
                                            value: 1,
                                            onTap: functionReply,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.account_circle,
                                                    color: Colors.red),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text("Transfar"),
                                              ],
                                            ),
                                            value: 2,
                                            onTap: functionTrunsfer,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.bookmark,
                                                    color: Colors.orange),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text("Complete"),
                                              ],
                                            ),
                                            onTap: functionComplet,
                                            value: 3,
                                          ),
                                      if (allCorrespondences[pos]
                                          .hasSummaries ??
                                          false)          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(Icons.menu,
                                                    color: Colors.blueAccent),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text("Summary"),
                                              ],
                                            ),
                                            onTap: functionSummary,
                                            value: 4,
                                          ),
                                        ], enableFeedback: true,
                                    onSelected: (v) {
                                      print("*" * 50);
                                      print(allCorrespondences[pos]
                                          .hasSummaries);
                                      print(allCorrespondences[pos]
                                          .correspondenceId);

                                      print(
                                          allCorrespondences[pos].transferId);

                                      print("*" * 50);

                                      if (v == 1) {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text(" "),
                                            content: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Container(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    .8,
                                                color: Colors.grey[200],
                                                child:
                                                SingleChildScrollView(
                                                  child: Column(children: [
                                                    Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(
                                                                8.0),
                                                            child: Text(
                                                                allCorrespondences[pos]
                                                                    .fromUser ??
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
                                                            "الاسم",
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .headline3!
                                                                .copyWith(
                                                              color:
                                                              createMaterialColor(
                                                                const Color.fromRGBO(
                                                                    77,
                                                                    77,
                                                                    77,
                                                                    1),
                                                              ),
                                                              fontSize:
                                                              15,
                                                            ),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                          ),
                                                          Spacer(),
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child:
                                                            Image.asset(
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
                                                          child: Text(
                                                              "action".tr),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                              "audioNotes"
                                                                  .tr),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 40,
                                                            color: Colors
                                                                .grey[300],
                                                            child: DropdownButton<
                                                                CustomActions>(
                                                              alignment:
                                                              Alignment
                                                                  .topRight,
                                                              //   value: CustomActions,
                                                              icon: const Icon(
                                                                  Icons
                                                                      .arrow_downward),
                                                              elevation: 16,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .deepPurple),
                                                              underline:
                                                              Container(
                                                                height: 2,
                                                                color: Colors
                                                                    .deepPurpleAccent,
                                                              ),
                                                              hint: Text(
                                                                  "اختار"),
                                                              onChanged:
                                                                  (CustomActions?
                                                              newValue) {
                                                                //  dropdownValue = newValue!;
                                                              },
                                                              items: customActions?.map<
                                                                  DropdownMenuItem<
                                                                      CustomActions>>((CustomActions
                                                              value) {
                                                                return DropdownMenuItem<
                                                                    CustomActions>(
                                                                  value:
                                                                  value,
                                                                  child: Text(
                                                                      value
                                                                          .name!),
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
                                                              color: Colors
                                                                  .grey[
                                                              300],
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      Get.find<InboxController>().recording
                                                                          ? Get.find<InboxController>().stop2()
                                                                          : Get.find<InboxController>().record2();
                                                                      Get.find<InboxController>()
                                                                          .update([
                                                                        "id"
                                                                      ]);
                                                                    },
                                                                    child:
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.all(8.0),
                                                                      child: GetBuilder<InboxController>(
                                                                          id: "id",
                                                                          builder: (logic) {
                                                                            print("5555");
                                                                            return Icon(Get.find<InboxController>().recording ? Icons.stop : Icons.mic);
                                                                          }),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(8.0),
                                                                    child:
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // controller
                                                                        //     .playRec();
                                                                      },
                                                                      child:
                                                                      Icon(Icons.play_arrow),
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
                                                        maxLines: 4,
                                                      ),
                                                      color:
                                                      Colors.grey[300],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text("Ok"),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (v == 2) {
                                      }
                                      else if (v == 3) {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text(" "),
                                            content: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Container(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    .8,
                                                color: Colors.grey[200],
                                                child:
                                                SingleChildScrollView(
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                              "action".tr),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          color: Colors
                                                              .grey[300],
                                                          child: GetBuilder<
                                                              InboxController>(
                                                            assignId: true,
                                                            builder:
                                                                (logic) {
                                                              return DropdownButton<
                                                                  CustomActions>(
                                                                value: Get.find<
                                                                    InboxController>()
                                                                    .completeCustomActions,
                                                                alignment:
                                                                Alignment
                                                                    .topRight,
                                                                //   value: CustomActions,
                                                                icon: const Icon(
                                                                    Icons
                                                                        .arrow_downward),
                                                                elevation:
                                                                16,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .deepPurple),
                                                                underline:
                                                                Container(
                                                                  height: 2,
                                                                  color: Colors
                                                                      .deepPurpleAccent,
                                                                ),
                                                                hint: Text(
                                                                    "اختار"),
                                                                onChanged:
                                                                    (CustomActions?
                                                                newValue) {
                                                                  logic.updatecompleteCustomActions(
                                                                      newValue!);
                                                                },
                                                                items: logic
                                                                    .customActions
                                                                    ?.map<
                                                                    DropdownMenuItem<
                                                                        CustomActions>>((CustomActions
                                                                value) {
                                                                  return DropdownMenuItem<
                                                                      CustomActions>(
                                                                    value:
                                                                    value,
                                                                    child:
                                                                    Row(
                                                                      children: [
                                                                        //  Image.memory(dataFromBase64String(value.icon!)),
                                                                        SizedBox(
                                                                          width: 4,
                                                                        ),
                                                                        Text(value.name!),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      child: TextFormField(
                                                        maxLines: 4,
                                                      ),
                                                      color:
                                                      Colors.grey[300],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  print(Get.find<
                                                      InboxController>()
                                                      .completeCustomActions
                                                      ?.name);
                                                  print(Get.find<
                                                      InboxController>()
                                                      .completeCustomActions
                                                      ?.icon);

                                                  String data =
                                                      'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${  allCorrespondences[pos]
                                                      .correspondenceId}&transferId=${    allCorrespondences[pos]
                                                      .transferId}&actionType=${Get.find<InboxController>().completeCustomActions?.name??""}&note=${Get.find<InboxController>().completeNote}&language=${Get.locale
                                                      ?.languageCode == "en"
                                                      ? "en"
                                                      : "ar"}';

                                                  Get.find<
                                                      InboxController>()
                                                      .completeInCorrespondence(data: data);


                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text("Ok"),
                                              ),
                                            ],
                                          ),
                                        );

                                        print(Get.find<InboxController>()
                                            .customAction
                                            ?.name);
                                      } else if (v == 4) {
                                        //correspondences[pos].

                                      }

                                      print("the val idssss");
                                    })
                              ],
                            ),
                          ),
                        );
                      } else {
                        return haveMoreData
                            ? SizedBox(
                                height: 50,
                                width: 50,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : SizedBox();
                      }
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: allCorrespondences.length + 1),
              ]),
            )
          ],
        ),
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
}
