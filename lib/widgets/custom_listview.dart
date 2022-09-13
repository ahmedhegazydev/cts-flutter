import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';

import '../models/CorrespondencesModel.dart';
import '../services/apis/reply_with_voice_note_api.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/reply_with_voicenote_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../utility/all_const.dart';
import '../utility/utilitie.dart';
import 'custom_button_with_icon.dart';

class CustomListView extends GetView<InboxController> {
  CustomListView(
      {required this.function,
      required this.allCorrespondences,
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
//             Container(
//               height: 80,
//               child: TabBar(
//                   onTap: (index) {
//                     print("the index of oo=> $index");
//                   },
//                   tabs: [
//                     Tab(
//                       icon: Icon(
//                         Icons.mark_email_unread,
//                         color: Colors.black,
//                       ),
//                       child:
//                       Text("new".tr, style: TextStyle(color: Colors.black)),
//                       // text: "all",
//                     ),
//                     Tab(
//                       icon: Icon(
//                         Icons.email_outlined,
//                         color: Colors.black,
//                       ),
//                       child:
//                       Text("All".tr, style: TextStyle(color: Colors.black)),
//                       // text: "all",
//                     ),
//                   ]),
//             ),
//             Expanded(
//               child: TabBarView(children: [
//                 Column(
//                   children: [
//                     Container(
//                         color: Colors.grey,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               width: 4,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) =>
//                                       AlertDialog(
//                                         title: Text(" "),
//                                         content: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Container(
//                                               width: MediaQuery
//                                                   .of(context)
//                                                   .size
//                                                   .width *
//                                                   .3,
//                                               color: Colors.grey[200],
//                                               child: GetBuilder<
//                                                   InboxController>(
//                                                   builder: (logic) {
//                                                     return SingleChildScrollView(
//                                                       child: Column(
//                                                         children: [
//                                                           Text("الغاية"),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[0]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[0],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[1]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[1],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[2]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[2],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[3]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[3],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(
//                                                                 8.0),
//                                                             child: TextField(
//                                                               controller: logic
//                                                                   .textEditingControllerFilter,
//                                                               decoration:
//                                                               InputDecoration(
//                                                                 hintText: "اخري",
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 30,
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(
//                                                                 8.0),
//                                                             child: Divider(
//                                                                 height: 2,
//                                                                 thickness: 2),
//                                                           ),
//                                                           Text("النوع"),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts2[0]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts2[0],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts2pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts2,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts2[1]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts2[1],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts2pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts2,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts2[2]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts2[2],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts2pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts2,
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(
//                                                                 8.0),
//                                                             child: Divider(
//                                                                 height: 2,
//                                                                 thickness: 2),
//                                                           ),
//                                                           Text("الاولوية"),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts3[0]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts3[0],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts3pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts3,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts3[1]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts3[1],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts3pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts3,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts3[2]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts3[2],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts3pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts3,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                         ),
//                                         actions: <Widget>[
//                                           FlatButton(
//                                             onPressed: () async {
//                                               /// ToDo send Replay
//
//                                               Navigator.of(ctx).pop();
//                                             },
//                                             child: Text("تطبيق"),
//                                           ),
//                                           FlatButton(
//                                             onPressed: () async {
//                                               /// ToDo send Replay
//                                               ///  Navigator.of(
//                                               //                         ctx)
//                                               //                         .pop();
//                                               //    Navigator.of(ctx).pop();
//                                               Get.find<InboxController>()
//                                                   .canceldata();
//                                             },
//                                             child: Text("الغاء"),
//                                           ),
//                                         ],
//                                       ),
//                                 );
//                               },
//                               child: Text("filter".tr,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.find<InboxController>().setEdit();
//                               },
//                               child: Text(
//                                   Get
//                                       .find<InboxController>()
//                                       .edit
//                                       ? "back".tr
//                                       : "Modify".tr,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                           ],
//                         )),
//                     Expanded(
//                       child: ListView.separated(
//                           controller: scrollController,
//                           itemBuilder: (context, pos) {
//                             if (pos < correspondences.length) {
//                               // print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");
//
//                               return
//                                 // correspondences[pos].isNew??false?
//
//                                 InkWell(
//                                   onTap: () {
//                                     Get.find<InboxController>().canOpenDoc(
//                                         context: context,
//                                         docId: correspondences[pos].purposeId,
//                                         correspondenceId:
//                                         correspondences[pos].correspondenceId,
//                                         transferId:
//                                         correspondences[pos].transferId);
//
//                                     Get
//                                         .find<DocumentController>()
//                                         .pdfViewerkey =
//                                     null;
//                                     // Get.find<InboxController>().openfilee(docId: correspondences[pos].purposeId, correspondenceId: correspondences[pos]
//                                     //     .correspondenceId, transferId:  correspondences[pos].transferId);
//
//                                     Get
//                                         .find<DocumentController>()
//                                         .correspondences = correspondences[pos];
//
//                                     //  Get.find<DocumentController>().loadPdf();
//                                     Get.find<DocumentController>()
//                                         .gatAllDataAboutDOC(
//                                         context: context,
//                                         docId:
//                                         correspondences[pos].purposeId!,
//                                         correspondenceId: correspondences[pos]
//                                             .correspondenceId!,
//                                         transferId:
//                                         correspondences[pos].transferId!);
//                                     Get.find<DocumentController>()
//                                         .g2gInfoForExport(
//                                         context: context,
//                                         documentId: correspondences[pos]
//                                             .correspondenceId!);
//                                     //  Get.find<DocumentController>().loadPdf();
//                                     //Get.toNamed("/DocumentPage");
//                                   },
//                                   child: SizedBox(
//                                     //height: MediaQuery.of(context).size.height*.3,
//                                     child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                               child: Column(
//                                                 children: [
//                                                   // Padding(
//                                                   //   padding:
//                                                   //   const EdgeInsets.all(8.0),
//                                                   //   child: ListView.builder(
//                                                   //       shrinkWrap: true,
//                                                   //       itemCount:
//                                                   //       correspondences[pos]
//                                                   //           .gridInfo
//                                                   //           ?.length,
//                                                   //       itemBuilder:
//                                                   //           (context, index) {
//                                                   //         return Row(
//                                                   //           crossAxisAlignment:
//                                                   //           CrossAxisAlignment
//                                                   //               .start,
//                                                   //           mainAxisAlignment:
//                                                   //           MainAxisAlignment
//                                                   //               .start,
//                                                   //           children: [
//                                                   //             // Container(
//                                                   //             //     width: MediaQuery.of(
//                                                   //             //                 context)
//                                                   //             //             .size
//                                                   //             //             .width *
//                                                   //             //         .1,
//                                                   //             //     child: Text(
//                                                   //             //       correspondences[
//                                                   //             //                   pos]
//                                                   //             //               .gridInfo?[
//                                                   //             //                   index]
//                                                   //             //               .label ??
//                                                   //             //           "",
//                                                   //             //       softWrap:
//                                                   //             //           true,
//                                                   //             //       maxLines: 3,
//                                                   //             //     )),
//                                                   //             // SizedBox(
//                                                   //             //   width: 8,
//                                                   //             // ),
//                                                   //
//                                                   //
//                                                   //    index==0?         Container(height: 20,width: 20,
//                                                   //               decoration: BoxDecoration(
//                                                   //                   color: Theme
//                                                   //                       .of(
//                                                   //                       context)
//                                                   //                       .colorScheme
//                                                   //                       .primary,shape: BoxShape.circle),):    Padding(
//                                                   //      padding: const EdgeInsets.all(8.0),
//                                                   //      child: Container(height: 10,width: 10,
//                                                   //        decoration: BoxDecoration(
//                                                   //           shape: BoxShape.circle),),
//                                                   //    ),SizedBox(width: 8,),
//                                                   //             index==0?    Expanded(
//                                                   //               child: Container(
//                                                   //                 // width: MediaQuery.of(
//                                                   //                 //     context)
//                                                   //                 //     .size
//                                                   //                 //     .width *
//                                                   //                 //     .3,
//                                                   //                 child:
//                                                   //                 Text(
//                                                   //                   correspondences[
//                                                   //                   pos]
//                                                   //                       .gridInfo?[
//                                                   //                   index]
//                                                   //                       .value ??
//                                                   //                       "",
//                                                   //                   softWrap:
//                                                   //                   true,
//                                                   //                   maxLines: 3,
//                                                   //                 ),
//                                                   //               ),
//                                                   //             ):
//                                                   //
//                                                   //             Expanded(
//                                                   //               child: Container(
//                                                   //                 // width: MediaQuery.of(
//                                                   //                 //     context)
//                                                   //                 //     .size
//                                                   //                 //     .width *
//                                                   //                 //     .3,
//                                                   //                 child: Text(
//                                                   //
//                                                   //                       "${     correspondences[
//                                                   //                       pos]
//                                                   //                           .gridInfo?[
//                                                   //                       index]
//                                                   //                           .value}",
//                                                   //                   softWrap:
//                                                   //                   true,
//                                                   //                   maxLines: 3,
//                                                   //                 ),
//                                                   //               ),
//                                                   //             )
//                                                   //             ,
//                                                   //           ],
//                                                   //         );
//                                                   //
//                                                   //         // Column(
//                                                   //         //     crossAxisAlignment: CrossAxisAlignment.start,
//                                                   //         //     children: [
//                                                   //         //       // Text(correspondences[pos].fromStructure ??
//                                                   //         //       //     ""),
//                                                   //         //       Row(
//                                                   //         //         mainAxisAlignment:
//                                                   //         //         MainAxisAlignment.spaceBetween,
//                                                   //         //         children: [
//                                                   //         //           Text(correspondences[pos]. ??
//                                                   //         //               ""),
//                                                   //         //           Text(correspondences[pos].docDueDate ??
//                                                   //         //               " "),
//                                                   //         //         ],
//                                                   //         //       ),
//                                                   //         //       Row(
//                                                   //         //         mainAxisAlignment:
//                                                   //         //         MainAxisAlignment.spaceBetween,
//                                                   //         //         children: [
//                                                   //         //           Text(correspondences[pos].docDueDate ??
//                                                   //         //               ""),
//                                                   //         //         ],
//                                                   //         //       ),
//                                                   //         //       Row(
//                                                   //         //         children: [
//                                                   //         //           if (correspondences[pos]
//                                                   //         //               .isHighPriority ??
//                                                   //         //               false)
//                                                   //         //             iconAndText(
//                                                   //         //                 iconColor: AppColor,
//                                                   //         //                 iconData: Icons.lock,
//                                                   //         //                 title: 'secret'.tr),
//                                                   //         //           if (correspondences[pos].isLocked ??
//                                                   //         //               false)
//                                                   //         //             iconAndText(
//                                                   //         //                 iconColor: AppColor,
//                                                   //         //                 iconData:
//                                                   //         //                 Icons.person_add_disabled,
//                                                   //         //                 title: 'closed'.tr),
//                                                   //         //         ],
//                                                   //         //       )
//                                                   //         //     ]);
//                                                   //       }),
//                                                   // ),
//                                                   //
//
//
//
//
//
//
//
//
//
//                                             Row(                  crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .start,
//                                               mainAxisAlignment:
//                                               MainAxisAlignment
//                                                   .start,children: [ Container(height: 20,width: 20,
//                                               decoration: BoxDecoration(
//                                                   color: Theme
//                                                       .of(
//                                                       context)
//                                                       .colorScheme
//                                                       .primary,shape: BoxShape.circle)),
//
//
//                                               SizedBox(width: 8,),
//                                               Flexible(
//                                                 child: Text(
//                                                 correspondences[
//                                                 pos]
//                                                     .gridInfo?[
//                                                 0]
//                                                     .value ??
//                                                     "",
//                                                 softWrap:
//                                                 true,
//                                                 maxLines: 3,
//                                             ),
//                                               ),],)    ,
// SizedBox(height: 8,),
//                                                   Row(                  crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .start,
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .start,children: [   Container(height: 20,width: 20,
//                                                         decoration: BoxDecoration(
//                                                            shape: BoxShape.circle)),
//
//
//                                                       SizedBox(width: 8,),
//
//
//                                                       Text("sender".tr),
//                                                       SizedBox(
//                                                         width: 4,
//                                                       ),
//                                                       Text(
//                                                           correspondences[pos]
//                                                               .fromUser ??
//                                                               ""),
//                                                     Spacer()
//                                                       // Flexible(
//                                                       //   child: Text(
//                                                       //     correspondences[
//                                                       //     pos]
//                                                       //         .gridInfo?[
//                                                       //     3]
//                                                       //         .label ??
//                                                       //         "",
//                                                       //     softWrap:
//                                                       //     true,
//                                                       //     maxLines: 3,
//                                                       //   ),
//                                                       // ),
//                                                     ,  Text(
//                                                       correspondences[
//                                                       pos]
//                                                           .gridInfo?[
//                                                       3]
//                                                           .value ??
//                                                           "",
//                                                       softWrap:
//                                                       true,
//                                                       maxLines: 3,
//                                                       style: TextStyle(fontSize: 16),  ),],)    ,
//                                                   Padding(
//                                                     padding:
//                                                     const EdgeInsets.all(8.0),
//                                                     child: Row(
//                                                       // mainAxisAlignment:
//                                                       //     MainAxisAlignment
//                                                       //         .spaceAround,
//                                                       children: [
//                                                         Spacer(),
//                                                         SizedBox(
//                                                           width: 10,
//                                                         ),
//                                                         Icon(
//                                                             correspondences[pos]
//                                                                 .isLocked!
//                                                                 ? Icons.lock
//                                                                 : Icons
//                                                                 .lock_open,
//                                                             color: Theme
//                                                                 .of(context)
//                                                                 .colorScheme
//                                                                 .primary),
//                                                         if (correspondences[pos]
//                                                             .isLocked ??
//                                                             false)
//                                                           Text("closed".tr,
//                                                               style: TextStyle(
//                                                                   color: Theme
//                                                                       .of(
//                                                                       context)
//                                                                       .colorScheme
//                                                                       .primary)),
//                                                         Spacer(),
//                                                         if (correspondences[pos]
//                                                             .showLock ??
//                                                             false)
//                                                           Icon(Icons.lock),
//                                                         if (correspondences[pos]
//                                                             .showLock ??
//                                                             false)
//                                                           Text("secret".tr),
//
//                                                         Spacer(),
//                                                         // Container(
//                                                         //   height: 20,
//                                                         //   width: 20,
//                                                         //   decoration: BoxDecoration(
//                                                         //       color: correspondences[
//                                                         //                       pos]
//                                                         //                   .priorityId ==
//                                                         //               "1"
//                                                         //           ? Colors.green
//                                                         //           : Colors.red,
//                                                         //       shape: BoxShape
//                                                         //           .circle),
//                                                         // ),
//                                                         if (correspondences[pos]
//                                                             .priorityId ==
//                                                             "1")
//                                                           Icon(
//                                                               Icons
//                                                                   .warning_amber,
//                                                               color: Colors
//                                                                   .red),
//                                                         SizedBox(
//                                                           width: 4,
//                                                         ),
//                                                         if (correspondences[pos]
//                                                             .priorityId ==
//                                                             "1")
//                                                           Text(
//                                                             "veryimportant".tr,
//                                                             style: TextStyle(
//                                                                 color:
//                                                                 Colors.red),
//                                                           )
//
//                                                         //   correspondences[pos].priorityId
//                                                         //  correspondences[pos].purposeId
//
//                                                         ,
//                                                         SizedBox(
//                                                           width: 8,
//                                                         ),
//                                                         Spacer(),
//                                                         // Text("sender".tr),
//                                                         // SizedBox(
//                                                         //   width: 4,
//                                                         // ),
//                                                         // Text(
//                                                         //     correspondences[pos]
//                                                         //         .fromUser ??
//                                                         //         ""),
//
//                                                         if (correspondences[pos]
//                                                             .hasAttachments ??
//                                                             false)
//                                                           Icon(
//                                                               Icons.attachment),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             Get
//                                                 .find<InboxController>()
//                                                 .edit
//                                                 ? InkWell(
//                                               onTap: () {
//                                                 print(
//                                                     "is select      ${correspondences[pos]
//                                                         .isSelect}");
//
//                                                 print(Get
//                                                     .find<
//                                                     InboxController>()
//                                                     .listSelectCorrespondences
//                                                     .length);
//
//                                                 if (correspondences[pos]
//                                                     .isSelect) {
//                                                   correspondences[pos]
//                                                       .isSelect = false;
//                                                 } else {
//                                                   correspondences[pos]
//                                                       .isSelect = true;
//                                                 }
//                                                 if (correspondences[pos]
//                                                     .isSelect) {
//                                                   Get
//                                                       .find<
//                                                       InboxController>()
//                                                       .listSelectCorrespondences
//                                                       .add(int.parse(
//                                                       correspondences[
//                                                       pos]
//                                                           .correspondenceId!));
//                                                 } else {
//                                                   Get
//                                                       .find<
//                                                       InboxController>()
//                                                       .listSelectCorrespondences
//                                                       .remove(
//                                                       correspondences[
//                                                       pos]);
//                                                 }
//
//                                                 Get.find<InboxController>()
//                                                     .update();
//                                               },
//                                               child: Padding(
//                                                   padding:
//                                                   EdgeInsets.all(8),
//                                                   child: Container(
//                                                       width: 30,
//                                                       height: 30,
//                                                       child: Image.asset(
//                                                           correspondences[
//                                                           pos]
//                                                               .isSelect
//                                                               ? "assets/images/check.png"
//                                                               : "assets/images/uncheck.png"))
//
//                                                 //
//                                                 // Checkbox(
//                                                 //     value: correspondences[pos].isSelect,
//                                                 //     onChanged: (v) {
//                                                 //       correspondences[pos].isSelect = v!;
//                                                 //       print(  Get.find<InboxController>()
//                                                 //           .listSelectCorrespondences.length);
//                                                 //       if(v!){
//                                                 //
//                                                 //
//                                                 //         Get.find<InboxController>()
//                                                 //             .listSelectCorrespondences
//                                                 //             .add(correspondences[pos]);
//                                                 //       }else{
//                                                 //         Get.find<InboxController>()
//                                                 //             .listSelectCorrespondences
//                                                 //             .remove(correspondences[pos]);
//                                                 //       }
//                                                 //
//                                                 //       Get.find<InboxController>()
//                                                 //           .update();
//                                                 //     }),
//                                               ),
//                                             )
//                                                 : PopupMenuButton(
//                                                 itemBuilder: (context) =>
//                                                 [
//                                                   PopupMenuItem(
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                             Icons
//                                                                 .forward_rounded,
//                                                             color: Colors
//                                                                 .orange),
//                                                         SizedBox(
//                                                           width: 4,
//                                                         ),
//                                                         Text("Reply".tr),
//                                                       ],
//                                                     ),
//                                                     value: 1,
//                                                     onTap: functionReply,
//                                                   ),
//                                                   PopupMenuItem(
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                             Icons
//                                                                 .account_circle,
//                                                             color: Colors
//                                                                 .red),
//                                                         SizedBox(
//                                                           width: 4,
//                                                         ),
//                                                         Text("Transfer"
//                                                             .tr),
//                                                       ],
//                                                     ),
//                                                     value: 2,
//                                                     onTap:
//                                                     functionTrunsfer,
//                                                   ),
//                                                   PopupMenuItem(
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                             Icons
//                                                                 .bookmark,
//                                                             color: Colors
//                                                                 .orange),
//                                                         SizedBox(
//                                                           width: 4,
//                                                         ),
//                                                         Text("Complete"
//                                                             .tr),
//                                                       ],
//                                                     ),
//                                                     onTap:
//                                                     functionComplet,
//                                                     value: 3,
//                                                   ),
//                                                   if (correspondences[pos]
//                                                       .hasSummaries ??
//                                                       false)
//                                                     PopupMenuItem(
//                                                       child: Row(
//                                                         children: [
//                                                           Icon(Icons.menu,
//                                                               color: Colors
//                                                                   .blueAccent),
//                                                           SizedBox(
//                                                             width: 4,
//                                                           ),
//                                                           Text("Summary"
//                                                               .tr),
//                                                         ],
//                                                       ),
//                                                       onTap:
//                                                       functionSummary,
//                                                       value: 4,
//                                                     ),
//                                                   PopupMenuItem(
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(
//                                                             Icons
//                                                                 .backpack_sharp,
//                                                             color: Colors
//                                                                 .blueAccent),
//                                                         SizedBox(
//                                                           width: 4,
//                                                         ),
//                                                         Text("addtoBasket"
//                                                             .tr),
//                                                       ],
//                                                     ),
//                                                     onTap: () {
//                                                       Get.find<
//                                                           InboxController>()
//                                                           .getFetchBasketList(
//                                                           context:
//                                                           context);
//                                                     },
//                                                     value: 5,
//                                                   ),
//                                                 ],
//                                                 enableFeedback: true,
//                                                 onSelected: (v) async {
//                                                   // print("*" * 50);
//                                                   // print(correspondences[pos]
//                                                   //     .hasSummaries);
//                                                   // print(correspondences[pos]
//                                                   //     .correspondenceId);
//                                                   //
//                                                   // print(correspondences[pos]
//                                                   //     .transferId);
//                                                   //
//                                                   // print("*" * 50);
//
//                                                   if (v == 1) {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (ctx) =>
//                                                           AlertDialog(
//                                                             title: Text(" "),
//                                                             content: Padding(
//                                                               padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Container(
//                                                                 width: MediaQuery
//                                                                     .of(
//                                                                     context)
//                                                                     .size
//                                                                     .width *
//                                                                     .8,
//                                                                 color: Colors
//                                                                     .grey[200],
//                                                                 child:
//                                                                 SingleChildScrollView(
//                                                                   child: Column(
//                                                                       children: [
//                                                                         Row(
//                                                                             crossAxisAlignment:
//                                                                             CrossAxisAlignment
//                                                                                 .center,
//                                                                             children: [
//                                                                               Padding(
//                                                                                 padding: const EdgeInsets
//                                                                                     .all(
//                                                                                     8.0),
//                                                                                 child: Text(
//                                                                                     correspondences[pos]
//                                                                                         .fromUser ??
//                                                                                         ""),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 width: 8,
//                                                                               ),
//                                                                               Text(
//                                                                                 "name"
//                                                                                     .tr,
//                                                                                 style: Theme
//                                                                                     .of(
//                                                                                     context)
//                                                                                     .textTheme
//                                                                                     .headline3!
//                                                                                     .copyWith(
//                                                                                   color: createMaterialColor(
//                                                                                     const Color
//                                                                                         .fromRGBO(
//                                                                                         77,
//                                                                                         77,
//                                                                                         77,
//                                                                                         1),
//                                                                                   ),
//                                                                                   fontSize: 15,
//                                                                                 ),
//                                                                                 textAlign: TextAlign
//                                                                                     .center,
//                                                                                 overflow: TextOverflow
//                                                                                     .ellipsis,
//                                                                               ),
//                                                                             ]),
//                                                                         SizedBox(
//                                                                           height:
//                                                                           4,
//                                                                         ),
//                                                                         Row(
//                                                                           children: [
//                                                                             Expanded(
//                                                                               child:
//                                                                               Text(
//                                                                                   "audioNotes"
//                                                                                       .tr),
//                                                                             )
//                                                                           ],
//                                                                         ),
//                                                                         Row(
//                                                                           children: [
//                                                                             Expanded(
//                                                                               child: Container(
//                                                                                   height: 40,
//                                                                                   color: Colors
//                                                                                       .grey[300],
//                                                                                   child: Row(
//                                                                                     mainAxisAlignment: MainAxisAlignment
//                                                                                         .spaceBetween,
//                                                                                     children: [
//                                                                                       GestureDetector(
//                                                                                         onTap: () async {
//                                                                                           Get
//                                                                                               .find<
//                                                                                               InboxController>()
//                                                                                               .recording
//                                                                                               ? Get
//                                                                                               .find<
//                                                                                               InboxController>()
//                                                                                               .stop2()
//                                                                                               : Get
//                                                                                               .find<
//                                                                                               InboxController>()
//                                                                                               .record2();
//                                                                                           Get
//                                                                                               .find<
//                                                                                               InboxController>()
//                                                                                               .update(
//                                                                                               [
//                                                                                                 "id"
//                                                                                               ]);
//                                                                                         },
//                                                                                         child: Padding(
//                                                                                           padding: const EdgeInsets
//                                                                                               .all(
//                                                                                               8.0),
//                                                                                           child: GetBuilder<
//                                                                                               InboxController>(
//                                                                                               id: "id",
//                                                                                               builder: (
//                                                                                                   logic) {
//                                                                                                 print(
//                                                                                                     "5555");
//                                                                                                 return Icon(
//                                                                                                     Get
//                                                                                                         .find<
//                                                                                                         InboxController>()
//                                                                                                         .recording
//                                                                                                         ? Icons
//                                                                                                         .stop
//                                                                                                         : Icons
//                                                                                                         .mic);
//                                                                                               }),
//                                                                                         ),
//                                                                                       ),
//                                                                                       Padding(
//                                                                                         padding: const EdgeInsets
//                                                                                             .all(
//                                                                                             8.0),
//                                                                                         child: InkWell(
//                                                                                           onTap: () {
//                                                                                             // controller
//                                                                                             //     .playRec();
//                                                                                           },
//                                                                                           child: Icon(
//                                                                                               Icons
//                                                                                                   .play_arrow),
//                                                                                         ),
//                                                                                       )
//                                                                                     ],
//                                                                                   )),
//                                                                             )
//                                                                           ],
//                                                                         ),
//                                                                         SizedBox(
//                                                                           height:
//                                                                           8,
//                                                                         ),
//                                                                         Container(
//                                                                           child:
//                                                                           TextFormField(
//                                                                             onChanged:
//                                                                                 (
//                                                                                 v) {
//                                                                               Get
//                                                                                   .find<
//                                                                                   InboxController>()
//                                                                                   .replyNote =
//                                                                                   v;
//                                                                             },
//                                                                             maxLines:
//                                                                             4,
//                                                                           ),
//                                                                           color: Colors
//                                                                               .grey[300],
//                                                                         ),
//                                                                         SizedBox(
//                                                                           height:
//                                                                           8,
//                                                                         ),
//                                                                       ]),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             actions: <Widget>[
//                                                               FlatButton(
//                                                                 onPressed:
//                                                                     () async {
//                                                                   String?
//                                                                   audioFileBes64 =
//                                                                   await audiobase64String(
//                                                                       file: Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .recordFile);
//
//                                                                   ReplyWithVoiceNoteApi
//                                                                   replayAPI =
//                                                                   ReplyWithVoiceNoteApi(
//                                                                       context);
//
//                                                                   ReplyWithVoiceNoteRequestModel v = ReplyWithVoiceNoteRequestModel(
//                                                                       userId: correspondences[
//                                                                       pos]
//                                                                           .fromUserId
//                                                                           .toString(),
//                                                                       transferId:
//                                                                       correspondences[pos]
//                                                                           .transferId,
//                                                                       token: Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .secureStorage
//                                                                           .token(),
//                                                                       correspondencesId:
//                                                                       correspondences[pos]
//                                                                           .correspondenceId,
//                                                                       language: Get
//                                                                           .locale
//                                                                           ?.languageCode ==
//                                                                           "en"
//                                                                           ? "en"
//                                                                           : "ar",
//                                                                       voiceNote:
//                                                                       audioFileBes64,
//                                                                       notes: Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .replyNote,
//                                                                       voiceNoteExt:
//                                                                       "m4a",
//                                                                       voiceNotePrivate:
//                                                                       false);
//
//                                                                   replayAPI
//                                                                       .post(v
//                                                                       .toMap())
//                                                                       .then(
//                                                                           (
//                                                                           value) {
//                                                                         print(
//                                                                             "1" *
//                                                                                 50);
//                                                                         ReplyWithVoiceNoteModel
//                                                                         v = value
//                                                                         as ReplyWithVoiceNoteModel;
//                                                                         print(v
//                                                                             .errorMessage);
//                                                                         print(
//                                                                             v
//                                                                                 .status);
//                                                                         print(
//                                                                             "1" *
//                                                                                 50);
//                                                                       });
//
//                                                                   /// ToDo send Replay
//
//                                                                   Navigator.of(
//                                                                       ctx)
//                                                                       .pop();
//                                                                 },
//                                                                 child: Text(
//                                                                     "Ok"),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                     );
//                                                   } else if (v == 2) {
//                                                     showDialog(
//                                                         context: context,
//                                                         builder: (BuildContext
//                                                         context) {
//                                                           return AlertDialog(
//                                                             title: Row(
//                                                               //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                 children: [
//                                                                   Image.asset(
//                                                                     'assets/images/refer.png'
//                                                                     //
//                                                                     ,
//                                                                     height:
//                                                                     20,
//                                                                     width: 20,
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 8,
//                                                                   ),
//                                                                   Text(
//                                                                     "refer"
//                                                                         .tr,
//                                                                     style: Theme
//                                                                         .of(
//                                                                         context)
//                                                                         .textTheme
//                                                                         .headline3!
//                                                                         .copyWith(
//                                                                       color:
//                                                                       createMaterialColor(
//                                                                         const Color
//                                                                             .fromRGBO(
//                                                                             77,
//                                                                             77,
//                                                                             77,
//                                                                             1),
//                                                                       ),
//                                                                       fontSize:
//                                                                       15,
//                                                                     ),
//                                                                     textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                                     overflow:
//                                                                     TextOverflow
//                                                                         .ellipsis,
//                                                                   ),
//                                                                   const Spacer(),
//                                                                   InkWell(
//                                                                     onTap:
//                                                                         () {
//                                                                       Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .filterWord =
//                                                                       "";
//                                                                       Navigator
//                                                                           .pop(
//                                                                           context);
//                                                                     },
//                                                                     child: Image
//                                                                         .asset(
//                                                                       'assets/images/close_button.png',
//                                                                       width:
//                                                                       20,
//                                                                       height:
//                                                                       20,
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                             content:
//                                                             SingleChildScrollView(
//                                                               child: Column(
//                                                                   crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                                   children: [
//                                                                     const SizedBox(
//                                                                       height:
//                                                                       10,
//                                                                     ),
//                                                                     Row(
//                                                                       children: [
//                                                                         Expanded(
//                                                                             child: Container(
//                                                                                 decoration: BoxDecoration(
//                                                                                     border: Border
//                                                                                         .all(
//                                                                                         color: Theme
//                                                                                             .of(
//                                                                                             context)
//                                                                                             .colorScheme
//                                                                                             .primary),
//                                                                                     borderRadius: const BorderRadius
//                                                                                         .all(
//                                                                                         Radius
//                                                                                             .circular(
//                                                                                             6))),
//                                                                                 child: TextField(
//                                                                                   decoration: const InputDecoration(
//                                                                                     border: UnderlineInputBorder(),
//                                                                                     labelText: 'To',
//                                                                                   ),
//                                                                                   onChanged: Get
//                                                                                       .find<
//                                                                                       InboxController>()
//                                                                                       .filterUser,
//                                                                                 ))),
//                                                                         const SizedBox(
//                                                                           width:
//                                                                           2,
//                                                                         ),
//                                                                         CustomButtonWithIcon(
//                                                                             icon: Icons
//                                                                                 .person,
//                                                                             onClick: () {
//                                                                               Get
//                                                                                   .find<
//                                                                                   InboxController>()
//                                                                                   .listOfUser(
//                                                                                   0);
//                                                                             }),
//                                                                         const SizedBox(
//                                                                           width:
//                                                                           2,
//                                                                         ),
//                                                                         CustomButtonWithIcon(
//                                                                             icon: Icons
//                                                                                 .account_balance,
//                                                                             onClick: () {
//                                                                               Get
//                                                                                   .find<
//                                                                                   InboxController>()
//                                                                                   .listOfUser(
//                                                                                   1);
//                                                                             }),
//                                                                         const SizedBox(
//                                                                           width:
//                                                                           2,
//                                                                         ),
//                                                                         CustomButtonWithIcon(
//                                                                             icon: Icons
//                                                                                 .person,
//                                                                             onClick: () {
//                                                                               Get
//                                                                                   .find<
//                                                                                   InboxController>()
//                                                                                   .listOfUser(
//                                                                                   2);
//                                                                             }),
//                                                                       ],
//                                                                     ),
//                                                                     const SizedBox(
//                                                                       height:
//                                                                       10,
//                                                                     ),
//                                                                     Text(
//                                                                         "referTo"
//                                                                             .tr),
//                                                                     SizedBox(
//                                                                         width: MediaQuery
//                                                                             .of(
//                                                                             context)
//                                                                             .size
//                                                                             .width *
//                                                                             .8,
//                                                                         height:
//                                                                         100,
//                                                                         child:
//                                                                         Row(
//                                                                           children: [
//                                                                             Expanded(
//                                                                                 child: GetBuilder<
//                                                                                     InboxController>(
//                                                                                   assignId: true,
//                                                                                   //tag: "alluser",
//                                                                                   builder: (
//                                                                                       logic) {
//                                                                                     return ListView
//                                                                                         .builder(
//                                                                                         scrollDirection: Axis
//                                                                                             .horizontal,
//                                                                                         itemCount: Get
//                                                                                             .find<
//                                                                                             InboxController>()
//                                                                                             .users
//                                                                                             .length,
//                                                                                         itemBuilder: (
//                                                                                             context,
//                                                                                             pos) {
//                                                                                           print(
//                                                                                               "*" *
//                                                                                                   100);
//                                                                                           print(
//                                                                                               logic
//                                                                                                   .users[pos]
//                                                                                                   .value
//                                                                                                   ?.split(
//                                                                                                   " ")
//                                                                                                   .length);
//                                                                                           List<
//                                                                                               String>? a = logic
//                                                                                               .users[pos]
//                                                                                               .value
//                                                                                               ?.split(
//                                                                                               " ");
//
//                                                                                           // bool a=logic.user?[pos].value?.contains(logic.filterWord)??false;
//                                                                                           if (logic
//                                                                                               .users[pos]
//                                                                                               .value
//                                                                                               ?.contains(
//                                                                                               logic
//                                                                                                   .filterWord) ??
//                                                                                               false) {
//                                                                                             return Padding(
//                                                                                               padding: const EdgeInsets
//                                                                                                   .all(
//                                                                                                   8.0),
//                                                                                               child: InkWell(
//                                                                                                 onTap: () {
//                                                                                                   Get
//                                                                                                       .find<
//                                                                                                       InboxController>()
//                                                                                                       .addTousersWillSendTo(
//                                                                                                       user: logic
//                                                                                                           .users[pos]);
//                                                                                                   Get
//                                                                                                       .find<
//                                                                                                       InboxController>()
//                                                                                                       .SetMultipleReplyWithVoiceNoteRequestModel(
//                                                                                                       correspondencesId: correspondences[pos]
//                                                                                                           .correspondenceId!,
//                                                                                                       transferId: correspondences[pos]
//                                                                                                           .transferId!,
//                                                                                                       id: logic
//                                                                                                           .users[pos]
//                                                                                                           .id!);
//                                                                                                 },
//                                                                                                 child: Container(
//                                                                                                   decoration: BoxDecoration(
//                                                                                                     border: Border
//                                                                                                         .all(
//                                                                                                         color: Theme
//                                                                                                             .of(
//                                                                                                             context)
//                                                                                                             .colorScheme
//                                                                                                             .primary,
//                                                                                                         width: 1),
//                                                                                                   ),
//                                                                                                   padding: EdgeInsets
//                                                                                                       .all(
//                                                                                                       2.0),
//                                                                                                   child: Row(
//                                                                                                     children: [
//                                                                                                       Container(
//                                                                                                         height: 50,
//                                                                                                         width: 50,
//                                                                                                         decoration: BoxDecoration(
//                                                                                                           shape: BoxShape
//                                                                                                               .circle,
//                                                                                                           color: Theme
//                                                                                                               .of(
//                                                                                                               context)
//                                                                                                               .colorScheme
//                                                                                                               .primary,
//                                                                                                         ),
//                                                                                                         child: Center(
//                                                                                                             child: FittedBox(
//                                                                                                                 child: Text(
//                                                                                                                     "${a?[0][0]} ${a?[0][0] ??
//                                                                                                                         ""}"))),
//                                                                                                       ),
//                                                                                                       Padding(
//                                                                                                           padding: const EdgeInsets
//                                                                                                               .only(
//                                                                                                               top: 2.0,
//                                                                                                               bottom: 2,
//                                                                                                               right: 8,
//                                                                                                               left: 8),
//                                                                                                           child: Text(
//                                                                                                             logic
//                                                                                                                 .users[pos]
//                                                                                                                 .value ??
//                                                                                                                 "",
//                                                                                                             maxLines: 3,
//                                                                                                             softWrap: true,
//                                                                                                           )
//
//                                                                                                         //
//                                                                                                         // Container(
//                                                                                                         //   height: 50,
//                                                                                                         //   width: 50,
//                                                                                                         //   decoration: const BoxDecoration(
//                                                                                                         //       shape: BoxShape.circle,
//                                                                                                         //       color: Colors.green),
//                                                                                                         // ),
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                             );
//                                                                                           } else {
//                                                                                             return SizedBox();
//                                                                                           }
//                                                                                         });
//                                                                                   },
//                                                                                 )),
//                                                                             // Padding(
//                                                                             //   padding:
//                                                                             //       const EdgeInsets.all(
//                                                                             //           8.0),
//                                                                             //   child:
//                                                                             //       Container(
//                                                                             //     child: const Icon(
//                                                                             //         Icons.clear),
//                                                                             //     height:
//                                                                             //         50,
//                                                                             //     width:
//                                                                             //         50,
//                                                                             //     decoration:
//                                                                             //         const BoxDecoration(
//                                                                             //       shape:
//                                                                             //           BoxShape.circle,
//                                                                             //       color:
//                                                                             //           Colors.grey,
//                                                                             //     ),
//                                                                             //   ),
//                                                                             // ),
//                                                                           ],
//                                                                         )),
//                                                                     const Divider(
//                                                                       color: Colors
//                                                                           .grey,
//                                                                     ),
//                                                                     SizedBox(
//                                                                         width: MediaQuery
//                                                                             .of(
//                                                                             context)
//                                                                             .size
//                                                                             .width *
//                                                                             .8,
//                                                                         height:
//                                                                         300,
//                                                                         // MediaQuery.of(context).size.height * .5,
//                                                                         child:
//                                                                         GetBuilder<
//                                                                             InboxController>(
//                                                                           //   assignId: true,//tag: "user",
//                                                                           builder:
//                                                                               (
//                                                                               logic) {
//                                                                             return //Text(logic.filterWord);
//
//                                                                               ListView
//                                                                                   .builder(
//                                                                                   scrollDirection: Axis
//                                                                                       .vertical,
//                                                                                   itemCount: Get
//                                                                                       .find<
//                                                                                       InboxController>()
//                                                                                       .usersWillSendTo
//                                                                                       .length,
//                                                                                   itemBuilder: (
//                                                                                       context,
//                                                                                       pos) {
//                                                                                     return //Text(controller.filterWord);
//
//                                                                                       Padding(
//                                                                                         padding: const EdgeInsets
//                                                                                             .all(
//                                                                                             8.0),
//                                                                                         child: Container(
//                                                                                           color: Colors
//                                                                                               .grey[200],
//                                                                                           child: Column(
//                                                                                               children: [
//                                                                                                 Row(crossAxisAlignment: CrossAxisAlignment
//                                                                                                     .center,
//                                                                                                     children: [
//                                                                                                       Padding(
//                                                                                                         padding: const EdgeInsets
//                                                                                                             .all(
//                                                                                                             8.0),
//                                                                                                         child: Text(
//                                                                                                             logic
//                                                                                                                 .usersWillSendTo[pos]
//                                                                                                                 .value ??
//                                                                                                                 ""),
//                                                                                                         // child: Container(
//                                                                                                         //   height: 50,
//                                                                                                         //   width: 50,
//                                                                                                         //   // decoration: const BoxDecoration(
//                                                                                                         //   //   shape: BoxShape.circle,
//                                                                                                         //   //   color: Colors.grey,
//                                                                                                         //   // ),
//                                                                                                         // ),
//                                                                                                       ),
//                                                                                                       SizedBox(
//                                                                                                         width: 8,
//                                                                                                       ),
//                                                                                                       Text(
//                                                                                                         "الاسم",
//                                                                                                         style: Theme
//                                                                                                             .of(
//                                                                                                             context)
//                                                                                                             .textTheme
//                                                                                                             .headline3!
//                                                                                                             .copyWith(
//                                                                                                           color: createMaterialColor(
//                                                                                                             const Color
//                                                                                                                 .fromRGBO(
//                                                                                                                 77,
//                                                                                                                 77,
//                                                                                                                 77,
//                                                                                                                 1),
//                                                                                                           ),
//                                                                                                           fontSize: 15,
//                                                                                                         ),
//                                                                                                         textAlign: TextAlign
//                                                                                                             .center,
//                                                                                                         overflow: TextOverflow
//                                                                                                             .ellipsis,
//                                                                                                       ),
//                                                                                                       Spacer(),
//                                                                                                       GestureDetector(
//                                                                                                         onTap: () {
//                                                                                                           Get
//                                                                                                               .find<
//                                                                                                               InboxController>()
//                                                                                                               .delTousersWillSendTo(
//                                                                                                               user: logic
//                                                                                                                   .usersWillSendTo[pos]);
//
//                                                                                                           Get
//                                                                                                               .find<
//                                                                                                               InboxController>()
//                                                                                                               .deltransfarForMany(
//                                                                                                               id: logic
//                                                                                                                   .users[pos]
//                                                                                                                   .id!);
//                                                                                                         },
//                                                                                                         child: Image
//                                                                                                             .asset(
//                                                                                                           'assets/images/close_button.png',
//                                                                                                           width: 20,
//                                                                                                           height: 20,
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ]),
//                                                                                                 SizedBox(
//                                                                                                   height: 4,
//                                                                                                 ),
//                                                                                                 Row(
//                                                                                                   children: [
//                                                                                                     Expanded(
//                                                                                                       child: Text(
//                                                                                                           "action"
//                                                                                                               .tr),
//                                                                                                     ),
//                                                                                                     SizedBox(
//                                                                                                       width: 10,
//                                                                                                     ),
//                                                                                                     Expanded(
//                                                                                                       child: Text(
//                                                                                                           "audioNotes"
//                                                                                                               .tr),
//                                                                                                     )
//                                                                                                   ],
//                                                                                                 ),
//                                                                                                 Row(
//                                                                                                   children: [
//                                                                                                     Expanded(
//                                                                                                       child: Container(
//                                                                                                         height: 40,
//                                                                                                         color: Colors
//                                                                                                             .grey[300],
//                                                                                                         child: DropdownButton<
//                                                                                                             CustomActions>(
//                                                                                                           alignment: Alignment
//                                                                                                               .topRight,
//                                                                                                           value: Get
//                                                                                                               .find<
//                                                                                                               InboxController>()
//                                                                                                               .getactions(
//                                                                                                               logic
//                                                                                                                   .usersWillSendTo[pos]
//                                                                                                                   .id),
//                                                                                                           icon: const Icon(
//                                                                                                               Icons
//                                                                                                                   .arrow_downward),
//                                                                                                           elevation: 16,
//                                                                                                           style: const TextStyle(
//                                                                                                               color: Colors
//                                                                                                                   .deepPurple),
//                                                                                                           underline: Container(
//                                                                                                             height: 2,
//                                                                                                             color: Colors
//                                                                                                                 .deepPurpleAccent,
//                                                                                                           ),
//                                                                                                           hint: Text(
//                                                                                                               "اختار"),
//                                                                                                           onChanged: (
//                                                                                                               CustomActions? newValue) {
//                                                                                                             logic
//                                                                                                                 .setactions(
//                                                                                                                 logic
//                                                                                                                     .usersWillSendTo[pos]
//                                                                                                                     .id,
//                                                                                                                 newValue!);
//                                                                                                           },
//                                                                                                           items: Get
//                                                                                                               .find<
//                                                                                                               InboxController>()
//                                                                                                               .customActions
//                                                                                                               ?.map<
//                                                                                                               DropdownMenuItem<
//                                                                                                                   CustomActions>>((
//                                                                                                               CustomActions value) {
//                                                                                                             return DropdownMenuItem<
//                                                                                                                 CustomActions>(
//                                                                                                               value: value,
//                                                                                                               child: Text(
//                                                                                                                   value
//                                                                                                                       .name!),
//                                                                                                             );
//                                                                                                           })
//                                                                                                               .toList(),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ),
//                                                                                                     const SizedBox(
//                                                                                                       width: 10,
//                                                                                                     ),
//                                                                                                     Expanded(
//                                                                                                       child: Container(
//                                                                                                           height: 40,
//                                                                                                           color: Colors
//                                                                                                               .grey[300],
//                                                                                                           child: Row(
//                                                                                                             mainAxisAlignment: MainAxisAlignment
//                                                                                                                 .spaceBetween,
//                                                                                                             children: [
//                                                                                                               GestureDetector(
//                                                                                                                 onTap: () async {
//                                                                                                                   // Get.find<InboxController>().recording ? Get.find<InboxController>().stop2() : Get.find<InboxController>().record2();
//
//                                                                                                                   Get
//                                                                                                                       .find<
//                                                                                                                       InboxController>()
//                                                                                                                       .recording
//                                                                                                                       ? Get
//                                                                                                                       .find<
//                                                                                                                       InboxController>()
//                                                                                                                       .stopForMany(
//                                                                                                                       id: logic
//                                                                                                                           .usersWillSendTo[pos]
//                                                                                                                           .id!)
//                                                                                                                       : Get
//                                                                                                                       .find<
//                                                                                                                       InboxController>()
//                                                                                                                       .recordForMany();
//                                                                                                                 },
//                                                                                                                 child: Padding(
//                                                                                                                   padding: const EdgeInsets
//                                                                                                                       .all(
//                                                                                                                       8.0),
//                                                                                                                   child: GetBuilder<
//                                                                                                                       DocumentController>(
//                                                                                                                       builder: (
//                                                                                                                           logic) {
//                                                                                                                         return Icon(
//                                                                                                                             Get
//                                                                                                                                 .find<
//                                                                                                                                 InboxController>()
//                                                                                                                                 .recording
//                                                                                                                                 ? Icons
//                                                                                                                                 .stop
//                                                                                                                                 : Icons
//                                                                                                                                 .mic);
//                                                                                                                       }),
//                                                                                                                 ),
//                                                                                                               ),
//                                                                                                               Padding(
//                                                                                                                 padding: const EdgeInsets
//                                                                                                                     .all(
//                                                                                                                     8.0),
//                                                                                                                 child: InkWell(
//                                                                                                                   onTap: () {
//                                                                                                                     Get
//                                                                                                                         .find<
//                                                                                                                         InboxController>()
//                                                                                                                         .playRec();
//                                                                                                                   },
//                                                                                                                   child: Icon(
//                                                                                                                       Icons
//                                                                                                                           .play_arrow),
//                                                                                                                 ),
//                                                                                                               )
//                                                                                                             ],
//                                                                                                           )),
//                                                                                                     )
//                                                                                                   ],
//                                                                                                 ),
//                                                                                                 SizedBox(
//                                                                                                   height: 8,
//                                                                                                 ),
//                                                                                                 Container(
//                                                                                                   child: TextFormField(
//                                                                                                     onChanged: (
//                                                                                                         v) {
//                                                                                                       Get
//                                                                                                           .find<
//                                                                                                           InboxController>()
//                                                                                                           .setNots(
//                                                                                                           id: logic
//                                                                                                               .users[pos]
//                                                                                                               .id!,
//                                                                                                           not: v);
//                                                                                                     },
//                                                                                                     maxLines: 4,
//                                                                                                   ),
//                                                                                                   color: Colors
//                                                                                                       .grey[300],
//                                                                                                 ),
//                                                                                                 SizedBox(
//                                                                                                   height: 8,
//                                                                                                 ),
//                                                                                               ]),
//                                                                                         ),
//                                                                                       );
//                                                                                   });
//                                                                           },
//                                                                         ))
//
//                                                                     // Container(height: 300,child: ListView.builder( itemCount: 100,itemBuilder: (context,pos){
//                                                                     //   return  Padding(
//                                                                     //     padding: const EdgeInsets.all(8.0),
//                                                                     //     child: Container(color: Colors.grey,child: Column(children: [
//                                                                     //       Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                     //           children: [
//                                                                     //             Image.asset(
//                                                                     //               'assets/images/refer.png'
//                                                                     //               //
//                                                                     //               ,
//                                                                     //               height: 20,
//                                                                     //               width: 20,
//                                                                     //             ),
//                                                                     //             const SizedBox(
//                                                                     //               width: 8,
//                                                                     //             ),
//                                                                     //             Text(
//                                                                     //               "refer".tr,
//                                                                     //               style: Theme.of(context).textTheme.headline3!.copyWith(
//                                                                     //                 color: createMaterialColor(
//                                                                     //                   const Color.fromRGBO(77, 77, 77, 1),
//                                                                     //                 ),
//                                                                     //                 fontSize: 15,
//                                                                     //               ),
//                                                                     //               textAlign: TextAlign.center,
//                                                                     //               overflow: TextOverflow.ellipsis,
//                                                                     //             ),
//                                                                     //
//                                                                     //             Image.asset(
//                                                                     //               'assets/images/close_button.png',
//                                                                     //               width: 20,
//                                                                     //               height: 20,
//                                                                     //             ),
//                                                                     //             Row(children: [],)
//                                                                     //           ]),]),),
//                                                                     //   );
//                                                                     //
//                                                                     // }))
//                                                                   ]),
//                                                             ),
//                                                             actions: <Widget>[
//                                                               TextButton(
//                                                                 onPressed:
//                                                                     () {
//                                                                   print(
//                                                                       "i click ok");
//                                                                   print(
//                                                                       "Get.find<InboxController>().   =>   ${Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .transfarForMany
//                                                                           .length}");
//                                                                   Get
//                                                                       .find<
//                                                                       InboxController>()
//                                                                       .transfarForMany
//                                                                       .forEach((
//                                                                       key,
//                                                                       value) {
//                                                                     print(
//                                                                         "$key      ${value
//                                                                             .toMap()}");
//                                                                   });
//
//                                                                   Get.find<
//                                                                       InboxController>()
//                                                                       .multipleTransferspost(
//                                                                       context:
//                                                                       context,
//                                                                       transferId:
//                                                                       correspondences[pos]
//                                                                           .transferId,
//                                                                       correspondenceId:
//                                                                       correspondences[pos]
//                                                                           .correspondenceId,
//                                                                       docDueDate:
//                                                                       correspondences[pos]
//                                                                           .docDueDate);
//                                                                   //Navigator.of(context).pop();
//                                                                 },
//                                                                 child: Text(
//                                                                     "Ok"),
//                                                               ),
//                                                             ],
//                                                           );
//                                                         });
//                                                   } else if (v == 3) {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (ctx) =>
//                                                           AlertDialog(
//                                                             title: Text(" "),
//                                                             content: Padding(
//                                                               padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Container(
//                                                                 width: MediaQuery
//                                                                     .of(
//                                                                     context)
//                                                                     .size
//                                                                     .width *
//                                                                     .8,
//                                                                 color: Colors
//                                                                     .grey[200],
//                                                                 child:
//                                                                 SingleChildScrollView(
//                                                                   child: Column(
//                                                                       mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                       crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                       children: [
//                                                                         Text(
//                                                                             "note"),
//                                                                         SizedBox(
//                                                                           height:
//                                                                           8,
//                                                                         ),
//                                                                         Container(
//                                                                           child:
//                                                                           TextFormField(
//                                                                             maxLines:
//                                                                             4,
//                                                                           ),
//                                                                           color: Colors
//                                                                               .grey[300],
//                                                                         ),
//                                                                         SizedBox(
//                                                                           height:
//                                                                           8,
//                                                                         ),
//                                                                       ]),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             actions: <Widget>[
//                                                               FlatButton(
//                                                                 onPressed: () {
//                                                                   print(Get
//                                                                       .find<
//                                                                       InboxController>()
//                                                                       .completeCustomActions
//                                                                       ?.name);
//                                                                   print(Get
//                                                                       .find<
//                                                                       InboxController>()
//                                                                       .completeCustomActions
//                                                                       ?.icon);
//
//                                                                   String data =
//                                                                       'Token=${Get
//                                                                       .find<
//                                                                       InboxController>()
//                                                                       .secureStorage
//                                                                       .token()}&correspondenceId=${correspondences[pos]
//                                                                       .correspondenceId}&transferId=${correspondences[pos]
//                                                                       .transferId}&actionType=${Get
//                                                                       .find<
//                                                                       InboxController>()
//                                                                       .completeCustomActions
//                                                                       ?.name ??
//                                                                       ""}&note=${Get
//                                                                       .find<
//                                                                       InboxController>()
//                                                                       .completeNote}&language=${Get
//                                                                       .locale
//                                                                       ?.languageCode ==
//                                                                       "en"
//                                                                       ? "en"
//                                                                       : "ar"}';
//
//                                                                   Get.find<
//                                                                       InboxController>()
//                                                                       .completeInCorrespondence(
//                                                                       context:
//                                                                       context,
//                                                                       data:
//                                                                       data);
//
//                                                                   Navigator.of(
//                                                                       ctx)
//                                                                       .pop();
//                                                                 },
//                                                                 child: Text(
//                                                                     "Ok"),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                     );
//
//                                                     print(Get
//                                                         .find<
//                                                         InboxController>()
//                                                         .customAction
//                                                         ?.name);
//
//                                                     print(
//                                                         "  Correspondences[pos].purposeId =>   ${correspondences[pos]
//                                                             .purposeId}");
//                                                     print(
//                                                         " Correspondences[pos].correspondenceId =>   ${correspondences[pos]
//                                                             .correspondenceId}");
//                                                     print(
//                                                         "   Correspondences[pos].transferId =>   ${correspondences[pos]
//                                                             .transferId}");
//
//                                                     print("ppp" * 10);
//                                                     print(Get
//                                                         .find<
//                                                         InboxController>()
//                                                         .customAction
//                                                         ?.name);
//                                                   } else if (v == 4) {
//                                                     //correspondences[pos].
//
//                                                   } else if (v == 5) {
//                                                     await Get.find<
//                                                         InboxController>()
//                                                         .getFetchBasketList(
//                                                         context: context);
//                                                     //    print("Get.find<InboxController>().getFetchBasketList()");
//
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (ctx) =>
//                                                           AlertDialog(
//                                                             title: Text(" "),
//                                                             content: Padding(
//                                                               padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                               child: Container(
//                                                                   width: MediaQuery
//                                                                       .of(
//                                                                       context)
//                                                                       .size
//                                                                       .width *
//                                                                       .3,
//                                                                   color: Colors
//                                                                       .grey[200],
//                                                                   child: ListView
//                                                                       .builder(
//                                                                       itemCount: Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .fetchBasketListModel
//                                                                           ?.baskets
//                                                                           ?.length,
//                                                                       itemBuilder:
//                                                                           (
//                                                                           context,
//                                                                           pos) {
//                                                                         return InkWell(
//                                                                           onTap:
//                                                                               () async {
//                                                                             Get
//                                                                                 .find<
//                                                                                 InboxController>()
//                                                                                 .listSelectCorrespondences
//                                                                                 .add(
//                                                                                 int
//                                                                                     .parse(
//                                                                                     correspondences[pos]
//                                                                                         .correspondenceId!));
//
//                                                                             await Get
//                                                                                 .find<
//                                                                                 InboxController>()
//                                                                                 .addDocumentsToBasket(
//                                                                                 context: context,
//                                                                                 basketId: Get
//                                                                                     .find<
//                                                                                     InboxController>()
//                                                                                     .fetchBasketListModel
//                                                                                     ?.baskets?[pos]
//                                                                                     .iD);
//                                                                             Get
//                                                                                 .back();
//                                                                           },
//                                                                           child:
//                                                                           Card(
//                                                                             elevation: 10,
//                                                                             child: Column(
//                                                                                 children: [
//                                                                                   Text(
//                                                                                       Get
//                                                                                           .find<
//                                                                                           InboxController>()
//                                                                                           .fetchBasketListModel
//                                                                                           ?.baskets?[pos]
//                                                                                           .name ??
//                                                                                           ""),
//                                                                                   Text(
//                                                                                       Get
//                                                                                           .find<
//                                                                                           InboxController>()
//                                                                                           .fetchBasketListModel
//                                                                                           ?.baskets?[pos]
//                                                                                           .nameAr ??
//                                                                                           ""),
//                                                                                   Text(
//                                                                                       "color :${Get
//                                                                                           .find<
//                                                                                           InboxController>()
//                                                                                           .fetchBasketListModel
//                                                                                           ?.baskets?[pos]
//                                                                                           .color}")
//                                                                                 ]),
//                                                                           ),
//                                                                         );
//                                                                       })),
//                                                             ),
//                                                             actions: <Widget>[
//                                                               FlatButton(
//                                                                 onPressed:
//                                                                     () async {
//                                                                   /// ToDo send Replay
//                                                                   print(
//                                                                       "77777777777777777777777777777777777777777777777777");
//                                                                   Navigator.of(
//                                                                       ctx)
//                                                                       .pop();
//                                                                 },
//                                                                 child: Text(
//                                                                     "Ok"),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                     );
//                                                   }
//                                                 }),
//                                           ],
//                                         )),
//                                   ),
//                                 );
//
//                               ///:SizedBox();
//                             } else {
//                               return haveMoreData
//                                   ? const SizedBox(
//                                 height: 50,
//                                 width: 50,
//                                 child: Center(
//                                     child: CircularProgressIndicator()),
//                               )
//                                   : const SizedBox();
//                             }
//                           },
//                           separatorBuilder: (context, index) => const Divider(),
//                           itemCount: correspondences.length + 1),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                         color: Colors.grey,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               width: 4,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) =>
//                                       AlertDialog(
//                                         title: Text(" "),
//                                         content: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Container(
//                                               width: MediaQuery
//                                                   .of(context)
//                                                   .size
//                                                   .width *
//                                                   .3,
//                                               color: Colors.grey[200],
//                                               child: GetBuilder<
//                                                   InboxController>(
//                                                   builder: (logic) {
//                                                     return SingleChildScrollView(
//                                                       child: Column(
//                                                         children: [
//                                                           Text("الغاية"),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[0]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[0],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[1]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[1],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[2]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[2],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts1[3]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts1[3],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts1pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts1,
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(
//                                                                 8.0),
//                                                             child: TextField(
//                                                               controller: logic
//                                                                   .textEditingControllerFilter,
//                                                               decoration:
//                                                               InputDecoration(
//                                                                 hintText: "اخري",
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 30,
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(
//                                                                 8.0),
//                                                             child: Divider(
//                                                                 height: 2,
//                                                                 thickness: 2),
//                                                           ),
//                                                           Text("النوع"),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts2[0]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts2[0],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts2pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts2,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts2[1]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts2[1],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts2pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts2,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts2[2]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts2[2],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts2pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts2,
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(
//                                                                 8.0),
//                                                             child: Divider(
//                                                                 height: 2,
//                                                                 thickness: 2),
//                                                           ),
//                                                           Text("prioritie"),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts3[0]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts3[0],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts3pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts3,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts3[1]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts3[1],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts3pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts3,
//                                                             ),
//                                                           ),
//                                                           ListTile(
//                                                             title: Text(
//                                                                 logic.texts3[2]
//                                                                     .tr),
//                                                             leading: Radio(
//                                                               value: logic
//                                                                   .texts3[2],
//                                                               groupValue:
//                                                               logic
//                                                                   .selectTexts3pos,
//                                                               onChanged:
//                                                               logic
//                                                                   .updateTexts3,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                         ),
//                                         actions: <Widget>[
//                                           FlatButton(
//                                             onPressed: () async {
//                                               /// ToDo send Replay
//
//                                               Navigator.of(ctx).pop();
//                                             },
//                                             child: Text("تطبيق"),
//                                           ),
//                                           FlatButton(
//                                             onPressed: () async {
//                                               /// ToDo send Replay
//                                               ///  Navigator.of(
//                                               //                         ctx)
//                                               //                         .pop();
//                                               //    Navigator.of(ctx).pop();
//                                               Get.find<InboxController>()
//                                                   .canceldata();
//                                             },
//                                             child: Text("الغاء"),
//                                           ),
//                                         ],
//                                       ),
//                                 );
//                               },
//                               child: Text("filter".tr,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.find<InboxController>().setEdit();
//                               },
//                               child: Text(
//                                   Get
//                                       .find<InboxController>()
//                                       .edit
//                                       ? "back".tr
//                                       : "Modify".tr,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20)),
//                             ),
//                             SizedBox(
//                               width: 4,
//                             ),
//                           ],
//                         )),
//                     Expanded(
//                       child: ListView.separated(
//                           controller: scrollController,
//                           itemBuilder: (context, pos) {
//                             if (pos < allCorrespondences.length) {
//                               //  print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");
//                               return InkWell(
//                                 onTap: () {
//                                   Get.find<InboxController>().canOpenDoc(
//                                       context: context,
//                                       docId: allCorrespondences[pos].purposeId,
//                                       correspondenceId: allCorrespondences[pos]
//                                           .correspondenceId,
//                                       transferId:
//                                       allCorrespondences[pos].transferId);
//                                   print(allCorrespondences[pos].purposeId);
//                                   print(
//                                       allCorrespondences[pos].correspondenceId);
//
//                                   //
//                                   // Get.find<InboxController>().openfilee(docId: allCorrespondences[pos].purposeId, correspondenceId: allCorrespondences[pos]
//                                   //          .correspondenceId, transferId:  allCorrespondences[pos].transferId);
//
//                                   Get
//                                       .find<DocumentController>()
//                                       .correspondences =
//                                   allCorrespondences[pos];
//                                   Get.find<DocumentController>()
//                                       .g2gInfoForExport(
//                                       context: context,
//                                       documentId: allCorrespondences[pos]
//                                           .correspondenceId);
//                                   // Get.find<DocumentController>().loadPdf();
//                                   // Get.toNamed("/DocumentPage");
//                                 },
//                                 child: SizedBox(
//                                   //height: MediaQuery.of(context).size.height*.3,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Expanded(
//                                         child: Column(
//                                           children: [
//                                             Padding(
//                                                 padding:
//                                                 const EdgeInsets.all(8.0),
//                                                 child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount:
//                                                     allCorrespondences[pos]
//                                                         .gridInfo
//                                                         ?.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       return Row(
//                                                         children: [
//                                                           Container(
//                                                               width: MediaQuery
//                                                                   .of(
//                                                                   context)
//                                                                   .size
//                                                                   .width *
//                                                                   .1,
//                                                               child: Text(
//                                                                   allCorrespondences[
//                                                                   pos]
//                                                                       .gridInfo?[
//                                                                   index]
//                                                                       .label ??
//                                                                       "")),
//                                                           SizedBox(
//                                                             width: 8,
//                                                           ),
//                                                           Expanded(
//                                                             child: Container(
//                                                               // width: MediaQuery.of(
//                                                               //   context)
//                                                               //   .size
//                                                               //   .width *
//                                                               //   .5,
//                                                               child: Text(
//                                                                   allCorrespondences[
//                                                                   pos]
//                                                                       .gridInfo?[
//                                                                   index]
//                                                                       .value ??
//                                                                       ""),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       );
//
//                                                       // Column(
//                                                       //     crossAxisAlignment: CrossAxisAlignment.start,
//                                                       //     children: [
//                                                       //       // Text(correspondences[pos].fromStructure ??
//                                                       //       //     ""),
//                                                       //       Row(
//                                                       //         mainAxisAlignment:
//                                                       //         MainAxisAlignment.spaceBetween,
//                                                       //         children: [
//                                                       //           Text(correspondences[pos]. ??
//                                                       //               ""),
//                                                       //           Text(correspondences[pos].docDueDate ??
//                                                       //               " "),
//                                                       //         ],
//                                                       //       ),
//                                                       //       Row(
//                                                       //         mainAxisAlignment:
//                                                       //         MainAxisAlignment.spaceBetween,
//                                                       //         children: [
//                                                       //           Text(correspondences[pos].docDueDate ??
//                                                       //               ""),
//                                                       //         ],
//                                                       //       ),
//                                                       //       Row(
//                                                       //         children: [
//                                                       //           if (correspondences[pos]
//                                                       //               .isHighPriority ??
//                                                       //               false)
//                                                       //             iconAndText(
//                                                       //                 iconColor: AppColor,
//                                                       //                 iconData: Icons.lock,
//                                                       //                 title: 'secret'.tr),
//                                                       //           if (correspondences[pos].isLocked ??
//                                                       //               false)
//                                                       //             iconAndText(
//                                                       //                 iconColor: AppColor,
//                                                       //                 iconData:
//                                                       //                 Icons.person_add_disabled,
//                                                       //                 title: 'closed'.tr),
//                                                       //         ],
//                                                       //       )
//                                                       //     ]);
//                                                     })),
//                                             Padding(
//                                               padding:
//                                               const EdgeInsets.all(8.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceBetween,
//                                                 children: [
//                                                   Icon(allCorrespondences[pos]
//                                                       .isLocked!
//                                                       ? Icons.lock
//                                                       : Icons.lock_open,
//                                                       color: Theme
//                                                           .of(context)
//                                                           .colorScheme
//                                                           .primary),
//                                                   if (correspondences[pos]
//                                                       .isLocked ??
//                                                       false)
//                                                     Text("closed".tr,
//                                                         style: TextStyle(
//                                                             color: Theme
//                                                                 .of(context)
//                                                                 .colorScheme
//                                                                 .primary)),
//                                                   Container(
//                                                     height: 20,
//                                                     width: 20,
//                                                     decoration: BoxDecoration(
//                                                         color: allCorrespondences[
//                                                         pos]
//                                                             .priorityId ==
//                                                             "1"
//                                                             ? Colors.green
//                                                             : Colors.red,
//                                                         shape: BoxShape.circle),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   Text(allCorrespondences[pos]
//                                                       .fromUser ??
//                                                       ""),
//                                                   if (allCorrespondences[pos]
//                                                       .hasAttachments ??
//                                                       false)
//                                                     Icon(Icons.attachment),
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       Get
//                                           .find<InboxController>()
//                                           .edit
//                                           ? InkWell(
//                                         onTap: () {
//                                           print(
//                                               "is select      ${correspondences[pos]
//                                                   .isSelect}");
//
//                                           print(Get
//                                               .find<
//                                               InboxController>()
//                                               .listSelectCorrespondences
//                                               .length);
//
//                                           if (correspondences[pos]
//                                               .isSelect) {
//                                             correspondences[pos]
//                                                 .isSelect = false;
//                                           } else {
//                                             correspondences[pos]
//                                                 .isSelect = true;
//                                           }
//                                           if (correspondences[pos]
//                                               .isSelect) {
//                                             Get
//                                                 .find<InboxController>()
//                                                 .listSelectCorrespondences
//                                                 .add(int.parse(
//                                                 correspondences[pos]
//                                                     .correspondenceId!));
//                                           } else {
//                                             Get
//                                                 .find<InboxController>()
//                                                 .listSelectCorrespondences
//                                                 .remove(
//                                                 correspondences[pos]);
//                                           }
//
//                                           Get.find<InboxController>()
//                                               .update();
//                                         },
//                                         child: Padding(
//                                             padding: EdgeInsets.all(8),
//                                             child: Container(
//                                                 width: 30,
//                                                 height: 30,
//                                                 child: Image.asset(
//                                                     correspondences[pos]
//                                                         .isSelect
//                                                         ? "assets/images/check.png"
//                                                         : "assets/images/uncheck.png"))
//
//                                           //
//                                           // Checkbox(
//                                           //     value: correspondences[pos].isSelect,
//                                           //     onChanged: (v) {
//                                           //       correspondences[pos].isSelect = v!;
//                                           //       print(  Get.find<InboxController>()
//                                           //           .listSelectCorrespondences.length);
//                                           //       if(v!){
//                                           //
//                                           //
//                                           //         Get.find<InboxController>()
//                                           //             .listSelectCorrespondences
//                                           //             .add(correspondences[pos]);
//                                           //       }else{
//                                           //         Get.find<InboxController>()
//                                           //             .listSelectCorrespondences
//                                           //             .remove(correspondences[pos]);
//                                           //       }
//                                           //
//                                           //       Get.find<InboxController>()
//                                           //           .update();
//                                           //     }),
//                                         ),
//                                       )
//                                           : PopupMenuButton(
//                                           itemBuilder: (context) =>
//                                           [
//                                             PopupMenuItem(
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                       Icons
//                                                           .forward_rounded,
//                                                       color: Colors
//                                                           .orange),
//                                                   SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   Text("Reply".tr),
//                                                 ],
//                                               ),
//                                               value: 1,
//                                               onTap: functionReply,
//                                             ),
//                                             PopupMenuItem(
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                       Icons
//                                                           .account_circle,
//                                                       color:
//                                                       Colors.red),
//                                                   SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   Text("Transfer".tr),
//                                                 ],
//                                               ),
//                                               value: 2,
//                                               onTap: functionTrunsfer,
//                                             ),
//                                             PopupMenuItem(
//                                               child: Row(
//                                                 children: [
//                                                   Icon(Icons.bookmark,
//                                                       color: Colors
//                                                           .orange),
//                                                   SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   Text("Complete".tr),
//                                                 ],
//                                               ),
//                                               onTap: functionComplet,
//                                               value: 3,
//                                             ),
//                                             if (correspondences[pos]
//                                                 .hasSummaries ??
//                                                 false)
//                                               PopupMenuItem(
//                                                 child: Row(
//                                                   children: [
//                                                     Icon(Icons.menu,
//                                                         color: Colors
//                                                             .blueAccent),
//                                                     SizedBox(
//                                                       width: 4,
//                                                     ),
//                                                     Text("Summary".tr),
//                                                   ],
//                                                 ),
//                                                 onTap: functionSummary,
//                                                 value: 4,
//                                               ),
//                                             PopupMenuItem(
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                       Icons
//                                                           .backpack_sharp,
//                                                       color: Colors
//                                                           .blueAccent),
//                                                   SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   Text(
//                                                       "addtoBasket".tr),
//                                                 ],
//                                               ),
//                                               onTap: () {
//                                                 Get.find<
//                                                     InboxController>()
//                                                     .getFetchBasketList(
//                                                     context:
//                                                     context);
//                                               },
//                                               value: 5,
//                                             ),
//                                           ],
//                                           enableFeedback: true,
//                                           onSelected: (v) async {
//                                             // print("*" * 50);
//                                             // print(correspondences[pos]
//                                             //     .hasSummaries);
//                                             // print(correspondences[pos]
//                                             //     .correspondenceId);
//                                             //
//                                             // print(correspondences[pos]
//                                             //     .transferId);
//                                             //
//                                             // print("*" * 50);
//
//                                             if (v == 1) {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (ctx) =>
//                                                     AlertDialog(
//                                                       title: Text(" "),
//                                                       content: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(8.0),
//                                                         child: Container(
//                                                           width: MediaQuery
//                                                               .of(
//                                                               context)
//                                                               .size
//                                                               .width *
//                                                               .8,
//                                                           color:
//                                                           Colors.grey[200],
//                                                           child:
//                                                           SingleChildScrollView(
//                                                             child: Column(
//                                                                 children: [
//                                                                   Row(
//                                                                       crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding:
//                                                                           const EdgeInsets
//                                                                               .all(
//                                                                               8.0),
//                                                                           child:
//                                                                           Text(
//                                                                               correspondences[pos]
//                                                                                   .fromUser ??
//                                                                                   ""),
//                                                                         ),
//                                                                         SizedBox(
//                                                                           width:
//                                                                           8,
//                                                                         ),
//                                                                         Text(
//                                                                           "name"
//                                                                               .tr,
//                                                                           style: Theme
//                                                                               .of(
//                                                                               context)
//                                                                               .textTheme
//                                                                               .headline3!
//                                                                               .copyWith(
//                                                                             color: createMaterialColor(
//                                                                               const Color
//                                                                                   .fromRGBO(
//                                                                                   77,
//                                                                                   77,
//                                                                                   77,
//                                                                                   1),
//                                                                             ),
//                                                                             fontSize: 15,
//                                                                           ),
//                                                                           textAlign:
//                                                                           TextAlign
//                                                                               .center,
//                                                                           overflow:
//                                                                           TextOverflow
//                                                                               .ellipsis,
//                                                                         ),
//                                                                       ]),
//                                                                   SizedBox(
//                                                                     height: 4,
//                                                                   ),
//                                                                   Row(
//                                                                     children: [
//                                                                       Expanded(
//                                                                         child: Text(
//                                                                             "audioNotes"
//                                                                                 .tr),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                   Row(
//                                                                     children: [
//                                                                       Expanded(
//                                                                         child: Container(
//                                                                             height: 40,
//                                                                             color: Colors
//                                                                                 .grey[300],
//                                                                             child: Row(
//                                                                               mainAxisAlignment: MainAxisAlignment
//                                                                                   .spaceBetween,
//                                                                               children: [
//                                                                                 GestureDetector(
//                                                                                   onTap: () async {
//                                                                                     Get
//                                                                                         .find<
//                                                                                         InboxController>()
//                                                                                         .recording
//                                                                                         ? Get
//                                                                                         .find<
//                                                                                         InboxController>()
//                                                                                         .stop2()
//                                                                                         : Get
//                                                                                         .find<
//                                                                                         InboxController>()
//                                                                                         .record2();
//                                                                                     Get
//                                                                                         .find<
//                                                                                         InboxController>()
//                                                                                         .update(
//                                                                                         [
//                                                                                           "id"
//                                                                                         ]);
//                                                                                   },
//                                                                                   child: Padding(
//                                                                                     padding: const EdgeInsets
//                                                                                         .all(
//                                                                                         8.0),
//                                                                                     child: GetBuilder<
//                                                                                         InboxController>(
//                                                                                         id: "id",
//                                                                                         builder: (
//                                                                                             logic) {
//                                                                                           print(
//                                                                                               "5555");
//                                                                                           return Icon(
//                                                                                               Get
//                                                                                                   .find<
//                                                                                                   InboxController>()
//                                                                                                   .recording
//                                                                                                   ? Icons
//                                                                                                   .stop
//                                                                                                   : Icons
//                                                                                                   .mic);
//                                                                                         }),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets
//                                                                                       .all(
//                                                                                       8.0),
//                                                                                   child: InkWell(
//                                                                                     onTap: () {
//                                                                                       // controller
//                                                                                       //     .playRec();
//                                                                                     },
//                                                                                     child: Icon(
//                                                                                         Icons
//                                                                                             .play_arrow),
//                                                                                   ),
//                                                                                 )
//                                                                               ],
//                                                                             )),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: 8,
//                                                                   ),
//                                                                   Container(
//                                                                     child:
//                                                                     TextFormField(
//                                                                       onChanged:
//                                                                           (v) {
//                                                                         Get
//                                                                             .find<
//                                                                             InboxController>()
//                                                                             .replyNote =
//                                                                             v;
//                                                                       },
//                                                                       maxLines:
//                                                                       4,
//                                                                     ),
//                                                                     color: Colors
//                                                                         .grey[
//                                                                     300],
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: 8,
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       actions: <Widget>[
//                                                         FlatButton(
//                                                           onPressed: () async {
//                                                             String?
//                                                             audioFileBes64 =
//                                                             await audiobase64String(
//                                                                 file: Get
//                                                                     .find<
//                                                                     InboxController>()
//                                                                     .recordFile);
//
//                                                             ReplyWithVoiceNoteApi
//                                                             replayAPI =
//                                                             ReplyWithVoiceNoteApi(
//                                                                 context);
//
//                                                             ReplyWithVoiceNoteRequestModel v = ReplyWithVoiceNoteRequestModel(
//                                                                 userId: allCorrespondences[pos]
//                                                                     .fromUserId
//                                                                     .toString(),
//                                                                 transferId:
//                                                                 allCorrespondences[pos]
//                                                                     .transferId,
//                                                                 token: Get
//                                                                     .find<
//                                                                     InboxController>()
//                                                                     .secureStorage
//                                                                     .token(),
//                                                                 correspondencesId:
//                                                                 allCorrespondences[pos]
//                                                                     .correspondenceId,
//                                                                 language: Get
//                                                                     .locale
//                                                                     ?.languageCode ==
//                                                                     "en"
//                                                                     ? "en"
//                                                                     : "ar",
//                                                                 voiceNote:
//                                                                 audioFileBes64,
//                                                                 notes: Get
//                                                                     .find<
//                                                                     InboxController>()
//                                                                     .replyNote,
//                                                                 voiceNoteExt:
//                                                                 "m4a",
//                                                                 voiceNotePrivate:
//                                                                 false);
//
//                                                             replayAPI
//                                                                 .post(v.toMap())
//                                                                 .then((value) {
//                                                               print("1" * 50);
//                                                               ReplyWithVoiceNoteModel
//                                                               v = value
//                                                               as ReplyWithVoiceNoteModel;
//                                                               print(v
//                                                                   .errorMessage);
//                                                               print(v.status);
//                                                               print("1" * 50);
//                                                             });
//
//                                                             /// ToDo send Replay
//
//                                                             Navigator.of(ctx)
//                                                                 .pop();
//                                                           },
//                                                           child: Text("Ok"),
//                                                         ),
//                                                       ],
//                                                     ),
//                                               );
//                                             } else if (v == 2) {
//                                               showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext
//                                                   context) {
//                                                     return AlertDialog(
//                                                       title: Row(
//                                                         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Image.asset(
//                                                               'assets/images/refer.png'
//                                                               //
//                                                               ,
//                                                               height: 20,
//                                                               width: 20,
//                                                             ),
//                                                             const SizedBox(
//                                                               width: 8,
//                                                             ),
//                                                             Text(
//                                                               "refer".tr,
//                                                               style: Theme
//                                                                   .of(
//                                                                   context)
//                                                                   .textTheme
//                                                                   .headline3!
//                                                                   .copyWith(
//                                                                 color:
//                                                                 createMaterialColor(
//                                                                   const Color
//                                                                       .fromRGBO(
//                                                                       77,
//                                                                       77,
//                                                                       77,
//                                                                       1),
//                                                                 ),
//                                                                 fontSize:
//                                                                 15,
//                                                               ),
//                                                               textAlign:
//                                                               TextAlign
//                                                                   .center,
//                                                               overflow:
//                                                               TextOverflow
//                                                                   .ellipsis,
//                                                             ),
//                                                             const Spacer(),
//                                                             InkWell(
//                                                               onTap: () {
//                                                                 Get
//                                                                     .find<
//                                                                     InboxController>()
//                                                                     .filterWord =
//                                                                 "";
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               },
//                                                               child: Image
//                                                                   .asset(
//                                                                 'assets/images/close_button.png',
//                                                                 width: 20,
//                                                                 height: 20,
//                                                               ),
//                                                             ),
//                                                           ]),
//                                                       content:
//                                                       SingleChildScrollView(
//                                                         child: Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                             children: [
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                       child: Container(
//                                                                           decoration: BoxDecoration(
//                                                                               border: Border
//                                                                                   .all(
//                                                                                   color: Theme
//                                                                                       .of(
//                                                                                       context)
//                                                                                       .colorScheme
//                                                                                       .primary),
//                                                                               borderRadius: const BorderRadius
//                                                                                   .all(
//                                                                                   Radius
//                                                                                       .circular(
//                                                                                       6))),
//                                                                           child: TextField(
//                                                                             decoration: const InputDecoration(
//                                                                               border: UnderlineInputBorder(),
//                                                                               labelText: 'To',
//                                                                             ),
//                                                                             onChanged: Get
//                                                                                 .find<
//                                                                                 InboxController>()
//                                                                                 .filterUser,
//                                                                           ))),
//                                                                   const SizedBox(
//                                                                     width:
//                                                                     2,
//                                                                   ),
//                                                                   CustomButtonWithIcon(
//                                                                       icon: Icons
//                                                                           .person,
//                                                                       onClick:
//                                                                           () {
//                                                                         Get
//                                                                             .find<
//                                                                             InboxController>()
//                                                                             .listOfUser(
//                                                                             0);
//                                                                       }),
//                                                                   const SizedBox(
//                                                                     width:
//                                                                     2,
//                                                                   ),
//                                                                   CustomButtonWithIcon(
//                                                                       icon: Icons
//                                                                           .account_balance,
//                                                                       onClick:
//                                                                           () {
//                                                                         Get
//                                                                             .find<
//                                                                             InboxController>()
//                                                                             .listOfUser(
//                                                                             1);
//                                                                       }),
//                                                                   const SizedBox(
//                                                                     width:
//                                                                     2,
//                                                                   ),
//                                                                   CustomButtonWithIcon(
//                                                                       icon: Icons
//                                                                           .person,
//                                                                       onClick:
//                                                                           () {
//                                                                         Get
//                                                                             .find<
//                                                                             InboxController>()
//                                                                             .listOfUser(
//                                                                             2);
//                                                                       }),
//                                                                 ],
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 10,
//                                                               ),
//                                                               Text("referTo"
//                                                                   .tr),
//                                                               SizedBox(
//                                                                   width: MediaQuery
//                                                                       .of(
//                                                                       context)
//                                                                       .size
//                                                                       .width *
//                                                                       .8,
//                                                                   height:
//                                                                   100,
//                                                                   child:
//                                                                   Row(
//                                                                     children: [
//                                                                       Expanded(
//                                                                           child: GetBuilder<
//                                                                               InboxController>(
//                                                                             assignId:
//                                                                             true,
//                                                                             //tag: "alluser",
//                                                                             builder:
//                                                                                 (
//                                                                                 logic) {
//                                                                               return ListView
//                                                                                   .builder(
//                                                                                   scrollDirection: Axis
//                                                                                       .horizontal,
//                                                                                   itemCount: Get
//                                                                                       .find<
//                                                                                       InboxController>()
//                                                                                       .users
//                                                                                       .length,
//                                                                                   itemBuilder: (
//                                                                                       context,
//                                                                                       pos) {
//                                                                                     List<
//                                                                                         String>? a = logic
//                                                                                         .users[pos]
//                                                                                         .value
//                                                                                         ?.split(
//                                                                                         " ");
//
//                                                                                     // bool a=logic.user?[pos].value?.contains(logic.filterWord)??false;
//                                                                                     if (logic
//                                                                                         .users[pos]
//                                                                                         .value
//                                                                                         ?.contains(
//                                                                                         logic
//                                                                                             .filterWord) ??
//                                                                                         false) {
//                                                                                       return Padding(
//                                                                                         padding: const EdgeInsets
//                                                                                             .all(
//                                                                                             8.0),
//                                                                                         child: InkWell(
//                                                                                           onTap: () {
//                                                                                             Get
//                                                                                                 .find<
//                                                                                                 InboxController>()
//                                                                                                 .addTousersWillSendTo(
//                                                                                                 user: logic
//                                                                                                     .users[pos]);
//
//                                                                                             Get
//                                                                                                 .find<
//                                                                                                 InboxController>()
//                                                                                                 .SetMultipleReplyWithVoiceNoteRequestModel(
//                                                                                                 correspondencesId: allCorrespondences[pos]
//                                                                                                     .correspondenceId!,
//                                                                                                 transferId: allCorrespondences[pos]
//                                                                                                     .transferId!,
//                                                                                                 id: logic
//                                                                                                     .users[pos]
//                                                                                                     .id!);
//                                                                                           },
//                                                                                           child: Container(
//                                                                                             decoration: BoxDecoration(
//                                                                                               border: Border
//                                                                                                   .all(
//                                                                                                   color: Theme
//                                                                                                       .of(
//                                                                                                       context)
//                                                                                                       .colorScheme
//                                                                                                       .primary,
//                                                                                                   width: 1),
//                                                                                             ),
//                                                                                             padding: EdgeInsets
//                                                                                                 .all(
//                                                                                                 2.0),
//                                                                                             child: Row(
//                                                                                               children: [
//                                                                                                 Container(
//                                                                                                   height: 50,
//                                                                                                   width: 50,
//                                                                                                   decoration: BoxDecoration(
//                                                                                                     shape: BoxShape
//                                                                                                         .circle,
//                                                                                                     color: Theme
//                                                                                                         .of(
//                                                                                                         context)
//                                                                                                         .colorScheme
//                                                                                                         .primary,
//                                                                                                   ),
//                                                                                                   child: Center(
//                                                                                                       child: FittedBox(
//                                                                                                           child: Text(
//                                                                                                               "${a?[0][0]} ${a?[0][0] ??
//                                                                                                                   ""}"))),
//                                                                                                 ),
//                                                                                                 Padding(
//                                                                                                     padding: const EdgeInsets
//                                                                                                         .only(
//                                                                                                         top: 2.0,
//                                                                                                         bottom: 2,
//                                                                                                         right: 8,
//                                                                                                         left: 8),
//                                                                                                     child: Text(
//                                                                                                       logic
//                                                                                                           .users[pos]
//                                                                                                           .value ??
//                                                                                                           "",
//                                                                                                       maxLines: 3,
//                                                                                                       softWrap: true,
//                                                                                                     )
//
//                                                                                                   //
//                                                                                                   // Container(
//                                                                                                   //   height: 50,
//                                                                                                   //   width: 50,
//                                                                                                   //   decoration: const BoxDecoration(
//                                                                                                   //       shape: BoxShape.circle,
//                                                                                                   //       color: Colors.green),
//                                                                                                   // ),
//                                                                                                 ),
//                                                                                               ],
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                       );
//                                                                                     } else {
//                                                                                       return SizedBox();
//                                                                                     }
//                                                                                   });
//                                                                             },
//                                                                           )),
//                                                                       // Padding(
//                                                                       //   padding:
//                                                                       //       const EdgeInsets.all(
//                                                                       //           8.0),
//                                                                       //   child:
//                                                                       //       Container(
//                                                                       //     child: const Icon(
//                                                                       //         Icons.clear),
//                                                                       //     height:
//                                                                       //         50,
//                                                                       //     width:
//                                                                       //         50,
//                                                                       //     decoration:
//                                                                       //         const BoxDecoration(
//                                                                       //       shape:
//                                                                       //           BoxShape.circle,
//                                                                       //       color:
//                                                                       //           Colors.grey,
//                                                                       //     ),
//                                                                       //   ),
//                                                                       // ),
//                                                                     ],
//                                                                   )),
//                                                               const Divider(
//                                                                 color: Colors
//                                                                     .grey,
//                                                               ),
//                                                               SizedBox(
//                                                                   width: MediaQuery
//                                                                       .of(
//                                                                       context)
//                                                                       .size
//                                                                       .width *
//                                                                       .8,
//                                                                   height:
//                                                                   300,
//                                                                   // MediaQuery.of(context).size.height * .5,
//                                                                   child: GetBuilder<
//                                                                       InboxController>(
//                                                                     //   assignId: true,//tag: "user",
//                                                                     builder:
//                                                                         (
//                                                                         logic) {
//                                                                       return //Text(logic.filterWord);
//
//                                                                         ListView
//                                                                             .builder(
//                                                                             scrollDirection: Axis
//                                                                                 .vertical,
//                                                                             itemCount: Get
//                                                                                 .find<
//                                                                                 InboxController>()
//                                                                                 .usersWillSendTo
//                                                                                 .length,
//                                                                             itemBuilder: (
//                                                                                 context,
//                                                                                 pos) {
//                                                                               return //Text(controller.filterWord);
//
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets
//                                                                                       .all(
//                                                                                       8.0),
//                                                                                   child: Container(
//                                                                                     color: Colors
//                                                                                         .grey[200],
//                                                                                     child: Column(
//                                                                                         children: [
//                                                                                           Row(crossAxisAlignment: CrossAxisAlignment
//                                                                                               .center,
//                                                                                               children: [
//                                                                                                 Padding(
//                                                                                                   padding: const EdgeInsets
//                                                                                                       .all(
//                                                                                                       8.0),
//                                                                                                   child: Text(
//                                                                                                       logic
//                                                                                                           .usersWillSendTo[pos]
//                                                                                                           .value ??
//                                                                                                           ""),
//                                                                                                   // child: Container(
//                                                                                                   //   height: 50,
//                                                                                                   //   width: 50,
//                                                                                                   //   // decoration: const BoxDecoration(
//                                                                                                   //   //   shape: BoxShape.circle,
//                                                                                                   //   //   color: Colors.grey,
//                                                                                                   //   // ),
//                                                                                                   // ),
//                                                                                                 ),
//                                                                                                 SizedBox(
//                                                                                                   width: 8,
//                                                                                                 ),
//                                                                                                 Text(
//                                                                                                   "الاسم",
//                                                                                                   style: Theme
//                                                                                                       .of(
//                                                                                                       context)
//                                                                                                       .textTheme
//                                                                                                       .headline3!
//                                                                                                       .copyWith(
//                                                                                                     color: createMaterialColor(
//                                                                                                       const Color
//                                                                                                           .fromRGBO(
//                                                                                                           77,
//                                                                                                           77,
//                                                                                                           77,
//                                                                                                           1),
//                                                                                                     ),
//                                                                                                     fontSize: 15,
//                                                                                                   ),
//                                                                                                   textAlign: TextAlign
//                                                                                                       .center,
//                                                                                                   overflow: TextOverflow
//                                                                                                       .ellipsis,
//                                                                                                 ),
//                                                                                                 Spacer(),
//                                                                                                 GestureDetector(
//                                                                                                   onTap: () {
//                                                                                                     Get
//                                                                                                         .find<
//                                                                                                         InboxController>()
//                                                                                                         .delTousersWillSendTo(
//                                                                                                         user: logic
//                                                                                                             .usersWillSendTo[pos]);
//
//                                                                                                     Get
//                                                                                                         .find<
//                                                                                                         InboxController>()
//                                                                                                         .deltransfarForMany(
//                                                                                                         id: logic
//                                                                                                             .users[pos]
//                                                                                                             .id!);
//                                                                                                   },
//                                                                                                   child: Image
//                                                                                                       .asset(
//                                                                                                     'assets/images/close_button.png',
//                                                                                                     width: 20,
//                                                                                                     height: 20,
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ]),
//                                                                                           SizedBox(
//                                                                                             height: 4,
//                                                                                           ),
//                                                                                           Row(
//                                                                                             children: [
//                                                                                               Expanded(
//                                                                                                 child: Text(
//                                                                                                     "action"
//                                                                                                         .tr),
//                                                                                               ),
//                                                                                               SizedBox(
//                                                                                                 width: 10,
//                                                                                               ),
//                                                                                               Expanded(
//                                                                                                 child: Text(
//                                                                                                     "audioNotes"
//                                                                                                         .tr),
//                                                                                               )
//                                                                                             ],
//                                                                                           ),
//                                                                                           Row(
//                                                                                             children: [
//                                                                                               Expanded(
//                                                                                                 child: Container(
//                                                                                                   height: 40,
//                                                                                                   color: Colors
//                                                                                                       .grey[300],
//                                                                                                   child: DropdownButton<
//                                                                                                       CustomActions>(
//                                                                                                     alignment: Alignment
//                                                                                                         .topRight,
//                                                                                                     value: Get
//                                                                                                         .find<
//                                                                                                         InboxController>()
//                                                                                                         .getactions(
//                                                                                                         logic
//                                                                                                             .usersWillSendTo[pos]
//                                                                                                             .id),
//                                                                                                     icon: const Icon(
//                                                                                                         Icons
//                                                                                                             .arrow_downward),
//                                                                                                     elevation: 16,
//                                                                                                     style: const TextStyle(
//                                                                                                         color: Colors
//                                                                                                             .deepPurple),
//                                                                                                     underline: Container(
//                                                                                                       height: 2,
//                                                                                                       color: Colors
//                                                                                                           .deepPurpleAccent,
//                                                                                                     ),
//                                                                                                     hint: Text(
//                                                                                                         "اختار"),
//                                                                                                     onChanged: (
//                                                                                                         CustomActions? newValue) {
//                                                                                                       logic
//                                                                                                           .setactions(
//                                                                                                           logic
//                                                                                                               .usersWillSendTo[pos]
//                                                                                                               .id,
//                                                                                                           newValue!);
//                                                                                                     },
//                                                                                                     items: Get
//                                                                                                         .find<
//                                                                                                         InboxController>()
//                                                                                                         .customActions
//                                                                                                         ?.map<
//                                                                                                         DropdownMenuItem<
//                                                                                                             CustomActions>>((
//                                                                                                         CustomActions value) {
//                                                                                                       return DropdownMenuItem<
//                                                                                                           CustomActions>(
//                                                                                                         value: value,
//                                                                                                         child: Text(
//                                                                                                             value
//                                                                                                                 .name!),
//                                                                                                       );
//                                                                                                     })
//                                                                                                         .toList(),
//                                                                                                   ),
//                                                                                                 ),
//                                                                                               ),
//                                                                                               const SizedBox(
//                                                                                                 width: 10,
//                                                                                               ),
//                                                                                               Expanded(
//                                                                                                 child: Container(
//                                                                                                     height: 40,
//                                                                                                     color: Colors
//                                                                                                         .grey[300],
//                                                                                                     child: Row(
//                                                                                                       mainAxisAlignment: MainAxisAlignment
//                                                                                                           .spaceBetween,
//                                                                                                       children: [
//                                                                                                         GestureDetector(
//                                                                                                           onTap: () async {
//                                                                                                             // Get.find<InboxController>().recording ? Get.find<InboxController>().stop2() : Get.find<InboxController>().record2();
//
//                                                                                                             Get
//                                                                                                                 .find<
//                                                                                                                 InboxController>()
//                                                                                                                 .recording
//                                                                                                                 ? Get
//                                                                                                                 .find<
//                                                                                                                 InboxController>()
//                                                                                                                 .stopForMany(
//                                                                                                                 id: logic
//                                                                                                                     .usersWillSendTo[pos]
//                                                                                                                     .id!)
//                                                                                                                 : Get
//                                                                                                                 .find<
//                                                                                                                 InboxController>()
//                                                                                                                 .recordForMany();
//                                                                                                           },
//                                                                                                           child: Padding(
//                                                                                                             padding: const EdgeInsets
//                                                                                                                 .all(
//                                                                                                                 8.0),
//                                                                                                             child: GetBuilder<
//                                                                                                                 DocumentController>(
//                                                                                                                 builder: (
//                                                                                                                     logic) {
//                                                                                                                   return Icon(
//                                                                                                                       Get
//                                                                                                                           .find<
//                                                                                                                           InboxController>()
//                                                                                                                           .recording
//                                                                                                                           ? Icons
//                                                                                                                           .stop
//                                                                                                                           : Icons
//                                                                                                                           .mic);
//                                                                                                                 }),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                         Padding(
//                                                                                                           padding: const EdgeInsets
//                                                                                                               .all(
//                                                                                                               8.0),
//                                                                                                           child: InkWell(
//                                                                                                             onTap: () {
//                                                                                                               Get
//                                                                                                                   .find<
//                                                                                                                   InboxController>()
//                                                                                                                   .playRec();
//                                                                                                             },
//                                                                                                             child: Icon(
//                                                                                                                 Icons
//                                                                                                                     .play_arrow),
//                                                                                                           ),
//                                                                                                         )
//                                                                                                       ],
//                                                                                                     )),
//                                                                                               )
//                                                                                             ],
//                                                                                           ),
//                                                                                           SizedBox(
//                                                                                             height: 8,
//                                                                                           ),
//                                                                                           Container(
//                                                                                             child: TextFormField(
//                                                                                               onChanged: (
//                                                                                                   v) {
//                                                                                                 Get
//                                                                                                     .find<
//                                                                                                     InboxController>()
//                                                                                                     .setNots(
//                                                                                                     id: logic
//                                                                                                         .users[pos]
//                                                                                                         .id!,
//                                                                                                     not: v);
//                                                                                               },
//                                                                                               maxLines: 4,
//                                                                                             ),
//                                                                                             color: Colors
//                                                                                                 .grey[300],
//                                                                                           ),
//                                                                                           SizedBox(
//                                                                                             height: 8,
//                                                                                           ),
//                                                                                         ]),
//                                                                                   ),
//                                                                                 );
//                                                                             });
//                                                                     },
//                                                                   ))
//
//                                                               // Container(height: 300,child: ListView.builder( itemCount: 100,itemBuilder: (context,pos){
//                                                               //   return  Padding(
//                                                               //     padding: const EdgeInsets.all(8.0),
//                                                               //     child: Container(color: Colors.grey,child: Column(children: [
//                                                               //       Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                               //           children: [
//                                                               //             Image.asset(
//                                                               //               'assets/images/refer.png'
//                                                               //               //
//                                                               //               ,
//                                                               //               height: 20,
//                                                               //               width: 20,
//                                                               //             ),
//                                                               //             const SizedBox(
//                                                               //               width: 8,
//                                                               //             ),
//                                                               //             Text(
//                                                               //               "refer".tr,
//                                                               //               style: Theme.of(context).textTheme.headline3!.copyWith(
//                                                               //                 color: createMaterialColor(
//                                                               //                   const Color.fromRGBO(77, 77, 77, 1),
//                                                               //                 ),
//                                                               //                 fontSize: 15,
//                                                               //               ),
//                                                               //               textAlign: TextAlign.center,
//                                                               //               overflow: TextOverflow.ellipsis,
//                                                               //             ),
//                                                               //
//                                                               //             Image.asset(
//                                                               //               'assets/images/close_button.png',
//                                                               //               width: 20,
//                                                               //               height: 20,
//                                                               //             ),
//                                                               //             Row(children: [],)
//                                                               //           ]),]),),
//                                                               //   );
//                                                               //
//                                                               // }))
//                                                             ]),
//                                                       ),
//                                                       actions: <Widget>[
//                                                         TextButton(
//                                                           onPressed: () {
//                                                             ReplyWithVoiceNoteApi
//                                                             replayAPI =
//                                                             ReplyWithVoiceNoteApi(
//                                                                 context);
//
//                                                             print(
//                                                                 "i click ok");
//                                                             print(
//                                                                 "Get.find<InboxController>().   =>   ${Get
//                                                                     .find<
//                                                                     InboxController>()
//                                                                     .transfarForMany
//                                                                     .length}");
//                                                             Get
//                                                                 .find<
//                                                                 InboxController>()
//                                                                 .transfarForMany
//                                                                 .forEach((key,
//                                                                 value) async {
//                                                               // ReplyWithVoiceNoteRequestModel v = ReplyWithVoiceNoteRequestModel(
//                                                               //     userId: value.userId
//                                                               //
//                                                               //         .toString(),
//                                                               //     transferId:
//                                                               //     allCorrespondences[pos]
//                                                               //         .transferId,
//                                                               //     token: Get.find<
//                                                               //         InboxController>()
//                                                               //         .secureStorage
//                                                               //         .token(),
//                                                               //     correspondencesId:
//                                                               //     allCorrespondences[pos]
//                                                               //         .correspondenceId,
//                                                               //     language: Get
//                                                               //         .locale
//                                                               //         ?.languageCode ==
//                                                               //         "en"
//                                                               //         ? "en"
//                                                               //         : "ar",
//                                                               //     voiceNote:
//                                                               //     audioFileBes64,
//                                                               //     notes: Get.find<
//                                                               //         InboxController>()
//                                                               //         .replyNote,
//                                                               //     voiceNoteExt:
//                                                               //     "m4a",
//                                                               //     voiceNotePrivate:
//                                                               //     false);
//                                                               //
//                                                               // replayAPI
//                                                               //     .post(v.toMap())
//                                                               //     .then((value) {
//                                                               //   print("1" * 50);
//                                                               //   ReplyWithVoiceNoteModel
//                                                               //   v = value
//                                                               //   as ReplyWithVoiceNoteModel;
//                                                               //   print(v
//                                                               //       .errorMessage);
//                                                               //   print(v.status);
//                                                               //   print("1" * 50);
//                                                               // });
//
//                                                               Get.find<
//                                                                   DocumentController>()
//                                                                   .multipleTransferspost(
//                                                                   context:
//                                                                   context,
//                                                                   transferId:
//                                                                   allCorrespondences[pos]
//                                                                       .transferId,
//                                                                   correspondenceId:
//                                                                   allCorrespondences[pos]
//                                                                       .correspondenceId);
//                                                               print(
//                                                                   "$key      ${value
//                                                                       .toMap()}");
//                                                             });
//                                                             //Navigator.of(context).pop();
//                                                           },
//                                                           child: Text("Ok"),
//                                                         ),
//                                                       ],
//                                                     );
//                                                   });
//                                             } else if (v == 3) {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (ctx) =>
//                                                     AlertDialog(
//                                                       title: Text(" "),
//                                                       content: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(8.0),
//                                                         child: Container(
//                                                           width: MediaQuery
//                                                               .of(
//                                                               context)
//                                                               .size
//                                                               .width *
//                                                               .8,
//                                                           color:
//                                                           Colors.grey[200],
//                                                           child:
//                                                           SingleChildScrollView(
//                                                             child: Column(
//                                                                 mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                                 crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                                 children: [
//                                                                   Text("note"),
//                                                                   SizedBox(
//                                                                     height: 8,
//                                                                   ),
//                                                                   Container(
//                                                                     child:
//                                                                     TextFormField(
//                                                                       maxLines:
//                                                                       4,
//                                                                     ),
//                                                                     color: Colors
//                                                                         .grey[
//                                                                     300],
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: 8,
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       actions: <Widget>[
//                                                         FlatButton(
//                                                           onPressed: () {
//                                                             print(Get
//                                                                 .find<
//                                                                 InboxController>()
//                                                                 .completeCustomActions
//                                                                 ?.name);
//                                                             print(Get
//                                                                 .find<
//                                                                 InboxController>()
//                                                                 .completeCustomActions
//                                                                 ?.icon);
//
//                                                             String data =
//                                                                 'Token=${Get
//                                                                 .find<
//                                                                 InboxController>()
//                                                                 .secureStorage
//                                                                 .token()}&correspondenceId=${correspondences[pos]
//                                                                 .correspondenceId}&transferId=${correspondences[pos]
//                                                                 .transferId}&actionType=${Get
//                                                                 .find<
//                                                                 InboxController>()
//                                                                 .completeCustomActions
//                                                                 ?.name ??
//                                                                 ""}&note=${Get
//                                                                 .find<
//                                                                 InboxController>()
//                                                                 .completeNote}&language=${Get
//                                                                 .locale
//                                                                 ?.languageCode ==
//                                                                 "en"
//                                                                 ? "en"
//                                                                 : "ar"}';
//
//                                                             Get.find<
//                                                                 InboxController>()
//                                                                 .completeInCorrespondence(
//                                                                 context:
//                                                                 context,
//                                                                 data: data);
//
//                                                             Navigator.of(ctx)
//                                                                 .pop();
//                                                           },
//                                                           child: Text("Ok"),
//                                                         ),
//                                                       ],
//                                                     ),
//                                               );
//
//                                               print(Get
//                                                   .find<
//                                                   InboxController>()
//                                                   .customAction
//                                                   ?.name);
//
//                                               print(
//                                                   "  allCorrespondences[pos].purposeId =>   ${allCorrespondences[pos]
//                                                       .purposeId}");
//                                               print(
//                                                   " allCorrespondences[pos].correspondenceId =>   ${allCorrespondences[pos]
//                                                       .correspondenceId}");
//                                               print(
//                                                   "  allCorrespondences[pos].transferId =>   ${allCorrespondences[pos]
//                                                       .transferId}");
//
//                                               print("ppp" * 10);
//                                               print(Get
//                                                   .find<
//                                                   InboxController>()
//                                                   .customAction
//                                                   ?.name);
//                                             } else if (v == 4) {
//                                               //correspondences[pos].
//
//                                             } else if (v == 5) {
//                                               await Get.find<
//                                                   InboxController>()
//                                                   .getFetchBasketList(
//                                                   context: context);
//                                               print(
//                                                   "Get.find<InboxController>().getFetchBasketList()");
//
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (ctx) =>
//                                                     AlertDialog(
//                                                       title: Text(" "),
//                                                       content: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(8.0),
//                                                         child: Container(
//                                                             width: MediaQuery
//                                                                 .of(
//                                                                 context)
//                                                                 .size
//                                                                 .width *
//                                                                 .3,
//                                                             color: Colors
//                                                                 .grey[200],
//                                                             child: ListView
//                                                                 .builder(
//                                                                 itemCount: Get
//                                                                     .find<
//                                                                     InboxController>()
//                                                                     .fetchBasketListModel
//                                                                     ?.baskets
//                                                                     ?.length,
//                                                                 itemBuilder:
//                                                                     (context,
//                                                                     pos) {
//                                                                   return InkWell(
//                                                                     onTap:
//                                                                         () {
//                                                                       print(Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .fetchBasketListModel
//                                                                           ?.baskets?[pos]
//                                                                           .iD);
//
//                                                                       Get
//                                                                           .find<
//                                                                           InboxController>()
//                                                                           .listSelectCorrespondences
//                                                                           .add(
//                                                                           int
//                                                                               .parse(
//                                                                               correspondences[pos]
//                                                                                   .correspondenceId!));
//                                                                       Get.find<
//                                                                           InboxController>()
//                                                                           .addDocumentsToBasket(
//                                                                           context: context,
//                                                                           basketId: Get
//                                                                               .find<
//                                                                               InboxController>()
//                                                                               .fetchBasketListModel
//                                                                               ?.baskets?[pos]
//                                                                               .iD);
//
//                                                                       Get
//                                                                           .back();
//                                                                     },
//                                                                     child:
//                                                                     Card(
//                                                                       elevation:
//                                                                       10,
//                                                                       child:
//                                                                       Column(
//                                                                           children: [
//                                                                             Text(
//                                                                                 Get
//                                                                                     .find<
//                                                                                     InboxController>()
//                                                                                     .fetchBasketListModel
//                                                                                     ?.baskets?[pos]
//                                                                                     .name ??
//                                                                                     ""),
//                                                                             Text(
//                                                                                 Get
//                                                                                     .find<
//                                                                                     InboxController>()
//                                                                                     .fetchBasketListModel
//                                                                                     ?.baskets?[pos]
//                                                                                     .nameAr ??
//                                                                                     ""),
//                                                                             Text(
//                                                                                 "color :${Get
//                                                                                     .find<
//                                                                                     InboxController>()
//                                                                                     .fetchBasketListModel
//                                                                                     ?.baskets?[pos]
//                                                                                     .color}",
//                                                                                 style: TextStyle(
//                                                                                     color: HexColor(
//                                                                                         Get
//                                                                                             .find<
//                                                                                             InboxController>()
//                                                                                             .fetchBasketListModel
//                                                                                             ?.baskets?[pos]
//                                                                                             .color ??
//                                                                                             "#000000"))),
//                                                                           ]),
//                                                                     ),
//                                                                   );
//                                                                 })),
//                                                       ),
//                                                       actions: <Widget>[
//                                                         FlatButton(
//                                                           onPressed: () async {
//                                                             /// ToDo send Replay
//
//                                                             Navigator.of(ctx)
//                                                                 .pop();
//                                                           },
//                                                           child: Text("Ok"),
//                                                         ),
//                                                       ],
//                                                     ),
//                                               );
//                                             }
//                                           }),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               return haveMoreData
//                                   ? SizedBox(
//                                 height: 50,
//                                 width: 50,
//                                 child: Center(
//                                     child: CircularProgressIndicator()),
//                               )
//                                   : SizedBox();
//                             }
//                           },
//                           separatorBuilder: (context, index) => const Divider(),
//                           itemCount: allCorrespondences.length + 1),
//                     ),
//                   ],
//                 ),
//               ]),
//             )

            // Container(
            //     color: Colors.grey,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         SizedBox(
            //           width: 4,
            //         ),
            //         GestureDetector(
            //           onTap: () {
            //             showDialog(
            //               context: context,
            //               builder: (ctx) =>
            //                   AlertDialog(
            //                     title: Text(" "),
            //                     content: Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Container(
            //                           width: MediaQuery
            //                               .of(context)
            //                               .size
            //                               .width *
            //                               .3,
            //                           color: Colors.grey[200],
            //                           child: GetBuilder<
            //                               InboxController>(
            //                               builder: (logic) {
            //                                 return SingleChildScrollView(
            //                                   child: Column(
            //                                     children: [
            //                                       Text("الغاية"),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts1[0]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts1[0],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts1pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts1,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts1[1]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts1[1],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts1pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts1,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts1[2]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts1[2],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts1pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts1,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts1[3]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts1[3],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts1pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts1,
            //                                         ),
            //                                       ),
            //                                       Padding(
            //                                         padding:
            //                                         const EdgeInsets
            //                                             .all(
            //                                             8.0),
            //                                         child: TextField(
            //                                           controller: logic
            //                                               .textEditingControllerFilter,
            //                                           decoration:
            //                                           InputDecoration(
            //                                             hintText: "اخري",
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       SizedBox(
            //                                         height: 30,
            //                                       ),
            //                                       Padding(
            //                                         padding:
            //                                         const EdgeInsets
            //                                             .all(
            //                                             8.0),
            //                                         child: Divider(
            //                                             height: 2,
            //                                             thickness: 2),
            //                                       ),
            //                                       Text("النوع"),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts2[0]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts2[0],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts2pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts2,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts2[1]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts2[1],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts2pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts2,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts2[2]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts2[2],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts2pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts2,
            //                                         ),
            //                                       ),
            //                                       Padding(
            //                                         padding:
            //                                         const EdgeInsets
            //                                             .all(
            //                                             8.0),
            //                                         child: Divider(
            //                                             height: 2,
            //                                             thickness: 2),
            //                                       ),
            //                                       Text("الاولوية"),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts3[0]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts3[0],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts3pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts3,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts3[1]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts3[1],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts3pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts3,
            //                                         ),
            //                                       ),
            //                                       ListTile(
            //                                         title: Text(
            //                                             logic.texts3[2]
            //                                                 .tr),
            //                                         leading: Radio(
            //                                           value: logic
            //                                               .texts3[2],
            //                                           groupValue:
            //                                           logic
            //                                               .selectTexts3pos,
            //                                           onChanged:
            //                                           logic
            //                                               .updateTexts3,
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 );
            //                               })),
            //                     ),
            //                     actions: <Widget>[
            //                       FlatButton(
            //                         onPressed: () async {
            //                           /// ToDo send Replay
            //
            //                           Navigator.of(ctx).pop();
            //                         },
            //                         child: Text("تطبيق"),
            //                       ),
            //                       FlatButton(
            //                         onPressed: () async {
            //                           /// ToDo send Replay
            //                           ///  Navigator.of(
            //                           //                         ctx)
            //                           //                         .pop();
            //                           //    Navigator.of(ctx).pop();
            //                           Get.find<InboxController>()
            //                               .canceldata();
            //                         },
            //                         child: Text("الغاء"),
            //                       ),
            //                     ],
            //                   ),
            //             );
            //           },
            //           child: Text("filter".tr,
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20)),
            //         ),
            //         SizedBox(
            //           width: 8,
            //         ),
            //         InkWell(
            //           onTap: () {
            //             Get.find<InboxController>().setEdit();
            //           },
            //           child: Text(
            //               Get
            //                   .find<InboxController>()
            //                   .edit
            //                   ? "back".tr
            //                   : "Modify".tr,
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20)),
            //         ),
            //         SizedBox(
            //           width: 8,
            //         ),
            //       ],
            //     )),
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

                          Get.find<DocumentController>().pdfViewerkey = null;
                          // Get.find<InboxController>().openfilee(docId: correspondences[pos].purposeId, correspondenceId: correspondences[pos]
                          //     .correspondenceId, transferId:  correspondences[pos].transferId);

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
                                        // Padding(
                                        //   padding:
                                        //   const EdgeInsets.all(8.0),
                                        //   child: ListView.builder(
                                        //       shrinkWrap: true,
                                        //       itemCount:
                                        //       correspondences[pos]
                                        //           .gridInfo
                                        //           ?.length,
                                        //       itemBuilder:
                                        //           (context, index) {
                                        //         return Row(
                                        //           crossAxisAlignment:
                                        //           CrossAxisAlignment
                                        //               .start,
                                        //           mainAxisAlignment:
                                        //           MainAxisAlignment
                                        //               .start,
                                        //           children: [
                                        //             // Container(
                                        //             //     width: MediaQuery.of(
                                        //             //                 context)
                                        //             //             .size
                                        //             //             .width *
                                        //             //         .1,
                                        //             //     child: Text(
                                        //             //       correspondences[
                                        //             //                   pos]
                                        //             //               .gridInfo?[
                                        //             //                   index]
                                        //             //               .label ??
                                        //             //           "",
                                        //             //       softWrap:
                                        //             //           true,
                                        //             //       maxLines: 3,
                                        //             //     )),
                                        //             // SizedBox(
                                        //             //   width: 8,
                                        //             // ),
                                        //
                                        //
                                        //    index==0?         Container(height: 20,width: 20,
                                        //               decoration: BoxDecoration(
                                        //                   color: Theme
                                        //                       .of(
                                        //                       context)
                                        //                       .colorScheme
                                        //                       .primary,shape: BoxShape.circle),):    Padding(
                                        //      padding: const EdgeInsets.all(8.0),
                                        //      child: Container(height: 10,width: 10,
                                        //        decoration: BoxDecoration(
                                        //           shape: BoxShape.circle),),
                                        //    ),SizedBox(width: 8,),
                                        //             index==0?    Expanded(
                                        //               child: Container(
                                        //                 // width: MediaQuery.of(
                                        //                 //     context)
                                        //                 //     .size
                                        //                 //     .width *
                                        //                 //     .3,
                                        //                 child:
                                        //                 Text(
                                        //                   correspondences[
                                        //                   pos]
                                        //                       .gridInfo?[
                                        //                   index]
                                        //                       .value ??
                                        //                       "",
                                        //                   softWrap:
                                        //                   true,
                                        //                   maxLines: 3,
                                        //                 ),
                                        //               ),
                                        //             ):
                                        //
                                        //             Expanded(
                                        //               child: Container(
                                        //                 // width: MediaQuery.of(
                                        //                 //     context)
                                        //                 //     .size
                                        //                 //     .width *
                                        //                 //     .3,
                                        //                 child: Text(
                                        //
                                        //                       "${     correspondences[
                                        //                       pos]
                                        //                           .gridInfo?[
                                        //                       index]
                                        //                           .value}",
                                        //                   softWrap:
                                        //                   true,
                                        //                   maxLines: 3,
                                        //                 ),
                                        //               ),
                                        //             )
                                        //             ,
                                        //           ],
                                        //         );
                                        //
                                        //         // Column(
                                        //         //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //         //     children: [
                                        //         //       // Text(correspondences[pos].fromStructure ??
                                        //         //       //     ""),
                                        //         //       Row(
                                        //         //         mainAxisAlignment:
                                        //         //         MainAxisAlignment.spaceBetween,
                                        //         //         children: [
                                        //         //           Text(correspondences[pos]. ??
                                        //         //               ""),
                                        //         //           Text(correspondences[pos].docDueDate ??
                                        //         //               " "),
                                        //         //         ],
                                        //         //       ),
                                        //         //       Row(
                                        //         //         mainAxisAlignment:
                                        //         //         MainAxisAlignment.spaceBetween,
                                        //         //         children: [
                                        //         //           Text(correspondences[pos].docDueDate ??
                                        //         //               ""),
                                        //         //         ],
                                        //         //       ),
                                        //         //       Row(
                                        //         //         children: [
                                        //         //           if (correspondences[pos]
                                        //         //               .isHighPriority ??
                                        //         //               false)
                                        //         //             iconAndText(
                                        //         //                 iconColor: AppColor,
                                        //         //                 iconData: Icons.lock,
                                        //         //                 title: 'secret'.tr),
                                        //         //           if (correspondences[pos].isLocked ??
                                        //         //               false)
                                        //         //             iconAndText(
                                        //         //                 iconColor: AppColor,
                                        //         //                 iconData:
                                        //         //                 Icons.person_add_disabled,
                                        //         //                 title: 'closed'.tr),
                                        //         //         ],
                                        //         //       )
                                        //         //     ]);
                                        //       }),
                                        // ),
                                        //

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      shape: BoxShape.circle)),
                                            ),
                                            Flexible(
                                              child: Text(
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
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle)),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text("sender".tr,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.5),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                                correspondences[pos].fromUser ??
                                                    "",
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.5),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Spacer()
                                            // Flexible(
                                            //   child: Text(
                                            //     correspondences[
                                            //     pos]
                                            //         .gridInfo?[
                                            //     3]
                                            //         .label ??
                                            //         "",
                                            //     softWrap:
                                            //     true,
                                            //     maxLines: 3,
                                            //   ),
                                            // ),
                                            ,
                                            Text(
                                                correspondences[pos]
                                                        .gridInfo?[3]
                                                        .value ??
                                                    "",
                                                softWrap: true,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.4),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment
                                            //         .spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                              ),

                                              // Container(
                                              //   height: 20,
                                              //   width: 20,
                                              //   decoration: BoxDecoration(
                                              //       color: correspondences[
                                              //                       pos]
                                              //                   .priorityId ==
                                              //               "1"
                                              //           ? Colors.green
                                              //           : Colors.red,
                                              //       shape: BoxShape
                                              //           .circle),
                                              // ),
                                              if (correspondences[pos]
                                                      .priorityId ==
                                                  "1")
                                                Icon(Icons.warning,
                                                    color: RedColor),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              if (correspondences[pos]
                                                      .priorityId ==
                                                  "1")
                                                Text(
                                                  "veryimportant".tr,
                                                  style: TextStyle(
                                                      color: RedColor),
                                                ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              if (correspondences[pos]
                                                      .showLock ??
                                                  false)
                                                Icon(Icons.lock),
                                              if (correspondences[pos]
                                                      .showLock ??
                                                  false)
                                                Text("secret".tr),

                                              SizedBox(
                                                width: 50,
                                              ),
                                              Icon(
                                                  correspondences[pos].isLocked!
                                                      ? Icons.lock
                                                      : Icons.lock_open,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                              if (correspondences[pos]
                                                      .isLocked ??
                                                  false)
                                                Text("closed".tr,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary)),
                                              //   correspondences[pos].priorityId
                                              //  correspondences[pos].purposeId

                                              SizedBox(
                                                width: 50,
                                              )
                                              // Text("sender".tr),
                                              // SizedBox(
                                              //   width: 4,
                                              // ),
                                              // Text(
                                              //     correspondences[pos]
                                              //         .fromUser ??
                                              //         ""),

                                              ,
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
                                  Get.find<InboxController>().edit
                                      ? InkWell(
                                          onTap: () {
                                            print(
                                                "is select      ${correspondences[pos].isSelect}");

                                            print(Get.find<InboxController>()
                                                .listSelectCorrespondences
                                                .length);

                                            if (correspondences[pos].isSelect) {
                                              correspondences[pos].isSelect =
                                                  false;
                                            } else {
                                              correspondences[pos].isSelect =
                                                  true;
                                            }
                                            if (correspondences[pos].isSelect) {
                                              Get.find<InboxController>()
                                                  .listSelectCorrespondences
                                                  .add(int.parse(
                                                      correspondences[pos]
                                                          .correspondenceId!));
                                            } else {
                                              Get.find<InboxController>()
                                                  .listSelectCorrespondences
                                                  .remove(correspondences[pos]);
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
                                                      : "assets/images/uncheck.png"))

                                              //
                                              // Checkbox(
                                              //     value: correspondences[pos].isSelect,
                                              //     onChanged: (v) {
                                              //       correspondences[pos].isSelect = v!;
                                              //       print(  Get.find<InboxController>()
                                              //           .listSelectCorrespondences.length);
                                              //       if(v!){
                                              //
                                              //
                                              //         Get.find<InboxController>()
                                              //             .listSelectCorrespondences
                                              //             .add(correspondences[pos]);
                                              //       }else{
                                              //         Get.find<InboxController>()
                                              //             .listSelectCorrespondences
                                              //             .remove(correspondences[pos]);
                                              //       }
                                              //
                                              //       Get.find<InboxController>()
                                              //           .update();
                                              //     }),
                                              ),
                                        )
                                      : PopupMenuButton(
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          Icons.forward_rounded,
                                                          color: Colors.orange),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text("Reply".tr),
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
                                                      Text("Transfer".tr),
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
                                                      Text("Complete".tr),
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
                                                        Text("Summary".tr),
                                                      ],
                                                    ),
                                                    onTap: functionSummary,
                                                    value: 4,
                                                  ),
                                                PopupMenuItem(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.backpack_sharp,
                                                          color: Colors
                                                              .blueAccent),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text("addtoBasket".tr),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    Get.find<InboxController>()
                                                        .getFetchBasketList(
                                                            context: context);
                                                  },
                                                  value: 5,
                                                ),
                                              ],
                                          enableFeedback: true,
                                          onSelected: (v) async {
                                            // print("*" * 50);
                                            // print(correspondences[pos]
                                            //     .hasSummaries);
                                            // print(correspondences[pos]
                                            //     .correspondenceId);
                                            //
                                            // print(correspondences[pos]
                                            //     .transferId);
                                            //
                                            // print("*" * 50);

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
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                      "name".tr,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline3!
                                                                          .copyWith(
                                                                            color:
                                                                                createMaterialColor(
                                                                              const Color.fromRGBO(77, 77, 77, 1),
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
                                                                    SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          correspondences[pos].fromUser ??
                                                                              ""),
                                                                    ),
                                                                    Spacer(),
                                                                    CircleAvatar(
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                              "assets/images/pr.jpg"),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .cyan,
                                                                      maxRadius:
                                                                          30,
                                                                      minRadius:
                                                                          30,
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
                                                                        value: logic
                                                                            .isPrivate,
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
                                                                          EdgeInsets.all(
                                                                              16)),
                                                                  onChanged:
                                                                      (v) {
                                                                    Get.find<
                                                                            InboxController>()
                                                                        .replyNote = v;
                                                                  },
                                                                  maxLines: 4,
                                                                ),
                                                                color: Colors
                                                                    .grey[300],
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
                                                      onPressed: () async {
                                                        ReplyWithVoiceNoteRequestModel
                                                            v;
                                                        String? audioFileBes64 =
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
                                                              transferId: correspondences[pos]
                                                                  .transferId,
                                                              token: Get.find<
                                                                      InboxController>()
                                                                  .secureStorage
                                                                  .token(),
                                                              correspondencesId:
                                                                  correspondences[pos]
                                                                      .correspondenceId,
                                                              language: Get.locale
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
                                                              language: Get
                                                                          .locale
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
                                                          print("1" * 50);
                                                        });

                                                        /// ToDo send Replay
                                                        Get.find<
                                                                InboxController>()
                                                            .recordFile = null;
                                                        Get.find<
                                                                InboxController>()
                                                            .replyNote = "";
                                                        Navigator.of(ctx).pop();
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
                                                      width:
                                                          MediaQuery.of(context)
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
                                                                  maxLines: 4,
                                                                ),
                                                                color: Colors
                                                                    .grey[300],
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
                                                            'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${correspondences[pos].correspondenceId}&transferId=${correspondences[pos].transferId}&actionType=${Get.find<InboxController>().completeCustomActions?.name ?? ""}&note=${Get.find<InboxController>().completeNote}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';
                                                        Navigator.of(ctx).pop();
                                                        showLoaderDialog(
                                                            context);
                                                        Get.find<
                                                                InboxController>()
                                                            .completeInCorrespondence(
                                                                context:
                                                                    context,
                                                                data: data);
                                                      },
                                                      child: Text("Ok"),
                                                    ),
                                                  ],
                                                ),
                                              );

                                              print(Get.find<InboxController>()
                                                  .customAction
                                                  ?.name);

                                              print(
                                                  "  Correspondences[pos].purposeId =>   ${correspondences[pos].purposeId}");
                                              print(
                                                  " Correspondences[pos].correspondenceId =>   ${correspondences[pos].correspondenceId}");
                                              print(
                                                  "   Correspondences[pos].transferId =>   ${correspondences[pos].transferId}");

                                              print("ppp" * 10);
                                              print(Get.find<InboxController>()
                                                  .customAction
                                                  ?.name);
                                            } else if (v == 4) {
                                              //correspondences[pos].

                                            } else if (v == 5) {
                                              await Get.find<InboxController>()
                                                  .getFetchBasketList(
                                                      context: context);
                                              //    print("Get.find<InboxController>().getFetchBasketList()");

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
                                                            .3,
                                                        color: Colors.grey[200],
                                                        child: ListView.builder(
                                                            itemCount: Get.find<
                                                                    InboxController>()
                                                                .fetchBasketListModel
                                                                ?.baskets
                                                                ?.length,
                                                            itemBuilder:
                                                                (context, pos) {
                                                              return InkWell(
                                                                onTap:
                                                                    () async {
                                                                  Get.find<
                                                                          InboxController>()
                                                                      .listSelectCorrespondences
                                                                      .add(int.parse(
                                                                          correspondences[pos]
                                                                              .correspondenceId!));

                                                                  await Get.find<InboxController>().addDocumentsToBasket(
                                                                      context:
                                                                          context,
                                                                      basketId: Get.find<
                                                                              InboxController>()
                                                                          .fetchBasketListModel
                                                                          ?.baskets?[
                                                                              pos]
                                                                          .iD);
                                                                  Get.back();
                                                                },
                                                                child: Card(
                                                                  elevation: 10,
                                                                  child: Column(
                                                                      children: [
                                                                        Text(Get.find<InboxController>().fetchBasketListModel?.baskets?[pos].name ??
                                                                            ""),
                                                                        Text(Get.find<InboxController>().fetchBasketListModel?.baskets?[pos].nameAr ??
                                                                            ""),
                                                                        Text(
                                                                            "color :${Get.find<InboxController>().fetchBasketListModel?.baskets?[pos].color}")
                                                                      ]),
                                                                ),
                                                              );
                                                            })),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () async {
                                                        /// ToDo send Replay
                                                        print(
                                                            "77777777777777777777777777777777777777777777777777");
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text("Ok"),
                                                    ),
                                                  ],
                                                ),
                                              );
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
                              child: Center(child: CircularProgressIndicator()),
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

  _popUpMenu(context, thepos) async {
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
                      child: GetBuilder<InboxController>(//autoRemove: false,

                          builder: (logic) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (controller.favoriteRecipientsResponse
                                        ?.recipients?.length ??
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                          user: user, thepos: thepos);
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
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            "assets/images/pr.jpg",
                                                          ),
                                                          fit: BoxFit.cover)),
                                                  height: 75,
                                                  width: 75,
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      image: DecorationImage(
                                                          image: MemoryImage(
                                                              dataFromBase64String(controller
                                                                  .favoriteRecipientsResponse!
                                                                  .recipients![
                                                                      pos]
                                                                  .targetPhotoBs64!)),
                                                          fit: BoxFit.cover)),
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
                          controller.correspondences[thepos].transferId!,
                      correspondenceId:
                          controller.correspondences[thepos].correspondenceId);
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
                                                        correspondencesId:
                                                            controller
                                                                .correspondences[
                                                                    pos]
                                                                .correspondenceId!,
                                                        transferId: controller
                                                            .correspondences[
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
}
