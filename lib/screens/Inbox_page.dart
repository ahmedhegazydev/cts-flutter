import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:cts/controllers/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../controllers/my_cart/create_basket_controller.dart';
import '../models/user_filter.dart';
import '../services/json_model/basket/fetch_basket_list_model.dart';
import '../utility/all_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_listview.dart';
import '../utility/utilitie.dart' as u;
import 'package:cts/utility/Extenstions.dart';

import '../widgets/hourizontal_list_view_colors.dart';

class InboxPage extends GetWidget<InboxController> {
  SecureStorage secureStorage = Get.put(SecureStorage());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<InboxController>(
          autoRemove: false,
          builder: (logic) {
            return Scaffold(
              appBar: _buildAppBar(context),
              body: _buildBody(context),
              drawer: _buildDrawer(context),
            );
          }),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: _buildSideMenu(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Text(
        "appTitle".tr,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.start,
      ),
      actions: <Widget>[
        SizedBox(
          width: 100,
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'back',
          onPressed: () {
            Get.offAllNamed("/Landing");
            Get.back();
          },
        ),
      ],
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
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        controller.isAllOrNot
                            ? Expanded(
                                child: CustomListView(
                                  function: controller.onRefresh(),
                                  correspondences:
                                      controller.allCorrespondences,
                                  scrollController: controller.scrollController,
                                  haveMoreData: controller.haveMoreData,
                                  onClickItem: () {},
                                  functionSummary: () {},
                                  customActions: controller.customActions,
                                  functionReply: () {},
                                  functionTrunsfer: () {},
                                  functionComplet: () {},
                                ),
                              )
                            : Expanded(
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
    if (size.width < 500) {
      return Container(
        width: 10,
        height: 10,
      );
    }
    return Row(
      children: [
        GetBuilder<InboxController>(
            autoRemove: false,
            builder: (logic) {
              return Checkbox(
                  value: controller.unread, onChanged: controller.updateUnread);
            }),
        Text(
          "unread".tr,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        Seperator(),
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
                        color: Theme.of(context).colorScheme.primary)),
                child: DropdownButton<UserFilter>(
                  value: controller.selectUserFilter,
                  icon: const Icon(Icons.arrow_downward),
                  hint: Row(
                    children: [
                      Container(
                          //width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/pr.jpg")))),
                      Text(
                        "sender".tr,
                      ),
                    ],
                  ),
                  iconSize: 24,
                  elevation: 16,
                  underline: SizedBox(),
                  onChanged: controller.updateselectUserFilter,
                  items: controller.userFilter
                      .map<DropdownMenuItem<UserFilter>>((UserFilter value) {
                    return DropdownMenuItem<UserFilter>(
                      value: value,
                      child: Row(
                        children: [
                          Visibility(
                            visible: value.isStructure,
                            child: Container(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.account_balance)),
                          ),
                          Text(value.name),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
        Seperator(),
        // Container(
        //   padding: EdgeInsets.only(right: 8, left: 8),
        //   height: size.height * .03,
        //   width: 1,
        //   color: Colors.grey,
        // ),
        // SizedBox(
        //   width: 16,
        // ),
        GestureDetector(
          onTap: () {
            controller.setIsUrgentFilterClicked(!controller.isUrgentClicked);
          },
          child: Container(
            width: 160,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: controller.isUrgentClicked ? AppColor : Colors.grey[400],
                borderRadius: BorderRadius.circular(8)),
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
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
        GestureDetector(
          child: Container(
            child: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),
          onTap: () {
            controller.clearFilter();
          },
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
                  children: [],
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
                            Get.find<LandingPageController>()
                                    .data
                                    ?.departmentName ??
                                "",
                            //  "sharedServicesAdministration".tr,
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

  Future<void> refreshInbox(BuildContext context, int inboxId) async {
    controller.getCorrespondencesDataAsync(
        inboxId: inboxId,
        pageSize: 20,
        showThumbnails: false,
        context: context);
    print('refreshing...');
  }

  _buildTopInboxMenu(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 1,
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
          ],
          tabBarProperties: TabBarProperties(
            // width: MediaQuery.of(context).size.width * .3,
            height: 70.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 5.0,
            labelColor: Colors.black.withOpacity(.7),
            unselectedLabelColor: Colors.black.withOpacity(.5),
            alignment: TabBarAlignment.start,
          ),
          views: [
            Center(
                child: controller.getData
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => refreshInbox(context, 0),
                        child: ListView(
                          children: [
                            Visibility(
                                visible:
                                    true, //controller.allCorrespondences.isNotEmpty,
                                child: _filterMail(context)),
                            controller.allCorrespondences.isNotEmpty
                                ? CustomListView(
                                    // function: controller.onRefresh(),
                                    correspondences:
                                        controller.allCorrespondences,
                                    scrollController:
                                        controller.scrollController,
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
                                  )
                                : Center(
                                    child: Text('noData'.tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade500))),
                          ],
                        ),
                      )),
            Center(
                child: controller.getData
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => refreshInbox(context, 1),
                        child: ListView(
                          children: [
                            Visibility(
                                visible:
                                    true, // controller.allCorrespondences.isNotEmpty,
                                child: _filterMail(context)),
                            controller.allCorrespondences.isNotEmpty
                                ? CustomListView(
                                    // function: controller.onRefresh(),
                                    correspondences:
                                        controller.allCorrespondences,
                                    scrollController:
                                        controller.scrollController,
                                    haveMoreData: controller.haveMoreData,
                                    onClickItem: () {
                                      Get.find<DocumentController>()
                                          .documentEditedInOfficeId
                                          .value = 0;
                                      //   ViewerController.to.allAnnotations.clear();
                                      Get.toNamed("/DocumentPage");
                                    },
                                    functionSummary: () {},
                                    //allCorrespondences: controller.allCorrespondences,
                                    customActions: controller.customActions,
                                    functionReply: () {},
                                    functionTrunsfer: () {},
                                    functionComplet: () {},
                                  )
                                : Center(
                                    child: Text('noData'.tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade500))),
                          ],
                        ),
                      )),
            Center(
                child: controller.getData
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => refreshInbox(context, 5),
                        child: ListView(
                          children: [
                            Visibility(
                                visible:
                                    controller.allCorrespondences.isNotEmpty,
                                child: _filterMail(context)),
                            controller.allCorrespondences.isNotEmpty
                                ? CustomListView(
                                    // function: controller.onRefresh(),
                                    correspondences:
                                        controller.allCorrespondences,
                                    scrollController:
                                        controller.scrollController,
                                    haveMoreData: controller.haveMoreData,
                                    onClickItem: () {
                                      //        ViewerController.to.allAnnotations.clear();
                                      Get.find<DocumentController>()
                                          .documentEditedInOfficeId
                                          .value = 0;
                                      Get.toNamed("/DocumentPage");
                                    },
                                    functionSummary: () {},
                                    //allCorrespondences: [],
                                    customActions: [],
                                    functionReply: () {},
                                    functionTrunsfer: () {},
                                    functionComplet: () {},
                                  )
                                : Center(
                                    child: Text(
                                    'noData'.tr,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade500),
                                  )),
                          ],
                        ),
                      )),
          ],
          onChange: (value) {
            controller.clearFilter();
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
            }
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
                "", () {
              controller.clearFilter();
              controller.nodeId = 0;
              Get.find<InboxController>().isAllOrNot = true;
              Get.find<InboxController>()
                  .getAllCorrespondencesData(context: context, inboxId: 1);
              controller.update();
            }),
            _buildSideMenuFolders(
              context,
              // "notifications".tr,
              "allout".tr,
              "assets/images/outgoing_icon.png",
              false,
              "",
              () {
                controller.clearFilter();
                controller.nodeId = 0;
                Get.find<InboxController>().isAllOrNot = true;
                Get.find<InboxController>()
                    .getAllCorrespondencesData(context: context, inboxId: 5);
                controller.update();
              },
            )
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
                  child: GestureDetector(
                    onTap: () {
                      controller.clearFilter();
                      controller.nodeId = Get.find<LandingPageController>()
                          .dashboardStatsResultModel!
                          .inboxCategories![pos]
                          .value!
                          .nodeId;
                      controller.isAllOrNot = false;
                      controller.getCorrespondencesData(
                          context: context, inboxId: controller.inboxId);
                      controller.update();
                      Navigator.of(context).pop();
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
            }));
  }

  _buildSideMenuFolders(BuildContext context, String title, String iconTitle,
      bool showCount, count, VoidCallback function) {
    return InkWell(
      onTap: function,
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

  Future<void> showAllBasketsDialog(BuildContext context) async {
    u.showLoaderDialog(context);
    await controller.getFetchBasketList(context: context);
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
                            in controller.fetchBasketListModel!.baskets!)
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
                              onTap: () {
                                Get.find<InboxController>().clearFilter();
                                Get.find<InboxController>().isAllOrNot = true;
                                Get.find<InboxController>().getBasketInbox(
                                  context: context,
                                  id: basket.iD!,
                                );
                                Get.find<InboxController>().selectUserFilter =
                                    null;
                                Get.find<InboxController>().userFilter.clear();
                                Get.toNamed("/InboxPage");
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
                        final Baskets item = controller
                            .fetchBasketListModel!.baskets!
                            .removeAt(oldIndex);
                        controller.fetchBasketListModel!.baskets!
                            .insert(newIndex, item);
                      },
                      onReorderStart: (int index) {
                        //0-1-2-....
                        print("onReorderStart = $index");
                        controller.setOldIndex(index);
                      },
                      onReorderEnd: (int index) {
                        controller.setSavingOrder(true);
                        print("onReorderEnd = $index");
                        if (controller.fetchBasketListModel!.baskets![index]
                                .canBeReOrder ==
                            false) {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message:
                                  "${controller.fetchBasketListModel!.baskets![index].name} canBeReOrder = false",
                            ),
                          );
                        } else {
                          if (controller.oldIndex != index) {
                            u.showLoaderDialog(context);
                            print(controller.fetchBasketListModel?.toJson());
                            controller.reOrderBaskets(
                                context: context,
                                baskets:
                                    controller.fetchBasketListModel!.baskets);
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
                u.showLoaderDialog(context);
                controller.removeBasket(
                  context: context,
                  basketId: basket.iD,
                  onSuccess: (String message) {
                    // Navigator.pop(context);
                    // Get.back();
                    // showAllBasketsDialog(context);
                    return null;
                  },
                );
                controller.fetchBasketListModel!.baskets?.remove(basket);
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

  Future<String?> showInputDialog(
      BuildContext context, String title, String defaultInput, String message) {
    var textController = TextEditingController(text: defaultInput);
    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Form(
            child: Column(
          children: [
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
                    controller: controller.textEditingControllerEnglishName,
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
                    controller: controller.textEditingControllerArabicName,
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

                    u.showLoaderDialog(context);
                    // controller.createNewBasket();

                    var basket = Baskets(
                        color: Get.find<CreateBasketController>()
                            .pickerColor
                            .toHex(),
                        canBeReOrder: true,
                        orderBy: 0,
                        nameAr: controller.textEditingControllerArabicName.text,
                        name: controller.textEditingControllerEnglishName.text);
                    controller.fetchBasketListModel!.baskets?.add(basket);

                    controller.addEditBasket(context: context, basket: basket);
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
}

class Seperator extends StatelessWidget {
  const Seperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12),
      child: Container(
        padding: EdgeInsets.only(right: 12, left: 12),
        height: 20,
        width: 1,
        color: Colors.grey,
      ),
    );
  }
}
