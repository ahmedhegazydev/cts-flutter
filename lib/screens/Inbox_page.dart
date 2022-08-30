import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inbox_controller.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_listview.dart';

class InboxPage extends GetWidget<InboxController> {
  SecureStorage secureStorage = Get.put(SecureStorage());

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
                Text("unread".tr,style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(.7)))
              ],
            ),
          ),
        ),SizedBox(
    width: 16,
    ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),SizedBox(
    width: 16,
    ),
        Container(
          child: Center(child: Text("sender".tr,style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(.7)),)),
        ),SizedBox(
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
                    child: CircleAvatar(backgroundImage: AssetImage("assets/images/pr.jpg"),
                      backgroundColor: Colors.cyan,
                      maxRadius: 30,
                      minRadius: 30,
                    ),
                  );
                }),
          ),
        ),SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),SizedBox(
          width: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width:160,padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColor, borderRadius: BorderRadius.circular(8)),
              // margin: EdgeInsets.only(right: 8, left: 8),
              //   height: size.height * .03,
              ////width: 1,
              child: IntrinsicHeight(
                child: Row(mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [SizedBox(width: 8,),
                    Icon(
                      Icons.warning,
                      color: Colors.white,
                    ),SizedBox(width: 10,),
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
            SizedBox(
              width: 16,
            ),
            Container(width:160,padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8)),
              //  padding: EdgeInsets.only(right: 8, left: 8),
              child: Row(mainAxisAlignment:
              MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock,color: Colors.black.withOpacity(.6)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "secret".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color:  Colors.black.withOpacity(.6), fontSize: 16),
                  ),
                ],
              ),
              ////width: 1,
            ),
          ],
        ),SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8),
          height: size.height * .03,
          width: 1,
          color: Colors.grey,
        ),SizedBox(
          width: 16,
        ),
        Icon(
          Icons.clear,color: Theme.of(context)
            .colorScheme
            .primary,size: 30,
        ),
        SizedBox(
          width: 16,
        ),  ],
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
            Text(
              "internal".tr,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.grey, fontSize: 21),
            ), ],
          tabBarProperties: TabBarProperties(
            width: MediaQuery.of(context).size.width*.3,
            height: 70.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 5.0,
            labelColor: Colors.black.withOpacity(.7),
            unselectedLabelColor:  Colors.black.withOpacity(.5),
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
                              correspondences: controller.correspondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                //     Get.toNamed("/DocumentPage");
                              },
                              functionSummary: () {},
                              allCorrespondences: controller.allCorrespondences,
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
                              correspondences: controller.correspondences,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                Get.toNamed("/DocumentPage");
                              },
                              functionSummary: () {},
                              allCorrespondences: controller.allCorrespondences,
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

                        Visibility(visible: true,child: _filterMail(context)),







                        Expanded(
                          child: CustomListView(
                              function: controller.onRefresh(),
                              correspondences: controller.correspondences ,
                              scrollController: controller.scrollController,
                              haveMoreData: controller.haveMoreData,
                              onClickItem: () {
                                Get.toNamed("/DocumentPage");
                              }, functionSummary: () {  }, allCorrespondences: [], customActions: [], functionReply: () {  }, functionTrunsfer: () {  }, functionComplet: () {  },
                            ),
                        ),
                      ],
                    )),
            Center(
                child: controller.getData
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: [

                    Visibility(visible: true,child: _filterMail(context)),







                    Expanded(
                      child: CustomListView(
                        function: controller.onRefresh(),
                        correspondences: controller.correspondences ,
                        scrollController: controller.scrollController,
                        haveMoreData: controller.haveMoreData,
                        onClickItem: () {
                          Get.toNamed("/DocumentPage");
                        }, functionSummary: () {  }, allCorrespondences: [], customActions: [], functionReply: () {  }, functionTrunsfer: () {  }, functionComplet: () {  },
                      ),
                    ),
                  ],
                )),
          ],
          onChange: (value) {
            controller.getData = true;
            controller.addToList = false;
            controller.index = 0;
            if (value == 0) {
              //  Globals.inboxIdForCorrespondencesList = 5;

              controller.inboxId = 5;
              controller.getCorrespondencesData(context: context, inboxId: 5);
            } else if (value == 1) {
              controller.inboxId = 1;
              controller.getCorrespondencesData(context: context, inboxId: 1);
              //     Globals.inboxIdForCorrespondencesList = 1;
              controller.inboxId = 1;
            } else if (value == 2) {
              controller.inboxId = 5;
              controller.getCorrespondencesData(context: context, inboxId: 5);
              //  Globals.inboxIdForCorrespondencesList = 5;
            } else if (value == 3) {
              controller.inboxId = 3;
              controller.getCorrespondencesData(context: context, inboxId: 3);
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
}
