
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';

import '../models/CorrespondencesModel.dart';


class CustomListView extends StatelessWidget {
  CustomListView(
      {required this.function,
      required this.correspondences,
      required this.scrollController,
      required this.haveMoreData,
      required this.onClickItem});

  Future<void> function;

  VoidCallback onClickItem;
  List<Correspondences> correspondences;
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
                          correspondences[pos].isNew??false?



                          InkWell(
                          onTap: () {
                            Get.find<InboxController>().canOpenDoc(
                                correspondenceId:
                                    correspondences[pos].correspondenceId,
                                transferId: correspondences[pos].transferId);
                            Get.find<DocumentController>().correspondences =
                                correspondences[pos]  ;

                            Get.find<DocumentController>().loadPdf();
                            //  Get.find<DocumentController>().loadPdf();
                            Get.toNamed("/DocumentPage");
                          },
                          child: SizedBox(
                            //height: MediaQuery.of(context).size.height*.3,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .1,
                                                    child: Text(correspondences[
                                                                pos]
                                                            .gridInfo?[index]
                                                            .label ??
                                                        "")),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(correspondences[pos]
                                                        .gridInfo?[index]
                                                        .value ??
                                                    ""),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(correspondences[pos].isLocked!
                                              ? Icons.lock
                                              : Icons.lock_open),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: correspondences[pos]
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
                                          Text(correspondences[pos].fromUser ??
                                              ""),
                                          if (correspondences[pos]
                                                  .hasAttachments ??
                                              false)
                                            Icon(Icons.attachment),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ):SizedBox();
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
                      if (pos < correspondences.length) {
                        //  print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");
                        return Dismissible( background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                            key: UniqueKey() ,
                          onDismissed: (direction) {

                          },

                          child: InkWell(
                            onTap: () {
                              Get.find<InboxController>().canOpenDoc(
                                  correspondenceId:
                                      correspondences[pos].correspondenceId,
                                  transferId: correspondences[pos].transferId);
                              Get.find<DocumentController>().correspondences =
                                  correspondences[pos] ;

                              Get.find<DocumentController>().loadPdf();
                              Get.toNamed("/DocumentPage");
                            },
                            child: SizedBox(
                              //height: MediaQuery.of(context).size.height*.3,
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
                                              children: [
                                                Container(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .1,
                                                    child: Text(
                                                        correspondences[pos]
                                                                .gridInfo?[index]
                                                                .label ??
                                                            "")),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(correspondences[pos]
                                                        .gridInfo?[index]
                                                        .value ??
                                                    ""),
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
                                        Icon(correspondences[pos].isLocked!
                                            ? Icons.lock
                                            : Icons.lock_open),

                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: correspondences[pos]
                                                          .priorityId ==
                                                      "1"
                                                  ? Colors.green
                                                  : Colors.red,
                                              shape: BoxShape.circle),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(correspondences[pos].fromUser ?? ""),
                                        if (correspondences[pos].hasAttachments ??
                                            false)
                                          Icon(Icons.attachment),
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                    itemCount: correspondences.length + 1),
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
