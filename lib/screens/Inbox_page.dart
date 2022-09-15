import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../services/apis/reply_with_voice_note_api.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/reply_with_voicenote_model.dart';
import '../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button_with_icon.dart';
import '../widgets/custom_listview.dart';

class InboxPage extends GetWidget<InboxController> {
  SecureStorage secureStorage = Get.put(SecureStorage());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<InboxController>(autoRemove: false,builder: (logic) {
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
                  width: 200,
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
                    height: 100,
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
                        // controller.getData
                        //     ? const Center(child: CircularProgressIndicator())
                        //     :
                        controller.isAllOrNot
                            ?




                        Expanded(
                          child: CustomListView(
                            function: controller.onRefresh(),
                            correspondences: controller.allCorrespondences,
                            scrollController: controller.scrollController,
                            haveMoreData: controller.haveMoreData,
                            onClickItem: () {
                              //     Get.toNamed("/DocumentPage");
                            },
                            functionSummary: () {},
                            //allCorrespondences: controller.allCorrespondences,
                            customActions: controller.customActions,
                            functionReply: () {},
                            functionTrunsfer: () {},
                            functionComplet: () {},
                          ),
                        )

                            :
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
                GetBuilder<InboxController>(autoRemove: false,builder: (logic) {
                  return Checkbox(
                      value: controller.unread,
                      onChanged: controller.updateUnread);
                }),
                Text("unread".tr,
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(.7)))
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          child: Center(
              child: Text(
            "sender".tr,
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.7)),
          )),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            height: size.height * .1,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, pos) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/pr.jpg"),
                      backgroundColor: Colors.cyan,
                      maxRadius: 30,
                      minRadius: 30,
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),
        SizedBox(
          width: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                controller.setIsUrgentFilterClicked(!controller.isUrgentClicked);
              },
              child: Container(
                width: 160, padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: controller.isUrgentClicked ? AppColor : Colors.grey[400],
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                // margin: EdgeInsets.only(right: 8, left: 8),
                //   height: size.height * .03,
                ////width: 1,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.warning,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "urgent".tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 16,
            // ),
            // Container(
            //   width: 160, padding: EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(8)),
            //   //  padding: EdgeInsets.only(right: 8, left: 8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(Icons.lock, color: Colors.black.withOpacity(.6)),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "secret".tr,
            //         style: Theme.of(context).textTheme.headline1!.copyWith(
            //             color: Colors.black.withOpacity(.6), fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),
        SizedBox(
          width: 16,
        ),
        Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ),
        SizedBox(
          width: 16,
        ),
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
              // child: const Image(
              //   image: AssetImage(
              //     'assets/images/menu.png',
              //   ),
              //   fit: BoxFit.contain,
              //   width: double.infinity,
              //   height: double.infinity,
              // ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
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
        length: 3,
        child: ContainedTabBarView(
          tabs: [
            Text(
              "all".tr,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.grey,
                    fontSize: 21,
                  ),
            ),
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
            width: MediaQuery.of(context).size.width * .3,
            height: 70.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 5.0,
            labelColor: Colors.black.withOpacity(.7),
            unselectedLabelColor: Colors.black.withOpacity(.5),
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
                              visible: true, child: _filterMail(context)),
                          Expanded(
                            child: CustomListView(
                              function: controller.onRefresh(),
                              correspondences: controller.allCorrespondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                //     Get.toNamed("/DocumentPage");
                              },
                              functionSummary: () {},
                              //allCorrespondences: controller.allCorrespondences,
                              customActions: controller.customActions,
                              functionReply: () {},
                              functionTrunsfer: () {},
                              functionComplet: () {},
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
                              visible: true, child: _filterMail(context)),
                          Expanded(
                            child: CustomListView(
                              function: controller.onRefresh(),
                              correspondences: controller.allCorrespondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                Get.toNamed("/DocumentPage");
                              },
                              functionSummary: () {},
                              //allCorrespondences: controller.allCorrespondences,
                              customActions: controller.customActions,
                              functionReply: () {},
                              functionTrunsfer: () {},
                              functionComplet: () {},
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
                              visible: true, child: _filterMail(context)),
                          Expanded(
                            child: CustomListView(
                              function: controller.onRefresh(),
                              correspondences: controller.allCorrespondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                Get.toNamed("/DocumentPage");
                              },
                              functionSummary: () {},
                              //allCorrespondences: [],
                              customActions: [],
                              functionReply: () {},
                              functionTrunsfer: () {},
                              functionComplet: () {},
                            ),
                          ),
                        ],
                      )),
            // Center(
            //     child: controller.getData
            //         ? const Center(child: CircularProgressIndicator())
            //         : Column(
            //       children: [
            //
            //         Visibility(visible: true,child: _filterMail(context)),
            //
            //
            //
            //
            //
            //
            //
            //         Expanded(
            //           child: CustomListView(
            //             function: controller.onRefresh(),
            //             correspondences: controller.correspondences ,
            //             scrollController: controller.scrollController,
            //             haveMoreData: controller.haveMoreData,
            //             onClickItem: () {
            //               Get.toNamed("/DocumentPage");
            //             }, functionSummary: () {  }, allCorrespondences: [], customActions: [], functionReply: () {  }, functionTrunsfer: () {  }, functionComplet: () {  },
            //           ),
            //         ),
            //       ],
            //     )),
          ],
          onChange: (value) {
            controller.getData = true;
            controller.addToList = false;
            controller.index = 0;
            if (value == 0) {
              //  Globals.inboxIdForCorrespondencesList = 5;

              controller.inboxId = 0;
              controller.getCorrespondencesData(context: context, inboxId: 0);
            } else if (value == 1) {
              controller.inboxId = 1;
              controller.getCorrespondencesData(context: context, inboxId: 1);
              //     Globals.inboxIdForCorrespondencesList = 1;
              controller.inboxId = 1;
            } else if (value == 2) {
              controller.inboxId = 5;
              controller.getCorrespondencesData(context: context, inboxId: 5);
              //  Globals.inboxIdForCorrespondencesList = 5;
            }
            // else if (value == 3) {
            //   controller.inboxId = 3;
            //   controller.getCorrespondencesData(context: context, inboxId: 3);
            //   //   Globals.inboxIdForCorrespondencesList = 3;
            // }
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
                context,
                // "flagged".tr,
                "allincom".tr,
                "assets/images/incoming_icon.png",
                true,
                "",() {
              controller.nodeId=0;
              Get.find<InboxController>().isAllOrNot=true;
              Get.find<InboxController>().getAllCorrespondencesData(context: context, inboxId: 1);
              controller.update();
                }),
            _buildSideMenuFolders(
                context,
                // "notifications".tr,
                "allout".tr,
                "assets/images/outgoing_icon.png",
                false,
                 ""
              ,() {
             controller.nodeId=0;
              Get.find<InboxController>().isAllOrNot=true;
              Get.find<InboxController>().getAllCorrespondencesData(context: context, inboxId: 5);
              controller.update();
              }
                ,)
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
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: Get.find<LandingPageController>()
                .dashboardStatsResultModel!
                .inboxCategories
                ?.length,
            itemBuilder: (context, pos) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // decoration: BoxDecoration(color:  Get.find<LandingPageController>()
                  //   .dashboardStatsResultModel!
                  //   .inboxCategories![pos].value!.nodeId==controller.nodeId?Colors.red:Colors.orange),
                  child: GestureDetector(
                    onTap: () {

                      controller.nodeId = Get.find<LandingPageController>()
                          .dashboardStatsResultModel!
                          .inboxCategories![pos]
                          .value!
                          .nodeId;
controller.isAllOrNot=false;
                      controller.getCorrespondencesData(
                          context: context, inboxId: controller.inboxId);
                      controller.update();
                    },
                    // onTap:,
                    child: SizedBox(
                      //   width: double.infinity,
                      height: calculateHeight(80, context),
                      child: Align(
                        alignment: isDirectionRTL(context)
                            ? FractionalOffset.centerLeft
                            : FractionalOffset.centerRight,
                        child: Text(
                          Get.find<LandingPageController>()
                              .dashboardStatsResultModel!
                              .inboxCategories![pos]
                              .key!,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                color: createMaterialColor(
                                  Get.find<LandingPageController>()
                                              .dashboardStatsResultModel!
                                              .inboxCategories![pos]
                                              .value!
                                              .nodeId ==
                                          controller.nodeId
                                      ? Theme.of(context).colorScheme.primary
                                      : gray,
                                ),
                                fontSize: 20,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })

        //     Get.find<LandingPageController>()!
        //     .dashboardStatsResultModel!
        //     .inboxCategories!
        //     .map(
        //       (e) => TableRow(
        //     children: [
        //       TableRowInkWell(
        //         onTap: () {
        //
        //           //   openInbox(context);
        //         },
        //         child: _buildInboxesRow(
        //           context,
        //           e.key!,
        //           e.value!.count!,
        //         ),
        //       ),
        //     ],
        //   ),
        // )
        //     .toList(),
        //
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     GestureDetector(
        //       // onTap:,
        //       child: SizedBox(
        //         //   width: double.infinity,
        //         height: calculateHeight(80, context),
        //         child: Align(
        //           alignment: isDirectionRTL(context)
        //               ? FractionalOffset.centerLeft
        //               : FractionalOffset.centerRight,
        //           child: Text(
        //             "allInbox".tr,
        //             style: Theme.of(context).textTheme.headline1!.copyWith(
        //                   color: createMaterialColor(
        //                     Color.fromRGBO(100, 100, 100, 1),
        //                   ),
        //                   fontSize: 20,
        //                 ),
        //             textAlign: TextAlign.start,
        //           ),
        //         ),
        //       ),
        //     ),
        //     // SizedBox(
        //     //   //width: double.infinity,
        //     //   height: 80,
        //     //   child: Align(
        //     //     alignment: isDirectionRTL(context)
        //     //         ? FractionalOffset.centerLeft
        //     //         : FractionalOffset.centerRight,
        //     //     child: Text(
        //     //       "forAction".tr,
        //     //       style: Theme.of(context).textTheme.headline1!.copyWith(
        //     //           color: createMaterialColor(
        //     //             const Color.fromRGBO(100, 100, 100, 1),
        //     //           ),
        //     //           fontSize: 20),
        //     //       textAlign: TextAlign.start,
        //     //     ),
        //     //   ),
        //     // ),
        //     // SizedBox(
        //     //   height: calculateHeight(80, context),
        //     //   child: Align(
        //     //     alignment: isDirectionRTL(context)
        //     //         ? FractionalOffset.centerLeft
        //     //         : FractionalOffset.centerRight,
        //     //     child: Text(
        //     //       "forSignature".tr,
        //     //       style: Theme.of(context).textTheme.headline1!.copyWith(
        //     //             color: createMaterialColor(
        //     //               const Color.fromRGBO(100, 100, 100, 1),
        //     //             ),
        //     //             fontSize: 20,
        //     //           ),
        //     //       textAlign: TextAlign.start,
        //     //     ),
        //     //   ),
        //     // ),
        //     // SizedBox(
        //     //   width: double.infinity,
        //     //   height: 80,
        //     //   child: Align(
        //     //     alignment: isDirectionRTL(context)
        //     //         ? FractionalOffset.centerLeft
        //     //         : FractionalOffset.centerRight,
        //     //     child: Text(
        //     //       "forInfo".tr,
        //     //       style: Theme.of(context).textTheme.headline1!.copyWith(
        //     //             color: createMaterialColor(
        //     //               Color.fromRGBO(100, 100, 100, 1),
        //     //             ),
        //     //             fontSize: 20,
        //     //           ),
        //     //       textAlign: TextAlign.start,
        //     //     ),
        //     //   ),
        //     // )
        //   ],
        // ),
        //
        //

        );
  }

  _buildBotomMenuInboxes(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      // width: double.infinity,
      // color: Colors.transparent,
      child: Row(
          children: Get.find<LandingPageController>()
              .dashboardStatsResultModel!
              .inboxCategories!
              .map(
                (e) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.nodeId = e.value!.nodeId;
                      controller.getCorrespondencesData(
                          context: context, inboxId: controller.inboxId);



                      // controller.nodeId = Get.find<LandingPageController>()
                      //     .dashboardStatsResultModel!
                      //     .inboxCategories![pos]
                      //     .value!
                      //     .nodeId;
                      controller.isAllOrNot=false;
                      // controller.getCorrespondencesData(
                      //     context: context, inboxId: controller.inboxId);
                      controller.update();
                    },
                    // onTap:,
                    child: SizedBox(
                      width: size.width * .2,
                      height: calculateHeight(80, context),
                      child: Align(
                        alignment: isDirectionRTL(context)
                            ? FractionalOffset.centerRight
                            : FractionalOffset.centerLeft,
                        child: Text(
                          e.key!,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                color: createMaterialColor(
                                  e.value!.nodeId == controller.nodeId
                                      ? Theme.of(context).colorScheme.primary
                                      : gray,
                                ),
                                fontSize: 20,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList()

          // [
          //
          //
          //
          //
          //   Expanded(
          //     child: GestureDetector(
          //       // onTap:,
          //       child: SizedBox(
          //         width: size.width * .2,
          //         height: calculateHeight(80, context),
          //         child: Align(
          //           alignment: isDirectionRTL(context)
          //               ? FractionalOffset.centerRight
          //               : FractionalOffset.centerLeft,
          //           child: Text(
          //             "allInbox".tr,
          //             style: Theme.of(context).textTheme.headline1!.copyWith(
          //                   color: createMaterialColor(
          //                     Color.fromRGBO(100, 100, 100, 1),
          //                   ),
          //                   fontSize: 20,
          //                 ),
          //             textAlign: TextAlign.start,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   // Expanded(
          //   //   child: SizedBox(
          //   //     //  width: size.width*.2,
          //   //     height: calculateHeight(80, context),
          //   //     child: Align(
          //   //       alignment: isDirectionRTL(context)
          //   //           ? FractionalOffset.centerRight
          //   //           : FractionalOffset.centerLeft,
          //   //       child: Text(
          //   //         "forAction".tr,
          //   //         style: Theme.of(context).textTheme.headline1!.copyWith(
          //   //             color: createMaterialColor(
          //   //               const Color.fromRGBO(100, 100, 100, 1),
          //   //             ),
          //   //             fontSize: 20),
          //   //         textAlign: TextAlign.start,
          //   //       ),
          //   //     ),
          //   //   ),
          //   // ),
          //   // Expanded(
          //   //   child: SizedBox(
          //   //     height: calculateHeight(80, context),
          //   //     child: Align(
          //   //       alignment: isDirectionRTL(context)
          //   //           ? FractionalOffset.centerRight
          //   //           : FractionalOffset.centerLeft,
          //   //       child: Text(
          //   //         "forSignature".tr,
          //   //         style: Theme.of(context).textTheme.headline1!.copyWith(
          //   //               color: createMaterialColor(
          //   //                 const Color.fromRGBO(100, 100, 100, 1),
          //   //               ),
          //   //               fontSize: 20,
          //   //             ),
          //   //         textAlign: TextAlign.start,
          //   //       ),
          //   //     ),
          //   //   ),
          //   // ),
          //   // Expanded(
          //   //   child: SizedBox(
          //   //     //  width: size.width*.2,
          //   //     height: calculateHeight(80, context),
          //   //     child: Align(
          //   //       alignment: isDirectionRTL(context)
          //   //           ? FractionalOffset.centerRight
          //   //           : FractionalOffset.centerLeft,
          //   //       child: Text(
          //   //         "forInfo".tr,
          //   //         style: Theme.of(context).textTheme.headline1!.copyWith(
          //   //               color: createMaterialColor(
          //   //                 Color.fromRGBO(100, 100, 100, 1),
          //   //               ),
          //   //               fontSize: 20,
          //   //             ),
          //   //         textAlign: TextAlign.start,
          //   //       ),
          //   //     ),
          //   //   ),
          //   // )
          // ],
          ),
    );
  }

  _buildSideMenuFolders(BuildContext context, String title, String iconTitle,
      bool showCount,   count, VoidCallback function) {
    return InkWell(onTap:function ,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
        width: double.infinity,
        height: calculateHeight(55, context),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.transparent,
              width: 25,
              height: 25,
              child: Image(
                image: AssetImage(
                  iconTitle,
                ),
                fit: BoxFit.contain,
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
      ),
    );
  }
















  _popUpMenu(context,pos) async {
    await controller.listFavoriteRecipients(context: context);
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
                        .headlineMedium!
                        .copyWith(
                        color: Colors.black.withOpacity(.5),
                        fontSize: 18, fontWeight: FontWeight.bold
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
                      width: 30,
                      height: 30,
                    ),
                  ),
                ]),
            content: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("referTo".tr, style: Theme
                        .of(context)
                        .textTheme
                        .headline3!
                        .copyWith(
                        color: Colors.black.withOpacity(.5),
                        fontSize: 18, fontWeight: FontWeight.bold
                    )),

                    Container(height: 100, width: MediaQuery
                        .of(context)
                        .size
                        .width * .8,
                      child: GetBuilder<InboxController>(//autoRemove: false,


                          builder: (logic) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (controller.favoriteRecipientsResponse
                                    ?.recipients?.length ?? 0) + 1,
                                itemBuilder: (context, pos) {
                                  if (pos == (controller.favoriteRecipientsResponse
                                      ?.recipients?.length ?? 0)) {
                                    return


                                      InkWell(onTap: (){
                                        _popUpMenuMore(context);
                                      },
                                        child: Container(padding: EdgeInsets.all(8),
                                          child: Icon(Icons.add,size: 30,color: Colors.white),
                                          decoration: BoxDecoration(shape: BoxShape
                                              .circle, color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,),
                                          height: 75,
                                          width: 75,),
                                      );







                                  } else {
                                    return


                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(onTap: () {
                                          Destination user = Destination(
                                              value: controller
                                                  .favoriteRecipientsResponse!
                                                  .recipients![pos].targetName, id
                                              :controller
                                              .favoriteRecipientsResponse!
                                              .recipients![pos].targetGctid);
                                          controller.addTousersWillSendTo(user:user);
                                        },
                                          child: Card(elevation: 8,
                                            child: Row(
                                              children: [
                                                controller
                                                    .favoriteRecipientsResponse!
                                                    .recipients![pos]
                                                    .targetPhotoBs64!.trim()
                                                    .isEmpty ? Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color: Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .primary,
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            "assets/images/pr.jpg",),
                                                          fit: BoxFit.cover)),
                                                  height: 75,
                                                  width: 75,) :
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle,
                                                      color: Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .primary,
                                                      image: DecorationImage(
                                                          image: MemoryImage(
                                                              dataFromBase64String(
                                                                  controller
                                                                      .favoriteRecipientsResponse!
                                                                      .recipients![pos]
                                                                      .targetPhotoBs64!)),
                                                          fit: BoxFit.cover)),
                                                  height: 75,
                                                  width: 75,),
                                                Text(controller
                                                    .favoriteRecipientsResponse!
                                                    .recipients![pos].targetName!)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                  }

                                  //  CircleAvatar(backgroundColor: Colors.red,backgroundImage: AssetImage("assets/images/pr.jpg",),,radius: 30,);

                                });
                          }),
                    )


                    , const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .8,
                        height: 300, // MediaQuery.of(context).size.height * .5,
                        child: GetBuilder<InboxController>(//autoRemove: false,
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
                                                children: [     Text(
                                                  "name".tr,
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
                                                              controller
                                                                  .record.isRecording
                                                                  ? controller
                                                                  .stopMathod2(
                                                              )
                                                                  : controller
                                                                  .recordMathod2( id:logic
                                                                  .usersWillSendTo[
                                                              pos]
                                                                  .id, );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: GetBuilder<
                                                                  InboxController>(//id: "record",//autoRemove: false,
                                                                  builder:
                                                                      (logic) {

                                                                    return Icon(
                                                                        controller
                                                                            .record.isRecording
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
                                                                    .playMathod2(id:logic
                                                                    .usersWillSendTo[
                                                                pos]
                                                                    .id  );
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


                                                  controller. multiTransferNode[logic
                                                      .usersWillSendTo[pos]
                                                      .id]?.note=v;
                                                  controller.setNots2(
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
                  //     docDueDate:controller.
                  // correspondences[pos].docDueDate ,
                      context: context,
                      transferId: controller.
                      allCorrespondences[pos].transferId!,
                      correspondenceId: controller.allCorrespondences[pos]
                          .correspondenceId);
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
                        color:Colors.black.withOpacity(.5),
                        fontSize: 18,fontWeight: FontWeight.bold
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
                                child: GetBuilder<DocumentController>( autoRemove: false,
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
                                                            .allCorrespondences[
                                                        pos]
                                                            .correspondenceId!,
                                                        transferId: controller.
                                                           allCorrespondences[pos]
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



////القديم
// Expanded(child: Container(child: ListView.separated(
// controller:controller. scrollController,
// itemBuilder: (context, pos) {
// if (pos < controller.allCorrespondences.length) {
// // print("correspondences[pos].privacyId    ${correspondences[pos].privacyId}");
//
// return
// // correspondences[pos].isNew??false?
//
// InkWell(
// onTap: () {
// Get.find<InboxController>().canOpenDoc(
// context: context,
// docId: controller.allCorrespondences[pos].purposeId,
// correspondenceId:
// controller.allCorrespondences[pos].correspondenceId,
// transferId:
// controller.allCorrespondences[pos].transferId);
//
// Get
//     .find<DocumentController>()
//     .pdfViewerkey =
// null;
// // Get.find<InboxController>().openfilee(docId: correspondences[pos].purposeId, correspondenceId: correspondences[pos]
// //     .correspondenceId, transferId:  correspondences[pos].transferId);
//
// Get
//     .find<DocumentController>()
//     .correspondences = controller.allCorrespondences[pos];
//
// //  Get.find<DocumentController>().loadPdf();
// Get.find<DocumentController>()
//     .gatAllDataAboutDOC(
// context: context,
// docId:
// controller.allCorrespondences[pos].purposeId!,
// correspondenceId: controller.allCorrespondences[pos]
//     .correspondenceId!,
// transferId:
// controller.allCorrespondences[pos].transferId!);
// Get.find<DocumentController>()
//     .g2gInfoForExport(
// context: context,
// documentId: controller.allCorrespondences[pos]
//     .correspondenceId!);
// //  Get.find<DocumentController>().loadPdf();
// //Get.toNamed("/DocumentPage");
// },
// child: SizedBox(
// //height: MediaQuery.of(context).size.height*.3,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.start,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Expanded(
// child: Column(
// children: [
//
//
//
//
//
//
//
//
//
// Row(                  crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// mainAxisAlignment:
// MainAxisAlignment
//     .start,children: [ Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(height: 20,width: 20,
// decoration: BoxDecoration(
// color: Theme
//     .of(
// context)
//     .colorScheme
//     .primary,shape: BoxShape.circle)),
// ),
//
//
//
// Flexible(
// child: Text(
// controller.allCorrespondences[
// pos]
//     .gridInfo?[
// 0]
//     .value ??
// "",
// softWrap:
// true,
// maxLines: 3,
// style: TextStyle(color: Colors.black.withOpacity(.7),fontSize: 20,fontWeight: FontWeight.bold)   ),
// ),],)    ,
// SizedBox(height: 8,),
// Row(                  crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// mainAxisAlignment:
// MainAxisAlignment
//     .start,children: [   Container(height: 20,width: 20,
// decoration: BoxDecoration(
// shape: BoxShape.circle)),
//
//
// SizedBox(width: 8,),
//
//
// Text("sender".tr,style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.bold)),
// SizedBox(
// width: 4,
// ),
// Text(
// controller.allCorrespondences[pos]
//     .fromUser ??
// "",style: TextStyle(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.bold)),
// Spacer()
// // Flexible(
// //   child: Text(
// //     correspondences[
// //     pos]
// //         .gridInfo?[
// //     3]
// //         .label ??
// //         "",
// //     softWrap:
// //     true,
// //     maxLines: 3,
// //   ),
// // ),
// ,  Text(
// controller.allCorrespondences[
// pos]
//     .gridInfo?[
// 3]
//     .value ??
// "",
// softWrap:
// true,
// maxLines: 3,
// style: TextStyle(color: Colors.black.withOpacity(.4),fontWeight: FontWeight.bold)  ),],)    ,
// Padding(
// padding:
// const EdgeInsets.all(8.0),
// child: Row(
// // mainAxisAlignment:
// //     MainAxisAlignment
// //         .spaceAround,
// children: [
//
// SizedBox(width: 50,),
//
// // Container(
// //   height: 20,
// //   width: 20,
// //   decoration: BoxDecoration(
// //       color: correspondences[
// //                       pos]
// //                   .priorityId ==
// //               "1"
// //           ? Colors.green
// //           : Colors.red,
// //       shape: BoxShape
// //           .circle),
// // ),
// if (controller.allCorrespondences[pos]
//     .priorityId ==
// "1")
// Icon(
// Icons
//     .warning,
// color: RedColor),
// SizedBox(
// width: 4,
// ),
// if (controller.allCorrespondences[pos]
//     .priorityId ==
// "1")
// Text(
// "veryimportant".tr,
// style: TextStyle(
// color:
// RedColor),
// ),
// SizedBox(width: 50,) ,
// if (controller.allCorrespondences[pos]
//     .showLock ??
// false)
// Icon(Icons.lock),
// if (controller.allCorrespondences[pos]
//     .showLock ??
// false)
// Text("secret".tr),
//
// SizedBox(width: 50,)
// ,
// Icon(
// controller.allCorrespondences[pos]
//     .isLocked!
// ? Icons.lock
//     : Icons
//     .lock_open,
// color: Theme
//     .of(context)
//     .colorScheme
//     .primary),
// if (controller.allCorrespondences[pos]
//     .isLocked ??
// false)
// Text("closed".tr,
// style: TextStyle(
// color: Theme
//     .of(
// context)
//     .colorScheme
//     .primary)),
// //   correspondences[pos].priorityId
// //  correspondences[pos].purposeId
//
//
// SizedBox(width: 50,)
// // Text("sender".tr),
// // SizedBox(
// //   width: 4,
// // ),
// // Text(
// //     correspondences[pos]
// //         .fromUser ??
// //         ""),
//
// ,if (controller.allCorrespondences[pos]
//     .hasAttachments ??
// false)
// Icon(
// Icons.attachment),
// ],
// ),
// )
// ],
// ),
// ),
// Get
//     .find<InboxController>()
//     .edit
// ? InkWell(
// onTap: () {
//
//
// if (controller.allCorrespondences[pos]
//     .isSelect) {
// controller.allCorrespondences[pos]
//     .isSelect = false;
// } else {
// controller.allCorrespondences[pos]
//     .isSelect = true;
// }
// if (controller.allCorrespondences[pos]
//     .isSelect) {
// Get
//     .find<
// InboxController>()
//     .listSelectCorrespondences
//     .add(int.parse(
// controller.allCorrespondences[
// pos]
//     .correspondenceId!));
// } else {
// Get
//     .find<
// InboxController>()
//     .listSelectCorrespondences
//     .remove(
// controller.allCorrespondences[
// pos]);
// }
//
// Get.find<InboxController>()
//     .update();
// },
// child: Padding(
// padding:
// EdgeInsets.all(8),
// child: Container(
// width: 30,
// height: 30,
// child: Image.asset(
// controller.allCorrespondences[
// pos]
//     .isSelect
// ? "assets/images/check.png"
//     : "assets/images/uncheck.png"))
//
// ),
// )
//     : PopupMenuButton(
// itemBuilder: (context) =>
// [
// PopupMenuItem(
// child: Row(
// children: [
// Icon(
// Icons
//     .forward_rounded,
// color: Colors
//     .orange),
// SizedBox(
// width: 4,
// ),
// Text("Reply".tr),
// ],
// ),
// value: 1,
// onTap: (){},
// ),
// PopupMenuItem(
// child: Row(
// children: [
// Icon(
// Icons
//     .account_circle,
// color: Colors
//     .red),
// SizedBox(
// width: 4,
// ),
// Text("Transfer"
//     .tr),
// ],
// ),
// value: 2,
// onTap:
// (){},
// ),
// PopupMenuItem(
// child: Row(
// children: [
// Icon(
// Icons
//     .bookmark,
// color: Colors
//     .orange),
// SizedBox(
// width: 4,
// ),
// Text("Complete"
//     .tr),
// ],
// ),
// onTap:
// (){},
// value: 3,
// ),
// if (controller.allCorrespondences[pos]
//     .hasSummaries ??
// false)
// PopupMenuItem(
// child: Row(
// children: [
// Icon(Icons.menu,
// color: Colors
//     .blueAccent),
// SizedBox(
// width: 4,
// ),
// Text("Summary"
//     .tr),
// ],
// ),
// onTap:
// (){},
// value: 4,
// ),
// PopupMenuItem(
// child: Row(
// children: [
// Icon(
// Icons
//     .backpack_sharp,
// color: Colors
//     .blueAccent),
// SizedBox(
// width: 4,
// ),
// Text("addtoBasket"
//     .tr),
// ],
// ),
// onTap: () {
// Get.find<
// InboxController>()
//     .getFetchBasketList(
// context:
// context);
// },
// value: 5,
// ),
// ],
// enableFeedback: true,
// onSelected: (v) async {
// // print("*" * 50);
// // print(correspondences[pos]
// //     .hasSummaries);
// // print(correspondences[pos]
// //     .correspondenceId);
// //
// // print(correspondences[pos]
// //     .transferId);
// //
// // print("*" * 50);
//
// if (v == 1) {
// showDialog(
// context: context,
// builder: (ctx) =>
// AlertDialog(
// title: Text(" "),
// content: Padding(
// padding:
// const EdgeInsets
//     .all(8.0),
// child: Container(
// width: MediaQuery
//     .of(
// context)
//     .size
//     .width *
// .8,
// color: Colors
//     .grey[200],
// child:
// SingleChildScrollView(
// child: Column(
// children: [
// Row(
// crossAxisAlignment:
// CrossAxisAlignment
//     .center,
// children: [
// Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: Text(
// controller.allCorrespondences[pos]
//     .fromUser ??
// ""),
// ),
// SizedBox(
// width: 8,
// ),
// Text(
// "name"
//     .tr,
// style: Theme
//     .of(
// context)
//     .textTheme
//     .headline3!
//     .copyWith(
// color: createMaterialColor(
// const Color
//     .fromRGBO(
// 77,
// 77,
// 77,
// 1),
// ),
// fontSize: 15,
// ),
// textAlign: TextAlign
//     .center,
// overflow: TextOverflow
//     .ellipsis,
// ),
// ]),
// SizedBox(
// height:
// 4,
// ),
// Row(
// children: [
// Expanded(
// child:
// Text(
// "audioNotes"
//     .tr),
// )
// ],
// ),
// Row(
// children: [
// Expanded(
// child: Container(
// height: 40,
// color: Colors
//     .grey[300],
// child: Row(
// mainAxisAlignment: MainAxisAlignment
//     .spaceBetween,
// children: [
// GestureDetector(
// onTap: () async {
// Get
//     .find<
// InboxController>()
//     .recording
// ? Get
//     .find<
// InboxController>()
//     .stop2()
//     : Get
//     .find<
// InboxController>()
//     .record2();
// Get
//     .find<
// InboxController>()
//     .update(
// [
// "id"
// ]);
// },
// child: Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: GetBuilder<
// InboxController>(autoRemove: false,
// id: "id",
// builder: (
// logic) {
// print(
// "5555");
// return Icon(
// Get
//     .find<
// InboxController>()
//     .recording
// ? Icons
//     .stop
//     : Icons
//     .mic);
// }),
// ),
// ),
// Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: InkWell(
// onTap: () {
// // controller
// //     .playRec();
// },
// child: Icon(
// Icons
//     .play_arrow),
// ),
// )
// ],
// )),
// )
// ],
// ),
// SizedBox(
// height:
// 8,
// ),
// Container(
// child:
// TextFormField(
// onChanged:
// (
// v) {
// Get
//     .find<
// InboxController>()
//     .replyNote =
// v;
// },
// maxLines:
// 4,
// ),
// color: Colors
//     .grey[300],
// ),
// SizedBox(
// height:
// 8,
// ),
// ]),
// ),
// ),
// ),
// actions: <Widget>[
// FlatButton(
// onPressed:
// () async {
// String?
// audioFileBes64 =
// await audiobase64String(
// file: Get
//     .find<
// InboxController>()
//     .recordFile);
//
// ReplyWithVoiceNoteApi
// replayAPI =
// ReplyWithVoiceNoteApi(
// context);
//
// ReplyWithVoiceNoteRequestModel v = ReplyWithVoiceNoteRequestModel(
// userId: controller.allCorrespondences[
// pos]
//     .fromUserId
//     .toString(),
// transferId:
// controller.allCorrespondences[pos]
//     .transferId,
// token: Get
//     .find<
// InboxController>()
//     .secureStorage
//     .token(),
// correspondencesId:
// controller.allCorrespondences[pos]
//     .correspondenceId,
// language: Get
//     .locale
//     ?.languageCode ==
// "en"
// ? "en"
//     : "ar",
// voiceNote:
// audioFileBes64,
// notes: Get
//     .find<
// InboxController>()
//     .replyNote,
// voiceNoteExt:
// "m4a",
// voiceNotePrivate:
// false);
//
// replayAPI
//     .post(v
//     .toMap())
//     .then(
// (
// value) {
// print(
// "1" *
// 50);
// ReplyWithVoiceNoteModel
// v = value
// as ReplyWithVoiceNoteModel;
// print(v
//     .errorMessage);
// print(
// v
//     .status);
// print(
// "1" *
// 50);
// });
//
// /// ToDo send Replay
//
// Navigator.of(
// ctx)
//     .pop();
// },
// child: Text(
// "Ok"),
// ),
// ],
// ),
// );
// }
// else if (v == 2) {
// showDialog(
// context: context,
// builder: (BuildContext
// context) {
// return AlertDialog(
// title: Row(
// //mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Image.asset(
// 'assets/images/refer.png'
// //
// ,
// height:
// 20,
// width: 20,
// ),
// const SizedBox(
// width: 8,
// ),
// Text(
// "refer"
//     .tr,
// style: Theme
//     .of(
// context)
//     .textTheme
//     .headline3!
//     .copyWith(
// color:
// createMaterialColor(
// const Color
//     .fromRGBO(
// 77,
// 77,
// 77,
// 1),
// ),
// fontSize:
// 15,
// ),
// textAlign:
// TextAlign
//     .center,
// overflow:
// TextOverflow
//     .ellipsis,
// ),
// const Spacer(),
// InkWell(
// onTap:
// () {
// Get
//     .find<
// InboxController>()
//     .filterWord =
// "";
// Navigator
//     .pop(
// context);
// },
// child: Image
//     .asset(
// 'assets/images/close_button.png',
// width:
// 20,
// height:
// 20,
// ),
// ),
// ]),
// content:
// SingleChildScrollView(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: [
// const SizedBox(
// height:
// 10,
// ),
// Row(
// children: [
// Expanded(
// child: Container(
// decoration: BoxDecoration(
// border: Border
//     .all(
// color: Theme
//     .of(
// context)
//     .colorScheme
//     .primary),
// borderRadius: const BorderRadius
//     .all(
// Radius
//     .circular(
// 6))),
// child: TextField(
// decoration: const InputDecoration(
// border: UnderlineInputBorder(),
// labelText: 'To',
// ),
// onChanged: Get
//     .find<
// InboxController>()
//     .filterUser,
// ))),
// const SizedBox(
// width:
// 2,
// ),
// CustomButtonWithIcon(
// icon: Icons
//     .person,
// onClick: () {
// Get
//     .find<
// InboxController>()
//     .listOfUser(
// 0);
// }),
// const SizedBox(
// width:
// 2,
// ),
// CustomButtonWithIcon(
// icon: Icons
//     .account_balance,
// onClick: () {
// Get
//     .find<
// InboxController>()
//     .listOfUser(
// 1);
// }),
// const SizedBox(
// width:
// 2,
// ),
// CustomButtonWithIcon(
// icon: Icons
//     .person,
// onClick: () {
// Get
//     .find<
// InboxController>()
//     .listOfUser(
// 2);
// }),
// ],
// ),
// const SizedBox(
// height:
// 10,
// ),
// Text(
// "referTo"
//     .tr),
// SizedBox(
// width: MediaQuery
//     .of(
// context)
//     .size
//     .width *
// .8,
// height:
// 100,
// child:
// Row(
// children: [
// Expanded(
// child: GetBuilder<
// InboxController>(autoRemove: false,
// assignId: true,
// //tag: "alluser",
// builder: (
// logic) {
// return ListView
//     .builder(
// scrollDirection: Axis
//     .horizontal,
// itemCount: Get
//     .find<
// InboxController>()
//     .users
//     .length,
// itemBuilder: (
// context,
// pos) {
// print(
// "*" *
// 100);
// print(
// logic
//     .users[pos]
//     .value
//     ?.split(
// " ")
//     .length);
// List<
// String>? a = logic
//     .users[pos]
//     .value
//     ?.split(
// " ");
//
// // bool a=logic.user?[pos].value?.contains(logic.filterWord)??false;
// if (logic
//     .users[pos]
//     .value
//     ?.contains(
// logic
//     .filterWord) ??
// false) {
// return Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: InkWell(
// onTap: () {
// Get
//     .find<
// InboxController>()
//     .addTousersWillSendTo(
// user: logic
//     .users[pos]);
// Get
//     .find<
// InboxController>()
//     .SetMultipleReplyWithVoiceNoteRequestModel(
// correspondencesId: controller.allCorrespondences[pos]
//     .correspondenceId!,
// transferId: controller.allCorrespondences[pos]
//     .transferId!,
// id: logic
//     .users[pos]
//     .id!);
// },
// child: Container(
// decoration: BoxDecoration(
// border: Border
//     .all(
// color: Theme
//     .of(
// context)
//     .colorScheme
//     .primary,
// width: 1),
// ),
// padding: EdgeInsets
//     .all(
// 2.0),
// child: Row(
// children: [
// Container(
// height: 50,
// width: 50,
// decoration: BoxDecoration(
// shape: BoxShape
//     .circle,
// color: Theme
//     .of(
// context)
//     .colorScheme
//     .primary,
// ),
// child: Center(
// child: FittedBox(
// child: Text(
// "${a?[0][0]} ${a?[0][0] ??
// ""}"))),
// ),
// Padding(
// padding: const EdgeInsets
//     .only(
// top: 2.0,
// bottom: 2,
// right: 8,
// left: 8),
// child: Text(
// logic
//     .users[pos]
//     .value ??
// "",
// maxLines: 3,
// softWrap: true,
// )
//
// //
// // Container(
// //   height: 50,
// //   width: 50,
// //   decoration: const BoxDecoration(
// //       shape: BoxShape.circle,
// //       color: Colors.green),
// // ),
// ),
// ],
// ),
// ),
// ),
// );
// } else {
// return SizedBox();
// }
// });
// },
// )),
// // Padding(
// //   padding:
// //       const EdgeInsets.all(
// //           8.0),
// //   child:
// //       Container(
// //     child: const Icon(
// //         Icons.clear),
// //     height:
// //         50,
// //     width:
// //         50,
// //     decoration:
// //         const BoxDecoration(
// //       shape:
// //           BoxShape.circle,
// //       color:
// //           Colors.grey,
// //     ),
// //   ),
// // ),
// ],
// )),
// const Divider(
// color: Colors
//     .grey,
// ),
// SizedBox(
// width: MediaQuery
//     .of(
// context)
//     .size
//     .width *
// .8,
// height:
// 300,
// // MediaQuery.of(context).size.height * .5,
// child:
// GetBuilder<
// InboxController>(autoRemove: false,
// //   assignId: true,//tag: "user",
// builder:
// (
// logic) {
// return //Text(logic.filterWord);
//
// ListView
//     .builder(
// scrollDirection: Axis
//     .vertical,
// itemCount: Get
//     .find<
// InboxController>()
//     .usersWillSendTo
//     .length,
// itemBuilder: (
// context,
// pos) {
// return //Text(controller.filterWord);
//
// Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: Container(
// color: Colors
//     .grey[200],
// child: Column(
// children: [
// Row(crossAxisAlignment: CrossAxisAlignment
//     .center,
// children: [
// Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: Text(
// logic
//     .usersWillSendTo[pos]
//     .value ??
// ""),
// // child: Container(
// //   height: 50,
// //   width: 50,
// //   // decoration: const BoxDecoration(
// //   //   shape: BoxShape.circle,
// //   //   color: Colors.grey,
// //   // ),
// // ),
// ),
// SizedBox(
// width: 8,
// ),
// Text(
// "الاسم",
// style: Theme
//     .of(
// context)
//     .textTheme
//     .headline3!
//     .copyWith(
// color: createMaterialColor(
// const Color
//     .fromRGBO(
// 77,
// 77,
// 77,
// 1),
// ),
// fontSize: 15,
// ),
// textAlign: TextAlign
//     .center,
// overflow: TextOverflow
//     .ellipsis,
// ),
// Spacer(),
// GestureDetector(
// onTap: () {
// Get
//     .find<
// InboxController>()
//     .delTousersWillSendTo(
// user: logic
//     .usersWillSendTo[pos]);
//
// Get
//     .find<
// InboxController>()
//     .deltransfarForMany(
// id: logic
//     .users[pos]
//     .id!);
// },
// child: Image
//     .asset(
// 'assets/images/close_button.png',
// width: 20,
// height: 20,
// ),
// ),
// ]),
// SizedBox(
// height: 4,
// ),
// Row(
// children: [
// Expanded(
// child: Text(
// "action"
//     .tr),
// ),
// SizedBox(
// width: 10,
// ),
// Expanded(
// child: Text(
// "audioNotes"
//     .tr),
// )
// ],
// ),
// Row(
// children: [
// Expanded(
// child: Container(
// height: 40,
// color: Colors
//     .grey[300],
// child: DropdownButton<
// CustomActions>(
// alignment: Alignment
//     .topRight,
// value: Get
//     .find<
// InboxController>()
//     .getactions(
// logic
//     .usersWillSendTo[pos]
//     .id),
// icon: const Icon(
// Icons
//     .arrow_downward),
// elevation: 16,
// style: const TextStyle(
// color: Colors
//     .deepPurple),
// underline: Container(
// height: 2,
// color: Colors
//     .deepPurpleAccent,
// ),
// hint: Text(
// "اختار"),
// onChanged: (
// CustomActions? newValue) {
// logic
//     .setactions(
// logic
//     .usersWillSendTo[pos]
//     .id,
// newValue!);
// },
// items: Get
//     .find<
// InboxController>()
//     .customActions
//     ?.map<
// DropdownMenuItem<
// CustomActions>>((
// CustomActions value) {
// return DropdownMenuItem<
// CustomActions>(
// value: value,
// child: Text(
// value
//     .name!),
// );
// })
//     .toList(),
// ),
// ),
// ),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: Container(
// height: 40,
// color: Colors
//     .grey[300],
// child: Row(
// mainAxisAlignment: MainAxisAlignment
//     .spaceBetween,
// children: [
// GestureDetector(
// onTap: () async {
// // Get.find<InboxController>().recording ? Get.find<InboxController>().stop2() : Get.find<InboxController>().record2();
//
// Get
//     .find<
// InboxController>()
//     .recording
// ? Get
//     .find<
// InboxController>()
//     .stopMathod2(
// // id: logic
// //     .usersWillSendTo[pos]
// //     .id!
// //
//
// ):
// // : Get
// // .find<
// // InboxController>()
// // .recordForMany();
//
//
// Get
//     .find<
// InboxController>().record2();
// // .recordForMany();
// },
// child: Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: GetBuilder<
// DocumentController>(autoRemove: false,
// builder: (
// logic) {
// return Icon(
// Get
//     .find<
// InboxController>()
//     .recording
// ? Icons
//     .stop
//     : Icons
//     .mic);
// }),
// ),
// ),
// Padding(
// padding: const EdgeInsets
//     .all(
// 8.0),
// child: InkWell(
// onTap: () {
// Get
//     .find<
// InboxController>()
//     .playRec();
// },
// child: Icon(
// Icons
//     .play_arrow),
// ),
// )
// ],
// )),
// )
// ],
// ),
// SizedBox(
// height: 8,
// ),
// Container(
// child: TextFormField(
// onChanged: (
// v) {
// Get
//     .find<
// InboxController>()
//     .setNots(
// id: logic
//     .users[pos]
//     .id!,
// not: v);
// },
// maxLines: 4,
// ),
// color: Colors
//     .grey[300],
// ),
// SizedBox(
// height: 8,
// ),
// ]),
// ),
// );
// });
// },
// ))
//
// // Container(height: 300,child: ListView.builder( itemCount: 100,itemBuilder: (context,pos){
// //   return  Padding(
// //     padding: const EdgeInsets.all(8.0),
// //     child: Container(color: Colors.grey,child: Column(children: [
// //       Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Image.asset(
// //               'assets/images/refer.png'
// //               //
// //               ,
// //               height: 20,
// //               width: 20,
// //             ),
// //             const SizedBox(
// //               width: 8,
// //             ),
// //             Text(
// //               "refer".tr,
// //               style: Theme.of(context).textTheme.headline3!.copyWith(
// //                 color: createMaterialColor(
// //                   const Color.fromRGBO(77, 77, 77, 1),
// //                 ),
// //                 fontSize: 15,
// //               ),
// //               textAlign: TextAlign.center,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //
// //             Image.asset(
// //               'assets/images/close_button.png',
// //               width: 20,
// //               height: 20,
// //             ),
// //             Row(children: [],)
// //           ]),]),),
// //   );
// //
// // }))
// ]),
// ),
// actions: <Widget>[
// TextButton(
// onPressed:
// () {
// print(
// "i click ok");
// print(
// "Get.find<InboxController>().   =>   ${Get
//     .find<
// InboxController>()
//     .transfarForMany
//     .length}");
// Get
//     .find<
// InboxController>()
//     .transfarForMany
//     .forEach((
// key,
// value) {
// print(
// "$key      ${value
//     .toMap()}");
// });
//
// Get.find<
// InboxController>()
//     .multipleTransferspost2(
// context:
// context,
// transferId:
// controller.allCorrespondences[pos]
//     .transferId,
// correspondenceId:
// controller.allCorrespondences[pos]
//     .correspondenceId
// //,
// // docDueDate:
// // controller.allCorrespondences[pos]
// //     .docDueDate
//
//
// );
// //Navigator.of(context).pop();
// },
// child: Text(
// "Ok"),
// ),
// ],
// );
// });
// }
// else if (v == 3) {
// showDialog(
// context: context,
// builder: (ctx) =>
// AlertDialog(
// title: Text(" "),
// content: Padding(
// padding:
// const EdgeInsets
//     .all(8.0),
// child: Container(
// width: MediaQuery
//     .of(
// context)
//     .size
//     .width *
// .8,
// color: Colors
//     .grey[200],
// child:
// SingleChildScrollView(
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment
//     .start,
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: [
// Text(
// "note"),
// SizedBox(
// height:
// 8,
// ),
// Container(
// child:
// TextFormField(onChanged: (v){
// controller.completeNote=v;
// },
// maxLines:
// 4,
// ),
// color: Colors
//     .grey[300],
// ),
// SizedBox(
// height:
// 8,
// ),
// ]),
// ),
// ),
// ),
// actions: <Widget>[
// FlatButton(
// onPressed: () {
// print(Get
//     .find<
// InboxController>()
//     .completeCustomActions
//     ?.name);
// print(Get
//     .find<
// InboxController>()
//     .completeCustomActions
//     ?.icon);
//
// String data =
// 'Token=${Get
//     .find<
// InboxController>()
//     .secureStorage
//     .token()}&correspondenceId=${controller.allCorrespondences[pos]
//     .correspondenceId}&transferId=${controller.allCorrespondences[pos]
//     .transferId}&actionType="Complete"}&note=${Get
//     .find<
// InboxController>()
//     .completeNote}&language=${Get
//     .locale
//     ?.languageCode ==
// "en"
// ? "en"
//     : "ar"}';
//
// Get.find<
// InboxController>()
//     .completeInCorrespondence(
// context:
// context,
// data:
// data);
//
// Navigator.of(
// ctx)
//     .pop();
// },
// child: Text(
// "Ok"),
// ),
// ],
// ),
// );
//
// print(Get
//     .find<
// InboxController>()
//     .customAction
//     ?.name);
//
// print(
// "  Correspondences[pos].purposeId =>   ${controller.allCorrespondences[pos]
//     .purposeId}");
// print(
// " Correspondences[pos].correspondenceId =>   ${controller.allCorrespondences[pos]
//     .correspondenceId}");
// print(
// "   Correspondences[pos].transferId =>   ${controller.allCorrespondences[pos]
//     .transferId}");
//
// print("ppp" * 10);
// print(Get
//     .find<
// InboxController>()
//     .customAction
//     ?.name);
// }
// else if (v == 4) {
// //correspondences[pos].
//
// } else if (v == 5) {
// await Get.find<
// InboxController>()
//     .getFetchBasketList(
// context: context);
// //    print("Get.find<InboxController>().getFetchBasketList()");
//
// showDialog(
// context: context,
// builder: (ctx) =>
// AlertDialog(
// title: Text(" "),
// content: Padding(
// padding:
// const EdgeInsets
//     .all(8.0),
// child: Container(
// width: MediaQuery
//     .of(
// context)
//     .size
//     .width *
// .3,
// color: Colors
//     .grey[200],
// child: ListView
//     .builder(
// itemCount: Get
//     .find<
// InboxController>()
//     .fetchBasketListModel
//     ?.baskets
//     ?.length,
// itemBuilder:
// (
// context,
// pos) {
// return InkWell(
// onTap:
// () async {
// Get
//     .find<
// InboxController>()
//     .listSelectCorrespondences
//     .add(
// int
//     .parse(
// controller.allCorrespondences[pos]
//     .correspondenceId!));
//
// await Get
//     .find<
// InboxController>()
//     .addDocumentsToBasket(
// context: context,
// basketId: Get
//     .find<
// InboxController>()
//     .fetchBasketListModel
//     ?.baskets?[pos]
//     .iD);
// Get
//     .back();
// },
// child:
// Card(
// elevation: 10,
// child: Column(
// children: [
// Text(
// Get
//     .find<
// InboxController>()
//     .fetchBasketListModel
//     ?.baskets?[pos]
//     .name ??
// ""),
// Text(
// Get
//     .find<
// InboxController>()
//     .fetchBasketListModel
//     ?.baskets?[pos]
//     .nameAr ??
// ""),
// Text(
// "color :${Get
//     .find<
// InboxController>()
//     .fetchBasketListModel
//     ?.baskets?[pos]
//     .color}")
// ]),
// ),
// );
// })),
// ),
// actions: <Widget>[
// FlatButton(
// onPressed:
// () async {
// /// ToDo send Replay
// print(
// "77777777777777777777777777777777777777777777777777");
// Navigator.of(
// ctx)
//     .pop();
// },
// child: Text(
// "Ok"),
// ),
// ],
// ),
// );
// }
// }),
//
// ],
// )),
// ),
// );
//
// ///:SizedBox();
// } else {
// return controller.haveMoreData
// ? const SizedBox(
// height: 50,
// width: 50,
// child: Center(
// child: CircularProgressIndicator()),
// )
//     : const SizedBox();
// }
// },
// separatorBuilder: (context, index) => const Divider(),
// itemCount: controller.allCorrespondences.length + 1),))