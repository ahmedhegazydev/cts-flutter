import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'dart:ui' as ui;

import 'package:get/get.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/document_controller.dart';
import '../controllers/main_controller.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_const.dart';
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

  _buildBody(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    // print(controller.correspondences?.toJson())
    // ;
    var v = controller.correspondences?.toJson();
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
                          print("paperExport");
                        }),
                    PopupMenuItem(
                        child: Text("electronicExport".tr),
                        onTap: () {
                          print("electronicExport");
                        }),
                    PopupMenuItem(
                        child: Text("paperAndElectronicExport".tr),
                        onTap: () {
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
                            onClick: () {},
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
                            onClick: () {},
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
                // Expanded(
                //     flex: 4,
                //     child: Container(
                //         //  color: Colors.red,
                //         child: SfPdfViewer.network(
                //       'http://africau.edu/images/default/sample.pdf',
                //     )
                //
                //         // GetBuilder<DocumentController>(builder: (logic) {
                //         //     return //Container();
                //         //
                //         //       SfPdfViewer.network(
                //         //           'http://africau.edu/images/default/sample.pdf',
                //         //           password: 'syncfusion');
                //         //
                //         //   // Center(
                //         //       //   child: controller.doc == null
                //         //       //       ? const Center(child: CircularProgressIndicator())
                //         //       //       : PDFViewer(document: controller.doc!));
                //         //   }
                //         // ),
                //         )),
                Expanded(
                    flex: 1,
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
                            _itemSideMenu(
                                context: context,
                                title: "sender1".tr,
                                data:
                                    controller.correspondences?.fromUser ?? ""),
                            _itemSideMenu(
                                context: context,
                                title: "assignedFrom".tr,
                                data:
                                    controller.correspondences?.fromStructure ??
                                        ""),
                            _itemSideMenu(
                                context: context,
                                title: "referDate".tr,
                                data: controller.correspondences?.tsfDueDate ??
                                    ""),
                            _itemSideMenu(
                                context: context,
                                title: "assignmentNotes".tr,
                                data:
                                    controller.correspondences?.comments ?? ""),
                          ],
                        ),
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
              ),
            ),
          ],
        ));
  }

  _popUpMenu(context) {
    // for (int i = 0; i < 2; i++) {
    //   list.add(Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Container(
    //       height: 100,
    //       //   width: 100,
    //       color: Colors.red,
    //     ),
    //   ));
    // }
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
                              assignId: true, //tag: "alluser",
                              builder: (logic) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.users.length,
                                    itemBuilder: (context, pos) {
                                      print("*" * 100);
                                      print(logic.users[pos].value
                                          ?.split(" ")
                                          .length);
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
                                              controller.addTousersWillSendTo(
                                                  user: logic.users[pos]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(
                                                        context)
                                                        .colorScheme
                                                        .primary,
                                                    width: 1),
                                              ),
                                              padding:
                                              EdgeInsets.all(2.0),
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
                                                          const EdgeInsets.only(top: 2.0,bottom: 2,right: 8,left: 8),
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
                        width: MediaQuery.of(context).size.width * .8,
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
                                                    "الاسم",
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
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
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
                                                    child:
                                                    DropdownButton<CustomActions>(
                                                      alignment:
                                                          Alignment.topRight,
                                                      //   value: CustomActions,
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
                                                              //    await controller.setRecording();
                                                              await controller
                                                                  .initRecord();
                                                              //
                                                              controller
                                                                      .recording
                                                                  ? controller
                                                                      .stop()
                                                                  : controller
                                                                      .record();
                                                              controller
                                                                  .setRecording();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: GetBuilder<
                                                                      DocumentController>(
                                                                  builder:
                                                                      (logic) {
                                                                return Icon(controller
                                                                        .recording
                                                                    ? Icons.stop
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
                                                                    .play();
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

                    // Container(height: 300,child: ListView.builder( itemCount: 100,itemBuilder: (context,pos){
                    //   return  Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Container(color: Colors.grey,child: Column(children: [
                    //       Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
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
                    //                 color: createMaterialColor(
                    //                   const Color.fromRGBO(77, 77, 77, 1),
                    //                 ),
                    //                 fontSize: 15,
                    //               ),
                    //               textAlign: TextAlign.center,
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //
                    //             Image.asset(
                    //               'assets/images/close_button.png',
                    //               width: 20,
                    //               height: 20,
                    //             ),
                    //             Row(children: [],)
                    //           ]),]),),
                    //   );
                    //
                    // }))
                  ]),
            ),
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
