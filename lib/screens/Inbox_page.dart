import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inbox_controller.dart';
import '../services/json_model/login_model.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button_with_icon.dart';
import '../widgets/custom_listview.dart';

class InboxPage extends GetWidget<InboxController> {
  SecureStorage secureStorage = Get.find<SecureStorage>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<InboxController>(builder: (logic) {
        return Scaffold(
          body: _buildBody(context),
        );
      }),
    );
  }

  _buildBody(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          //side bar
          orientation == Orientation.landscape
              ? Container(
                  width: 260,
                  height: size.height,
                  color: Colors.grey.shade300,
                  child: _buildSideMenu(context),
                )
              : Container(),
          Expanded(
            child: Container(
              // width: size.infinity,
              // height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //top bar
                  Container(
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: _buildTopBar(context),
                  ),

                  //inbox menu (filters with inbox type or with purpose -- depends on the configuration)
                  //and correspondences table view container
                  // Container(
                  //   width: double.infinity,
                  //   height: 10,
                  //   color: Colors.transparent,
                  // ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: _buildTopInboxMenu(context),
                        ),
                        //line separator
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          height: 1,
                        )
                      ],
                    ),
                  ),

                  orientation == Orientation.portrait
                      ? _buildBotomMenuInboxes(context)
                      : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterMail(context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          child: Center(
            child: Row(
              children: [
                GetBuilder<InboxController>(builder: (logic) {
                  return Checkbox(
                      value: controller.unread,
                      onChanged: controller.updateUnread);
                }),
                Text("unread".tr)
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),
        Container(
          child: Center(child: Text("sender".tr)),
        ),
        Container(
          height: size.height * .1,
          width: size.width * .3,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, pos) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.cyan,
                    maxRadius: 30,
                    minRadius: 30,
                  ),
                );
              }),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColor, borderRadius: BorderRadius.circular(8)),
                  // margin: EdgeInsets.only(right: 8, left: 8),
                  //   height: size.height * .03,
                  ////width: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.white,
                      ),
                      Text(
                        "urgent".tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white, fontSize: 21),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8)),
                  //  padding: EdgeInsets.only(right: 8, left: 8),
                  child: Row(
                    children: [
                      Icon(Icons.lock),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "secret".tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.black, fontSize: 21),
                      ),
                    ],
                  ),
                  ////width: 1,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),
        Expanded(
            flex: 1,
            child: Icon(
              Icons.clear,
            ))
      ],
    );
  }

  _buildSideMenu(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 10,
          height: double.infinity,
          color: Colors.grey.shade400,
        ),
        Expanded(
          child: Column(
            children: [
              //hello container
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                width: double.infinity,
                height: 120,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "hello".tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                    FittedBox(
                      child: Text(
                        //  "hello".tr +
                        "${secureStorage.readSecureData(AllStringConst.FirstName)} ${secureStorage.readSecureData(AllStringConst.LastName)}",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: createMaterialColor(
                              const Color.fromRGBO(77, 77, 77, 1),
                            ),
                            fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              //empty space
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.transparent,
              ),
              //side menu filter (filters with inbox type or with purpose -- depends on the configuration)
              Expanded(
                child: _buildSideMenuFilters(context),
              ),
              //department container
              SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //line separator
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    //space
                    Container(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(
                          image: AssetImage(
                            returnImageNameBasedOnOppositeDirection(
                              "assets/images/arrow",
                              context,
                              "png",
                            ),
                          ),
                          fit: BoxFit.contain,
                          width: 35,
                        ),
                        Align(
                          alignment: isDirectionRTL(context)
                              ? FractionalOffset.centerRight
                              : FractionalOffset.centerLeft,
                          child: Text(
                            "sharedServicesAdministration".tr,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: createMaterialColor(
                                        const Color.fromRGBO(77, 77, 77, 1),
                                      ),
                                      fontSize: 15,
                                    ),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 0, bottom: 0),
                  child: Text(
                    "appTitle".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              //  Get.back();
              Navigator.pop(context);
            },
            child: Container(
              width: 120,
              height: double.infinity,
              color: Colors.transparent,
              child: const Image(
                image: AssetImage(
                  'assets/images/menu.png',
                ),
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTopInboxMenu(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 4,
        child: ContainedTabBarView(
          tabs: [
            // Text(
            //   "all".tr,
            //   style: Theme.of(context).textTheme.headline1!.copyWith(
            //         color: Colors.grey,
            //         fontSize: 21,
            //       ),
            // ),
            Text(
              "incoming".tr,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.grey, fontSize: 21),
            ),
            Text(
              "outgoing".tr,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.grey, fontSize: 21),
            ),
            // Text(
            //   "internal".tr,
            //   style: Theme.of(context)
            //       .textTheme
            //       .headline1!
            //       .copyWith(color: Colors.grey, fontSize: 21),
            // ),
          ],
          tabBarProperties: TabBarProperties(
            width: MediaQuery.of(context).size.width,
            height: 70.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 5.0,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black87,
            alignment: TabBarAlignment.start,
          ),
          views: [
            // Center(
            //     child: controller.getData && !controller.addToList
            //         ? const Center(child: CircularProgressIndicator())
            //         : Column(
            //             children: [
            //               _filterMail(context),
            //               Expanded(
            //                 child: CustomListView(
            //                   function: controller.onRefresh(),
            //                   correspondences: controller.correspondences ?? [],
            //                   scrollController: controller.scrollController,
            //                   haveMoreData: controller.haveMoreData,
            //                   onClickItem: () {
            //
            //
            //
            //                  //   Get.toNamed("/DocumentPage");
            //                   },
            //                 ),
            //               ),
            //             ],
            //           )),
            Center(
                child: controller.getData
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Visibility(
                              visible: false, child: _filterMail(context)),
                          Expanded(
                            child: CustomListView(allCorrespondences:  controller.correspondences,
                              customActions: controller.customActions,
                              functionTrunsfer: () {
                                print("functionTrunsfer");
                              },
                              functionSummary: () {
                                print("functionSummary");
                              },
                              functionReply: () async {
                                print("functionReply");

                                // Get.dialog(
                                //   AlertDialog(
                                //     title: const Text('Dialog'),
                                //     content: const Text('This is a dialog'),
                                //     actions: [
                                //       TextButton(
                                //         child: const Text("Close"),
                                //         onPressed: () => Get.back(),
                                //       ),
                                //     ],
                                //   ),
                                // );
                                //
                                //   showDialog(
                                //   context: context,
                                //   builder: (ctx) => AlertDialog(
                                //     title: Text("Show Alert Dialog Box"),
                                //     content:   Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Container(
                                //         color: Colors.grey[200],
                                //         child: Column(children: [
                                //           Row(
                                //               crossAxisAlignment:
                                //               CrossAxisAlignment.center,
                                //               children: [
                                //                 Padding(
                                //                   padding:
                                //                   const EdgeInsets.all(
                                //                       8.0),
                                //                   child: Text(
                                //                       "name"),
                                //                   // child: Container(
                                //                   //   height: 50,
                                //                   //   width: 50,
                                //                   //   // decoration: const BoxDecoration(
                                //                   //   //   shape: BoxShape.circle,
                                //                   //   //   color: Colors.grey,
                                //                   //   // ),
                                //                   // ),
                                //                 ),
                                //                 SizedBox(
                                //                   width: 8,
                                //                 ),
                                //                 Text(
                                //                   "الاسم",
                                //                   style: Theme.of(context)
                                //                       .textTheme
                                //                       .headline3!
                                //                       .copyWith(
                                //                     color:
                                //                     createMaterialColor(
                                //                       const Color
                                //                           .fromRGBO(
                                //                           77, 77, 77, 1),
                                //                     ),
                                //                     fontSize: 15,
                                //                   ),
                                //                   textAlign: TextAlign.center,
                                //                   overflow:
                                //                   TextOverflow.ellipsis,
                                //                 ),
                                //                 Spacer(),
                                //                 GestureDetector(
                                //                   onTap: () {
                                //
                                //
                                //                   },
                                //                   child: Image.asset(
                                //                     'assets/images/close_button.png',
                                //                     width: 20,
                                //                     height: 20,
                                //                   ),
                                //                 ),
                                //               ]),
                                //           SizedBox(
                                //             height: 4,
                                //           ),
                                //           Row(
                                //             children: [
                                //               Expanded(
                                //                 child: Text("action".tr),
                                //               ),
                                //               SizedBox(
                                //                 width: 10,
                                //               ),
                                //               Expanded(
                                //                 child: Text("audioNotes".tr),
                                //               )
                                //             ],
                                //           ),
                                //           Row(
                                //             children: [
                                //               Expanded(
                                //                 child: Container(
                                //                   height: 40,
                                //                   color: Colors.grey[300],
                                //                   child:
                                //                   DropdownButton<CustomActions>(
                                //                     alignment:
                                //                     Alignment.topRight,
                                //                     //   value: CustomActions,
                                //                     icon: const Icon(
                                //                         Icons.arrow_downward),
                                //                     elevation: 16,
                                //                     style: const TextStyle(
                                //                         color: Colors
                                //                             .deepPurple),
                                //                     underline: Container(
                                //                       height: 2,
                                //                       color: Colors
                                //                           .deepPurpleAccent,
                                //                     ),
                                //                     hint: Text("اختار"),
                                //                     onChanged: (CustomActions?
                                //                     newValue) {
                                //                       //  dropdownValue = newValue!;
                                //                     },
                                //                     items: controller
                                //                         .customActions
                                //                         ?.map<
                                //                         DropdownMenuItem<
                                //                             CustomActions>>(
                                //                             (CustomActions
                                //                         value) {
                                //                           return DropdownMenuItem<
                                //                               CustomActions>(
                                //                             value: value,
                                //                             child:
                                //                             Text(value.name!),
                                //                           );
                                //                         }).toList(),
                                //                   ),
                                //                 ),
                                //               ),
                                //               const SizedBox(
                                //                 width: 10,
                                //               ),
                                //               Expanded(
                                //                 child: Container(
                                //                     height: 40,
                                //                     color: Colors.grey[300],
                                //                     child: Row(
                                //                       mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                       children: [
                                //                         GestureDetector(
                                //                           onTap: () async {
                                //
                                //                             controller
                                //                                 .recording
                                //                                 ? controller
                                //                                 .stop2()
                                //                                 : controller
                                //                                 .record2();
                                //
                                //                           },
                                //                           child: Padding(
                                //                             padding:
                                //                             const EdgeInsets
                                //                                 .all(8.0),
                                //                             child: GetBuilder<
                                //                                 InboxController>(
                                //                                 builder:
                                //                                     (logic) {
                                //                                   return Icon(controller
                                //                                       .recording
                                //                                       ? Icons.stop
                                //                                       : Icons
                                //                                       .mic);
                                //                                 }),
                                //                           ),
                                //                         ),
                                //                         Padding(
                                //                           padding:
                                //                           const EdgeInsets
                                //                               .all(8.0),
                                //                           child: InkWell(
                                //                             onTap: () {
                                //                               controller
                                //                                   .playRec();
                                //                             },
                                //                             child: Icon(Icons
                                //                                 .play_arrow),
                                //                           ),
                                //                         )
                                //                       ],
                                //                     )),
                                //               )
                                //             ],
                                //           ),
                                //           SizedBox(
                                //             height: 8,
                                //           ),
                                //           Container(
                                //             child: TextFormField(
                                //               maxLines: 4,
                                //             ),
                                //             color: Colors.grey[300],
                                //           ),
                                //           SizedBox(
                                //             height: 8,
                                //           ),
                                //         ]),
                                //       ),
                                //     ),
                                //     actions: <Widget>[
                                //       FlatButton(
                                //         onPressed: () {
                                //           Navigator.of(ctx).pop();
                                //         },
                                //         child: Text("Ok"),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              },
                              functionComplet: () {
                                print("functionComplet");
                              },
                              function: controller.onRefresh(),
                              correspondences: controller.correspondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                //     Get.toNamed("/DocumentPage");
                              },
                            ),
                          ),
                        ],
                      )),
            Center(
                child: controller.getData
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          Visibility(
                              visible: false, child: _filterMail(context)),
                          Expanded(
                            child: CustomListView(allCorrespondences: controller.correspondences,
                              customActions: controller.customActions,
                              functionTrunsfer: () {
                                print("functionTrunsfer");
                              },
                              functionSummary: () {
                                print("functionSummary");
                              },
                              functionReply: () {
                                print("functionReply");

                                //
                                // Get.dialog(
                                //   AlertDialog(
                                //     title: const Text('Dialog'),
                                //     content: const Text('This is a dialog'),
                                //     actions: [
                                //       TextButton(
                                //         child: const Text("Close"),
                                //         onPressed: () => Get.back(),
                                //       ),
                                //     ],
                                //   ),
                                // );

                                //   showDialog(
                                //   context: context,
                                //   builder: (ctx) => AlertDialog(
                                //     title: Text("Show Alert Dialog Box"),
                                //     content:   Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Container(
                                //         color: Colors.grey[200],
                                //         child: Column(children: [
                                //           Row(
                                //               crossAxisAlignment:
                                //               CrossAxisAlignment.center,
                                //               children: [
                                //                 Padding(
                                //                   padding:
                                //                   const EdgeInsets.all(
                                //                       8.0),
                                //                   child: Text(
                                //                       "name"),
                                //                   // child: Container(
                                //                   //   height: 50,
                                //                   //   width: 50,
                                //                   //   // decoration: const BoxDecoration(
                                //                   //   //   shape: BoxShape.circle,
                                //                   //   //   color: Colors.grey,
                                //                   //   // ),
                                //                   // ),
                                //                 ),
                                //                 SizedBox(
                                //                   width: 8,
                                //                 ),
                                //                 Text(
                                //                   "الاسم",
                                //                   style: Theme.of(context)
                                //                       .textTheme
                                //                       .headline3!
                                //                       .copyWith(
                                //                     color:
                                //                     createMaterialColor(
                                //                       const Color
                                //                           .fromRGBO(
                                //                           77, 77, 77, 1),
                                //                     ),
                                //                     fontSize: 15,
                                //                   ),
                                //                   textAlign: TextAlign.center,
                                //                   overflow:
                                //                   TextOverflow.ellipsis,
                                //                 ),
                                //                 Spacer(),
                                //                 GestureDetector(
                                //                   onTap: () {
                                //
                                //
                                //                   },
                                //                   child: Image.asset(
                                //                     'assets/images/close_button.png',
                                //                     width: 20,
                                //                     height: 20,
                                //                   ),
                                //                 ),
                                //               ]),
                                //           SizedBox(
                                //             height: 4,
                                //           ),
                                //           Row(
                                //             children: [
                                //               Expanded(
                                //                 child: Text("action".tr),
                                //               ),
                                //               SizedBox(
                                //                 width: 10,
                                //               ),
                                //               Expanded(
                                //                 child: Text("audioNotes".tr),
                                //               )
                                //             ],
                                //           ),
                                //           Row(
                                //             children: [
                                //               Expanded(
                                //                 child: Container(
                                //                   height: 40,
                                //                   color: Colors.grey[300],
                                //                   child:
                                //                   DropdownButton<CustomActions>(
                                //                     alignment:
                                //                     Alignment.topRight,
                                //                     //   value: CustomActions,
                                //                     icon: const Icon(
                                //                         Icons.arrow_downward),
                                //                     elevation: 16,
                                //                     style: const TextStyle(
                                //                         color: Colors
                                //                             .deepPurple),
                                //                     underline: Container(
                                //                       height: 2,
                                //                       color: Colors
                                //                           .deepPurpleAccent,
                                //                     ),
                                //                     hint: Text("اختار"),
                                //                     onChanged: (CustomActions?
                                //                     newValue) {
                                //                       //  dropdownValue = newValue!;
                                //                     },
                                //                     items: controller
                                //                         .customActions
                                //                         ?.map<
                                //                         DropdownMenuItem<
                                //                             CustomActions>>(
                                //                             (CustomActions
                                //                         value) {
                                //                           return DropdownMenuItem<
                                //                               CustomActions>(
                                //                             value: value,
                                //                             child:
                                //                             Text(value.name!),
                                //                           );
                                //                         }).toList(),
                                //                   ),
                                //                 ),
                                //               ),
                                //               const SizedBox(
                                //                 width: 10,
                                //               ),
                                //               Expanded(
                                //                 child: Container(
                                //                     height: 40,
                                //                     color: Colors.grey[300],
                                //                     child: Row(
                                //                       mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceBetween,
                                //                       children: [
                                //                         GestureDetector(
                                //                           onTap: () async {
                                //
                                //                             controller
                                //                                 .recording
                                //                                 ? controller
                                //                                 .stop2()
                                //                                 : controller
                                //                                 .record2();
                                //
                                //                           },
                                //                           child: Padding(
                                //                             padding:
                                //                             const EdgeInsets
                                //                                 .all(8.0),
                                //                             child: GetBuilder<
                                //                                 InboxController>(
                                //                                 builder:
                                //                                     (logic) {
                                //                                   return Icon(controller
                                //                                       .recording
                                //                                       ? Icons.stop
                                //                                       : Icons
                                //                                       .mic);
                                //                                 }),
                                //                           ),
                                //                         ),
                                //                         Padding(
                                //                           padding:
                                //                           const EdgeInsets
                                //                               .all(8.0),
                                //                           child: InkWell(
                                //                             onTap: () {
                                //                               controller
                                //                                   .playRec();
                                //                             },
                                //                             child: Icon(Icons
                                //                                 .play_arrow),
                                //                           ),
                                //                         )
                                //                       ],
                                //                     )),
                                //               )
                                //             ],
                                //           ),
                                //           SizedBox(
                                //             height: 8,
                                //           ),
                                //           Container(
                                //             child: TextFormField(
                                //               maxLines: 4,
                                //             ),
                                //             color: Colors.grey[300],
                                //           ),
                                //           SizedBox(
                                //             height: 8,
                                //           ),
                                //         ]),
                                //       ),
                                //     ),
                                //     actions: <Widget>[
                                //       FlatButton(
                                //         onPressed: () {
                                //           Navigator.of(ctx).pop();
                                //         },
                                //         child: Text("Ok"),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              },
                              functionComplet: () {
                                print("functionComplet");
                              },
                              function: controller.onRefresh(),
                              correspondences: controller.correspondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                Get.toNamed("/DocumentPage");
                              },
                            ),
                          ),
                        ],
                      )),
            // Center(
            //     child: controller.getData
            //         ? const Center(child: CircularProgressIndicator())
            //         : Column(
            //             children: [
            //               Visibility(
            //                   visible: false, child: _filterMail(context)),
            //               Expanded(
            //                 child: CustomListView(
            //                   customActions: controller.customActions,
            //                   functionTrunsfer: () {},
            //                   functionSummary: () {},
            //                   functionReply: () async {
            //                     // Get.dialog(
            //                     //   AlertDialog(
            //                     //     title: const Text('Dialog'),
            //                     //     content: const Text('This is a dialog'),
            //                     //     actions: [
            //                     //       TextButton(
            //                     //         child: const Text("Close"),
            //                     //         onPressed: () => Get.back(),
            //                     //       ),
            //                     //     ],
            //                     //   ),
            //                     // );
            //                   },
            //                   functionComplet: () {},
            //                   function: controller.onRefresh(),
            //                   correspondences: controller.correspondences,
            //                   scrollController: controller.scrollController,
            //                   haveMoreData: controller.haveMoreData,
            //                   onClickItem: () {
            //                     Get.toNamed("/DocumentPage");
            //                   },
            //                 ),
            //               ),
            //             ],
            //           )),
          ],
          onChange: (value) {
            controller.getData = true;
            controller.addToList = false;
            controller.index = 0;
            if (value == 0) {
              //  Globals.inboxIdForCorrespondencesList = 5;

              controller.inboxId = 5;
              controller.getCorrespondencesData(inboxId: 5);
            } else if (value == 1) {
              controller.inboxId = 1;
              controller.getCorrespondencesData(inboxId: 1);
              //     Globals.inboxIdForCorrespondencesList = 1;
              controller.inboxId = 1;
            } else if (value == 2) {
              controller.inboxId = 5;
              controller.getCorrespondencesData(inboxId: 5);
              //  Globals.inboxIdForCorrespondencesList = 5;
            } else if (value == 3) {
              controller.inboxId = 3;
              controller.getCorrespondencesData(inboxId: 3);
              //   Globals.inboxIdForCorrespondencesList = 3;
            }
            //  else {
            //    controller.     getCorrespondencesData(index: 5);
            // //   Globals.inboxIdForCorrespondencesList = 5;
            //  }
            //  print(Globals.inboxIdForCorrespondencesList);
          },
        ),
      ),
    );
  }

  _buildSideMenuFilters(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildSideMenuTitleLabel(context, "mail".tr),
            //line separator
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              height: 1,
            ),
            _buildSideMenuInboxes(context),
            //space
            Container(
              width: double.infinity,
              height: 20,
            ),
            _buildSideMenuTitleLabel(
              context,
              "folders".tr,
            ),
            //line separator
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              height: 1,
            ),
            _buildSideMenuFolders(
                context, "flagged".tr, "assets/images/flagged.png", true, 05),
            _buildSideMenuFolders(context, "notifications".tr,
                "assets/images/notification.png", true, 19)
          ],
        ),
      ),
    );
  }

  _buildSideMenuTitleLabel(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
      color: Colors.transparent,
      width: double.infinity,
      height: calculateHeight(50, context),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Colors.grey.shade500, fontSize: 15),
        textAlign: TextAlign.start,
      ),
    );
  }

  _buildSideMenuInboxes(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            // onTap:,
            child: SizedBox(
              //   width: double.infinity,
              height: calculateHeight(80, context),
              child: Align(
                alignment: isDirectionRTL(context)
                    ? FractionalOffset.centerLeft
                    : FractionalOffset.centerRight,
                child: Text(
                  "allInbox".tr,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: createMaterialColor(
                          Color.fromRGBO(100, 100, 100, 1),
                        ),
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          SizedBox(
            //width: double.infinity,
            height: 80,
            child: Align(
              alignment: isDirectionRTL(context)
                  ? FractionalOffset.centerLeft
                  : FractionalOffset.centerRight,
              child: Text(
                "forAction".tr,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: createMaterialColor(
                      const Color.fromRGBO(100, 100, 100, 1),
                    ),
                    fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            height: calculateHeight(80, context),
            child: Align(
              alignment: isDirectionRTL(context)
                  ? FractionalOffset.centerLeft
                  : FractionalOffset.centerRight,
              child: Text(
                "forSignature".tr,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: createMaterialColor(
                        const Color.fromRGBO(100, 100, 100, 1),
                      ),
                      fontSize: 20,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: Align(
              alignment: isDirectionRTL(context)
                  ? FractionalOffset.centerLeft
                  : FractionalOffset.centerRight,
              child: Text(
                "forInfo".tr,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: createMaterialColor(
                        Color.fromRGBO(100, 100, 100, 1),
                      ),
                      fontSize: 20,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildBotomMenuInboxes(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      // width: double.infinity,
      // color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              // onTap:,
              child: SizedBox(
                width: size.width * .2,
                height: calculateHeight(80, context),
                child: Align(
                  alignment: isDirectionRTL(context)
                      ? FractionalOffset.centerRight
                      : FractionalOffset.centerLeft,
                  child: Text(
                    "allInbox".tr,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: createMaterialColor(
                            Color.fromRGBO(100, 100, 100, 1),
                          ),
                          fontSize: 20,
                        ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              //  width: size.width*.2,
              height: calculateHeight(80, context),
              child: Align(
                alignment: isDirectionRTL(context)
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                child: Text(
                  "forAction".tr,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: createMaterialColor(
                        const Color.fromRGBO(100, 100, 100, 1),
                      ),
                      fontSize: 20),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: calculateHeight(80, context),
              child: Align(
                alignment: isDirectionRTL(context)
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                child: Text(
                  "forSignature".tr,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: createMaterialColor(
                          const Color.fromRGBO(100, 100, 100, 1),
                        ),
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              //  width: size.width*.2,
              height: calculateHeight(80, context),
              child: Align(
                alignment: isDirectionRTL(context)
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                child: Text(
                  "forInfo".tr,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: createMaterialColor(
                          Color.fromRGBO(100, 100, 100, 1),
                        ),
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSideMenuFolders(BuildContext context, String title, String iconTitle,
      bool showCount, int count) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80, context),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.transparent,
            child: Image(
              image: AssetImage(
                iconTitle,
              ),
              fit: BoxFit.contain,
              width: 30,
              height: double.infinity,
            ),
          ),
          Container(
            width: 15,
            height: double.infinity,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.grey, fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }






//
//
// _popUpMenu(context) {
//   // for (int i = 0; i < 2; i++) {
//   //   list.add(Padding(
//   //     padding: const EdgeInsets.all(8.0),
//   //     child: Container(
//   //       height: 100,
//   //       //   width: 100,
//   //       color: Colors.red,
//   //     ),
//   //   ));
//   // }
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset(
//                   'assets/images/refer.png'
//                   //
//                   ,
//                   height: 20,
//                   width: 20,
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   "refer".tr,
//                   style: Theme.of(context).textTheme.headline3!.copyWith(
//                     color: createMaterialColor(
//                       const Color.fromRGBO(77, 77, 77, 1),
//                     ),
//                     fontSize: 15,
//                   ),
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () {
//
//                     Navigator.pop(context);
//                   },
//                   child: Image.asset(
//                     'assets/images/close_button.png',
//                     width: 20,
//                     height: 20,
//                   ),
//                 ),
//               ]),
//           content: SingleChildScrollView(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .primary),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(6))),
//                               child: TextField(
//                                 decoration: const InputDecoration(
//                                   border: UnderlineInputBorder(),
//                                   labelText: 'To',
//                                 ),
//                                 onChanged: Get.find<InboxController>().filterUser,
//                               ))),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       CustomButtonWithIcon(
//                           icon: Icons.person,
//                           onClick: () {
//                             controller.listOfUser(0);
//                           }),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       CustomButtonWithIcon(
//                           icon: Icons.account_balance,
//                           onClick: () {
//                             controller.listOfUser(1);
//                           }),
//                       const SizedBox(
//                         width: 2,
//                       ),
//                       CustomButtonWithIcon(
//                           icon: Icons.person,
//                           onClick: () {
//                             controller.listOfUser(2);
//                           }),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text("referTo".tr),
//                   SizedBox(
//                       width: MediaQuery.of(context).size.width * .8,
//                       height: 100,
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: GetBuilder<InboxController>(
//                                 assignId: true, //tag: "alluser",
//                                 builder: (logic) {
//                                   return ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: controller.users.length,
//                                       itemBuilder: (context, pos) {
//                                         print("*" * 100);
//                                         print(logic.users[pos].value
//                                             ?.split(" ")
//                                             .length);
//                                         List<String>? a =
//                                         logic.users[pos].value?.split(" ");
//
//                                         // bool a=logic.user?[pos].value?.contains(logic.filterWord)??false;
//                                         if (logic.users[pos].value
//                                             ?.contains(logic.filterWord) ??
//                                             false) {
//                                           return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 controller.addTousersWillSendTo(
//                                                     user: logic.users[pos]);
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Theme.of(
//                                                           context)
//                                                           .colorScheme
//                                                           .primary,
//                                                       width: 1),
//                                                 ),
//                                                 padding:
//                                                 EdgeInsets.all(2.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       height: 50,
//                                                       width: 50,
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: Theme.of(context)
//                                                             .colorScheme
//                                                             .primary,
//                                                       ),
//                                                       child: Center(
//                                                           child: FittedBox(
//                                                               child: Text(
//                                                                   "${a?[0][0]} ${a?[0][0] ?? ""}"))),
//                                                     ),
//                                                     Padding(
//                                                         padding:
//                                                         const EdgeInsets.only(top: 2.0,bottom: 2,right: 8,left: 8),
//                                                         child: Text(
//                                                           logic.users[pos]
//                                                               .value ??
//                                                               "",
//                                                           maxLines: 3,
//                                                           softWrap: true,
//                                                         )
//
//                                                       //
//                                                       // Container(
//                                                       //   height: 50,
//                                                       //   width: 50,
//                                                       //   decoration: const BoxDecoration(
//                                                       //       shape: BoxShape.circle,
//                                                       //       color: Colors.green),
//                                                       // ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         } else {
//                                           return SizedBox();
//                                         }
//                                       });
//                                 },
//                               )),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               child: const Icon(Icons.clear),
//                               height: 50,
//                               width: 50,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),
//                   const Divider(
//                     color: Colors.grey,
//                   ),
//                   SizedBox(
//                       width: MediaQuery.of(context).size.width * .8,
//                       height: 300, // MediaQuery.of(context).size.height * .5,
//                       child: GetBuilder<InboxController>(
//                         //   assignId: true,//tag: "user",
//                         builder: (logic) {
//                           return //Text(logic.filterWord);
//
//                             ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 itemCount:
//                                 controller.usersWillSendTo.length,
//                                 itemBuilder: (context, pos) {
//                                   return //Text(controller.filterWord);
//
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         color: Colors.grey[200],
//                                         child: Column(children: [
//                                           Row(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(
//                                                       8.0),
//                                                   child: Text(logic
//                                                       .usersWillSendTo[
//                                                   pos]
//                                                       .value ??
//                                                       ""),
//                                                   // child: Container(
//                                                   //   height: 50,
//                                                   //   width: 50,
//                                                   //   // decoration: const BoxDecoration(
//                                                   //   //   shape: BoxShape.circle,
//                                                   //   //   color: Colors.grey,
//                                                   //   // ),
//                                                   // ),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 8,
//                                                 ),
//                                                 Text(
//                                                   "الاسم",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .headline3!
//                                                       .copyWith(
//                                                     color:
//                                                     createMaterialColor(
//                                                       const Color
//                                                           .fromRGBO(
//                                                           77, 77, 77, 1),
//                                                     ),
//                                                     fontSize: 15,
//                                                   ),
//                                                   textAlign: TextAlign.center,
//                                                   overflow:
//                                                   TextOverflow.ellipsis,
//                                                 ),
//                                                 Spacer(),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     controller
//                                                         .delTousersWillSendTo(
//                                                         user: logic
//                                                             .usersWillSendTo[
//                                                         pos]);
//                                                   },
//                                                   child: Image.asset(
//                                                     'assets/images/close_button.png',
//                                                     width: 20,
//                                                     height: 20,
//                                                   ),
//                                                 ),
//                                               ]),
//                                           SizedBox(
//                                             height: 4,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Text("action".tr),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                 child: Text("audioNotes".tr),
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   height: 40,
//                                                   color: Colors.grey[300],
//                                                   child:
//                                                   DropdownButton<CustomActions>(
//                                                     alignment:
//                                                     Alignment.topRight,
//                                                     //   value: CustomActions,
//                                                     icon: const Icon(
//                                                         Icons.arrow_downward),
//                                                     elevation: 16,
//                                                     style: const TextStyle(
//                                                         color: Colors
//                                                             .deepPurple),
//                                                     underline: Container(
//                                                       height: 2,
//                                                       color: Colors
//                                                           .deepPurpleAccent,
//                                                     ),
//                                                     hint: Text("اختار"),
//                                                     onChanged: (CustomActions?
//                                                     newValue) {
//                                                       //  dropdownValue = newValue!;
//                                                     },
//                                                     items: controller
//                                                         .customActions
//                                                         ?.map<
//                                                         DropdownMenuItem<
//                                                             CustomActions>>(
//                                                             (CustomActions
//                                                         value) {
//                                                           return DropdownMenuItem<
//                                                               CustomActions>(
//                                                             value: value,
//                                                             child:
//                                                             Text(value.name!),
//                                                           );
//                                                         }).toList(),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                 child: Container(
//                                                     height: 40,
//                                                     color: Colors.grey[300],
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                       children: [
//                                                         GestureDetector(
//                                                           onTap: () async {
//
//                                                             controller
//                                                                 .recording
//                                                                 ? controller
//                                                                 .stop2()
//                                                                 : controller
//                                                                 .record2();
//
//                                                           },
//                                                           child: Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                             child: GetBuilder<
//                                                                 InboxController>(
//                                                                 builder:
//                                                                     (logic) {
//                                                                   return Icon(controller
//                                                                       .recording
//                                                                       ? Icons.stop
//                                                                       : Icons
//                                                                       .mic);
//                                                                 }),
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                           const EdgeInsets
//                                                               .all(8.0),
//                                                           child: InkWell(
//                                                             onTap: () {
//                                                               controller
//                                                                   .playRec();
//                                                             },
//                                                             child: Icon(Icons
//                                                                 .play_arrow),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 8,
//                                           ),
//                                           Container(
//                                             child: TextFormField(
//                                               maxLines: 4,
//                                             ),
//                                             color: Colors.grey[300],
//                                           ),
//                                           SizedBox(
//                                             height: 8,
//                                           ),
//                                         ]),
//                                       ),
//                                     );
//                                 });
//                         },
//                       ))
//
//                   // Container(height: 300,child: ListView.builder( itemCount: 100,itemBuilder: (context,pos){
//                   //   return  Padding(
//                   //     padding: const EdgeInsets.all(8.0),
//                   //     child: Container(color: Colors.grey,child: Column(children: [
//                   //       Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Image.asset(
//                   //               'assets/images/refer.png'
//                   //               //
//                   //               ,
//                   //               height: 20,
//                   //               width: 20,
//                   //             ),
//                   //             const SizedBox(
//                   //               width: 8,
//                   //             ),
//                   //             Text(
//                   //               "refer".tr,
//                   //               style: Theme.of(context).textTheme.headline3!.copyWith(
//                   //                 color: createMaterialColor(
//                   //                   const Color.fromRGBO(77, 77, 77, 1),
//                   //                 ),
//                   //                 fontSize: 15,
//                   //               ),
//                   //               textAlign: TextAlign.center,
//                   //               overflow: TextOverflow.ellipsis,
//                   //             ),
//                   //
//                   //             Image.asset(
//                   //               'assets/images/close_button.png',
//                   //               width: 20,
//                   //               height: 20,
//                   //             ),
//                   //             Row(children: [],)
//                   //           ]),]),),
//                   //   );
//                   //
//                   // }))
//                 ]),
//           ),
//         );
//       });
//
//   // showCupertinoDialog(
//   //     context: context,
//   //     builder: (context) => CupertinoAlertDialog(
//   //           title: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //               children: [
//   //             Image.asset(
//   //               'assets/images/refer.png'
//   //               //
//   //               ,
//   //               height: 20,
//   //               width: 20,
//   //             ),
//   //             const SizedBox(
//   //               width: 8,
//   //             ),
//   //             Text(
//   //               "refer".tr,
//   //               style: Theme.of(context).textTheme.headline3!.copyWith(
//   //                     color: createMaterialColor(
//   //                       const Color.fromRGBO(77, 77, 77, 1),
//   //                     ),
//   //                     fontSize: 15,
//   //                   ),
//   //               textAlign: TextAlign.center,
//   //               overflow: TextOverflow.ellipsis,
//   //             ),
//   //             const Spacer(),
//   //             Image.asset(
//   //               'assets/images/close_button.png',
//   //               width: 20,
//   //               height: 20,
//   //             ),
//   //           ]),
//   //           content: Container(width: MediaQuery.of(context).size.width*.8,
//   //             child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   const SizedBox(
//   //                     height: 20,
//   //                   ),
//   //                   Text("referTo".tr),
//   //                   Container(
//   //                       height: 100,
//   //                       child: Row(
//   //                         children: [
//   //
//   //                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 10,itemBuilder: (context,pos){
//   //                        return Container(
//   //                          height: 30,
//   //                          width: 30,
//   //                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
//   //                        );
//   //                      }))  , Padding(
//   //                             padding: const EdgeInsets.all(8.0),
//   //                             child: Container(
//   //                               height: 30,
//   //                               width: 30,
//   //                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
//   //                             ),
//   //                           ), ],
//   //                       ))
//   //                 ]),
//   //           ),
//   //           actions: [],
//   //         ));
// }


}
