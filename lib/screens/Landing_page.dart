import 'package:cts/screens/Inbox_page.dart';
import 'package:cts/screens/search_page.dart';
import 'package:cts/utility/Extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/my_cart/create_basket_controller.dart';
import '../controllers/search_controller.dart';
import '../controllers/web_view_controller.dart';
import '../services/json_model/basket/fetch_basket_list_model.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/my_transfer_routing_dto_model.dart';
import '../utility/all_string_const.dart';
import '../utility/device_size.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart' as u;
import '../widgets/custom_button.dart';
import 'Login_page.dart';

class BasketListTile extends StatefulWidget {
  const BasketListTile({Key? key}) : super(key: key);

  @override
  State<BasketListTile> createState() => _BasketListTileState();
}

class _BasketListTileState extends State<BasketListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LandingPage(),
    );
  }
}

class LandingPage extends GetWidget<LandingPageController> {
  SecureStorage secureStorage = SecureStorage();
  Color pickerColor = Color.fromARGB(255, 6, 94, 107);
  Color currentColor = Color.fromARGB(255, 6, 94, 107);
  InboxController inboxController = Get.put<InboxController>(InboxController());

  LoginController loginController = Get.put<LoginController>(LoginController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    inboxController.context = context;
    Orientation orientation = MediaQuery.of(context).orientation;

    print(
        "the Token Is => ${secureStorage.readSecureData(AllStringConst.Token)}");
    return SafeArea(
      child: GetBuilder<LandingPageController>(builder: (logic) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: _buildDrawer(context),
          resizeToAvoidBottomInset: false,
          body: logic.dashboardStatsResultModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : orientation == Orientation.landscape
                  ? landscapeBody(context)
                  : portraitBody(context),
        );
      }),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: _buildSideMenu(context),
    );
  }

  portraitBody(BuildContext context) {
    var appLocale = Localizations.localeOf(context).languageCode;

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              portiraitDashboardContainer(context),
              Flexible(
                flex: DeviceSize.isMobile(context) == true ? 3 : 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: portiraitDataTable(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  landscapeBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    u.returnImageNameBasedOnDirection(
                      "assets/images/landing_background",
                      context,
                      "png",
                    ),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: landscapeDashboardContainer(context),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: landscapeDataTable(context),
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

  Future<void> _showMyDialogDelFavUserConfirm(
      BuildContext context, int pos) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('SureDelFavUser'.tr),
                // Text('Would you like to confirm this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'.tr),
              onPressed: () {
                u.showLoaderDialog(context);
                controller.removeFavoriteRecipients(
                    context: context,
                    favoriteRecipients: controller
                        .favoriteRecipientsResponse!.recipients![pos].ufrId);

                print(" i removeeeeeeeeeeeeeeeeeeeeee");
                print('Confirmed');
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
                    inboxController.fetchBasketListModel!.baskets?.add(basket);

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

  portiraitDashboardContainer(BuildContext contex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // SizedBox(
        //   height: 20,
        // ),
        _buildPageHeader(contex),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: portiraitDashboard(contex),
        )
      ],
    );
  }

  Container _buildPageHeader(BuildContext contex) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(Icons.menu),
              ),
              //Icon(Icons.menu),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/Logo_qar.png',
                  height: 40,
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Container(
                color: Colors.transparent,
                child: Text(
                  "appTitle".tr,
                  style: Theme.of(contex).textTheme.headline1!.copyWith(
                        fontSize: u.calculateFontSize(30, contex),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            // height: 50,
            child: Text(
              "hello".tr +
                  "  ${secureStorage.readSecureData(AllStringConst.FirstName)} ${secureStorage.readSecureData(AllStringConst.LastName)}",
              style: Theme.of(contex).textTheme.headline2!.copyWith(
                    color: Colors.grey,
                    fontSize: u.calculateFontSize(28, contex),
                  ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  _buildSideMenu(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              print("999999999999");
              Get.toNamed("SignaturePage");
            },
            child: Container(
              height: 90,
              // color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/signature.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      "mySignatures".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            //fav users
            onTap: () async {
              //roro
              await favUsersTap(context, size);
            },
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/fav_users.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "favoritesUsers".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              print("i work h");
              u.showLoaderDialog(context);
              controller.setSelectSuggest(true);
              await Get.find<LandingPageController>()
                  .getMyRoutingsettings(context);
              await controller.listFavoriteRecipients(context: context);

              Get.bottomSheet(
                GetBuilder<LandingPageController>(builder: (logic) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: size.width * .2, left: size.width * .2),
                    child: Container(
                        //height: 100,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("myDelegations".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Image.asset(
                                      'assets/images/close_button.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                ],
                              ),

                              GetBuilder<LandingPageController>(
                                  builder: (logic) {
                                return SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller
                                              .favoriteRecipientsResponse
                                              ?.recipients
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, pos) {
                                        return InkWell(
                                          onTap: () {
                                            Destination d = Destination(
                                                id: controller
                                                    .favoriteRecipientsResponse!
                                                    .recipients![pos]
                                                    .targetGctid,
                                                value: controller
                                                    .favoriteRecipientsResponse!
                                                    .recipients![pos]
                                                    .targetName);
                                            controller.toSaveMyRoutingSettings =
                                                d;
                                            controller
                                                .textEditingControllerTorouting
                                                .text = d.value!;
                                            controller.textEditingControllerTo
                                                .text = d.value!;
                                            print(
                                                "0000000000000000000000000000");
                                            logic.update();
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 8, left: 8),
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
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(controller
                                                  .favoriteRecipientsResponse!
                                                  .recipients![pos]
                                                  .targetName!)
                                            ],
                                          ),
                                        );

                                        //  CircleAvatar(backgroundColor: Colors.red,backgroundImage: AssetImage("assets/images/pr.jpg",),,radius: 30,);
                                      }),
                                );
                              }),

                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TypeAheadField<Destination>(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller:
                                            controller.textEditingControllerTo,
                                        // autofocus: true,
                                        // style: DefaultTextStyle.of(context)
                                        //     .style
                                        //     .copyWith(fontStyle: FontStyle.italic),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'To'.tr),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return controller.users.where(
                                            (element) => element.value!
                                                .toLowerCase()
                                                .contains(
                                                    pattern.toLowerCase()));

                                        //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                                      },
                                      itemBuilder: (context, suggestion) {
                                        Destination v = suggestion;

                                        return // Te(v.originalName!);

                                            ListTile(
                                          title: FilterText(v.value!),
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        Destination v = suggestion;
                                        controller.textEditingControllerTo
                                            .text = v.value ?? "";
                                        controller.toSaveMyRoutingSettings = v;

                                        controller
                                            .textEditingControllerTorouting
                                            .text = v.value!;

                                        print("0000000000000000000000000000");
                                        logic.update();
                                        // v
                                        // .cLASNAMEDISPLAY;
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => ProductPage(product: suggestion)
                                        // ));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //    Text("start".tr),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.selectFromDocDate(
                                        context: context);
                                  },
                                  child: Container(
                                      height: 60,
                                      padding:
                                          EdgeInsets.only(right: 8, left: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: TextField(
                                        enabled: false,
                                        controller: controller
                                            .textEditingControllerFromDate,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "start".tr,
                                        ),
                                      )),
                                ),
                              ),
                              //   Text("end".tr),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.selectToDocDate(
                                        context: context);
                                  },
                                  child: Container(
                                      height: 60,
                                      padding:
                                          EdgeInsets.only(right: 8, left: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: TextField(
                                        enabled: false,
                                        maxLines: 5,
                                        controller: controller
                                            .textEditingControllerToDate,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "end".tr,
                                        ),
                                      )
                                      //   Center(child: Text(controller.toDocDate))
                                      ),
                                ),
                              ),
                              //  Text("reason".tr),
                              Container(
                                  height: 60,
                                  padding: EdgeInsets.only(right: 16, left: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: TextField(
                                    controller: controller
                                        .textEditingControllerToroutingReson,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: "reason".tr,
                                    ),
                                  )
                                  //   Center(child: Text(controller.toDocDate))
                                  ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, top: 0, bottom: 0),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          MyTransferRoutingDtoSend mytr =
                                              MyTransferRoutingDtoSend(
                                                  Name: controller
                                                      .toSaveMyRoutingSettings!
                                                      .value!,
                                                  GctId: controller
                                                      .toSaveMyRoutingSettings!
                                                      .id,
                                                  NameAr: controller
                                                      .toSaveMyRoutingSettings!
                                                      .value,
                                                  CrtComments: controller
                                                      .textEditingControllerToroutingReson
                                                      .text,
                                                  CrtFromDate: controller
                                                      .textEditingControllerFromDate
                                                      .text
                                                      .replaceAll("-", "/"),
                                                  CrtId: 0,
                                                  // controller.getMyRoutingSettingsModel.routing,
                                                  CrtToDate: controller
                                                      .textEditingControllerToDate
                                                      .text
                                                      .replaceAll("-", "/"),
                                                  CrtToGctid: controller
                                                      .toSaveMyRoutingSettings!
                                                      .id,
                                                  DoRouting: true);

                                          MyTransferRoutingRequestDto d =
                                              MyTransferRoutingRequestDto(
                                                  Token: controller
                                                      .secureStorage
                                                      .token()!,
                                                  routing: mytr);
                                          u.showLoaderDialog(context);
                                          controller
                                              .postSaveMyRoutingSettingsApi(
                                                  data: d, context: context);

                                          Get.back();
                                        },
                                        child: Text(
                                          "Save".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, top: 0, bottom: 0),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          u.showLoaderDialog(context);
                                          await controller
                                              .removeMyRoutingSettings(data: {
                                            "Token": controller.secureStorage
                                                .token(),
                                            "Language":
                                                Get.locale?.languageCode == "en"
                                                    ? "en"
                                                    : "ar"
                                          }, context: context);
                                          Get.back();
                                        },
                                        child: Text(
                                          "حذف".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  );
                }),
                enterBottomSheetDuration: const Duration(seconds: 1),
              );
            },
            child: Container(
              height: 90,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/delegation.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Text(
                      "myDelegations".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await showAllBasketsDialog(context);
              // Get.toNamed( "MyPocketsScreen",);//MyPocketsScreen
            },
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/delegation.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "Basket".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ///ToDo
              ///open url and go to userGuideUrl
              //  controller.data.userGuideUrl
              Get.find<WebViewPageController>().isPdf = true;

              Get.find<WebViewPageController>().url =
                  controller.data?.userGuideUrl;

              print(
                  "controller.data?.userGuideUrl =>${controller.data?.userGuideUrl}");
              Get.toNamed(
                "WebViewPage",
              );
            },
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/delegation.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "userGuide".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            //color
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("pick your Color"),
                        content: Column(children: [
                          buildColorPicker(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, right: 0, left: 0),
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 0, bottom: 0),
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      var locale = const Locale('ar', 'AR');
                                      Get.updateLocale(locale);
                                      SecureStorage secureStorage =
                                          SecureStorage();

                                      secureStorage.writeSecureData(
                                          AllStringConst.AppLan, "ar");
                                      Get.updateLocale(locale);
                                    },
                                    child: Text(
                                      "عربي",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 0, bottom: 0),
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      var locale = const Locale('en', 'US');
                                      SecureStorage secureStorage =
                                          SecureStorage();

                                      secureStorage.writeSecureData(
                                          AllStringConst.AppLan, "en");
                                      Get.updateLocale(locale);
                                      Get.updateLocale(locale);
                                    },
                                    child: Text(
                                      "En",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .7,
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 0),
                            height: 60,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            child: ElevatedButton(
                              onPressed: () {
                                SecureStorage secureStorage = SecureStorage();
                                secureStorage.writeSecureData(
                                    AllStringConst.AppColor,
                                    Get.find<MController>().appcolor.value);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "save",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ]),
                      ));
            },
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/palette_dark.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      "appTheme".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            //logout
            onTap: () {
              secureStorage.deleteSecureData(AllStringConst.Token);

              loginController.passWord.text = "";
              loginController.userName.text = "";
              Get.offAll(LoginPage());

              /// ToDo
              /// delet token and go to login

              //   Globals.navigatorKey.currentState?.pushNamed(LoginPageRoute);
            },
            child: Container(
              height: 90,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image(
                      image: AssetImage(
                        'assets/images/logout.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      "logout".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> favUsersTap(BuildContext context, Size size) async {
    u.showLoaderDialog(context);
    controller.setSelectSuggest(true);
    await controller.listFavoriteRecipients(context: context);
    controller.textEditingControllerTo.clear();
    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.only(right: size.width * .2, left: size.width * .2),
        child: Container(
            //height: 100,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Row(children: [
                  Text("favoritesUsers".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary)),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/close_button.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TypeAheadField<Destination>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: controller.textEditingControllerTo,
                          // autofocus: true,
                          // style: DefaultTextStyle.of(context)
                          //     .style
                          //     .copyWith(fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: ""),
                        ),
                        suggestionsCallback: (pattern) async {
                          return controller.users.where((element) => element
                              .value!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));

                          //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          Destination v = suggestion;

                          return // Te(v.originalName!);

                              ListTile(
                            title: FilterText(v.value!),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          u.showLoaderDialog(context);
                          Destination v = suggestion;
                          controller.textEditingControllerTo.text =
                              v.value ?? "";
                          controller.to = v;
                          controller.updateselectFavusers(v);
                          controller.setSelectSuggest(false);
                          controller.addFavoriteRecipients(
                              addFavorite: v.id!, context: context);
                          controller.textEditingControllerTo.clear();
                          // v
                          // .cLASNAMEDISPLAY;
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => ProductPage(product: suggestion)
                          // ));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                  ],
                ),
                GetBuilder<LandingPageController>(builder: (logic_) {
                  return Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: controller.favoriteRecipientsResponse
                                ?.recipients?.length ??
                            0,
                        itemBuilder: (context, pos) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Card(
                              elevation: 5,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: controller
                                                  .favoriteRecipientsResponse!
                                                  .recipients![pos]
                                                  .targetPhotoBs64!
                                                  .isNotEmpty
                                              ? DecorationImage(
                                                  image: MemoryImage(u
                                                      .dataFromBase64String(controller
                                                          .favoriteRecipientsResponse!
                                                          .recipients![pos]
                                                          .targetPhotoBs64!)))
                                              : DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/pr.jpg"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.favoriteRecipientsResponse!
                                              .recipients![pos].targetName ??
                                          "",
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        controller.setSelectSuggest(true);
                                        _showMyDialogDelFavUserConfirm(
                                            context, pos);
                                      },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }),
              ],
            )),
      ),
      enterBottomSheetDuration: const Duration(seconds: 1),
    );
  }

  landscapeDashboardContainer(BuildContext contex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 3,
          child: _buildPageHeader(contex),
        ),
        Flexible(
          flex: 10,
          child: landscapeDashboard(contex),
        ),
        Spacer(flex: 2),
        Flexible(
          flex: 1,
          child: Align(
            alignment: FractionalOffset.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      height: 0.5,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image(
                        image: AssetImage(
                          u.returnImageNameBasedOnOppositeDirection(
                              "assets/images/arrow", contex, "png"),
                        ),
                        fit: BoxFit.contain,
                        width: 50,
                        height: double.infinity,
                      ),
                      Text(
                        controller.data?.departmentName ??
                            "sharedServicesAdministration".tr,
                        // "sharedServicesAdministration".tr,
                        style: Theme.of(contex)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  landscapeDashboard(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      // color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildDataBoxDateTransfers(
              context, EdgeInsets.only(left: 80, right: 80, top: 1, bottom: 1)),
          // Flexible(
          //   flex: 4,
          //   child: Container(
          //     color: Colors.transparent,
          //     padding:
          //         EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
          //     child: _buildInfoBox(context),
          //   ),
          // ),
          // Flexible(
          //   flex: 3,
          //   child: Container(
          //     color: Colors.transparent,
          //     padding:
          //         EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Flexible(
          //           flex: 1,
          //           child: Container(
          //             width: double.infinity,
          //             height: double.infinity,
          //             decoration: BoxDecoration(
          //               color: Colors.white70,
          //               borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(6),
          //                   topRight: Radius.circular(6),
          //                   bottomLeft: Radius.circular(6),
          //                   bottomRight: Radius.circular(6)),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.25),
          //                   spreadRadius: 6,
          //                   blurRadius: 6,
          //                   offset: Offset(0, 0),
          //                 ),
          //               ],
          //             ),
          //             child: Container(
          //               color: Colors.transparent,
          //               width: double.infinity,
          //               height: double.infinity,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisSize: MainAxisSize.max,
          //                 children: [
          //                   Flexible(
          //                     flex: 1,
          //                     child: Text(
          //                       "myTransfersInMonth".tr +
          //                           " " +
          //                           u.calculateDate('MMMM',
          //                               Get.locale?.languageCode ?? "en"),
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .headline2!
          //                           .copyWith(
          //                               color: Colors.grey,
          //                               fontSize:
          //                                   u.calculateFontSize(16, context)),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                   Flexible(
          //                     flex: 1,
          //                     child: Text(
          //                       Get.find<LandingPageController>()
          //                               .dashboardStatsResultModel
          //                               ?.transferredFromMeCount
          //                               ?.toString() ??
          //                           "",
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .headline3!
          //                           .copyWith(
          //                             fontSize: 24,
          //                             fontFamily: "Bahij_bold",
          //                           ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(width: 20),
          //         Flexible(
          //           flex: 1,
          //           child: Container(
          //             width: double.infinity,
          //             height: double.infinity,
          //             decoration: BoxDecoration(
          //               color: Colors.white70,
          //               borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(6),
          //                   topRight: Radius.circular(6),
          //                   bottomLeft: Radius.circular(6),
          //                   bottomRight: Radius.circular(6)),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.25),
          //                   spreadRadius: 6,
          //                   blurRadius: 6,
          //                   offset: Offset(0, 0),
          //                 ),
          //               ],
          //             ),
          //             child: Container(
          //               color: Colors.transparent,
          //               width: double.infinity,
          //               height: double.infinity,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisSize: MainAxisSize.max,
          //                 children: [
          //                   Flexible(
          //                     flex: 1,
          //                     child: Text(
          //                       "mostMyTransferWentTo".tr,
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .headline2!
          //                           .copyWith(
          //                               color: Colors.grey,
          //                               fontSize:
          //                                   u.calculateFontSize(16, context)),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                   Flexible(
          //                     flex: 1,
          //                     child: Text(
          //                       Get.find<LandingPageController>()
          //                               .dashboardStatsResultModel
          //                               ?.mostTransfersWentTo ??
          //                           "",
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .headline3!
          //                           .copyWith(
          //                               fontSize: 16,
          //                               fontFamily: "Bahij_bold",
          //                               height:
          //                                   2.1 // the height between text, default is null
          //                               ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // bottom actions
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                  left: 80, right: 80, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.find<InboxController>().updateUnread(true);
                          openInbox(boxid: 0, context: context, nodeId: 20097);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "unreadCorrespondences".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.grey,
                                          // fontFamily: "Bahij_light",
                                          fontSize:
                                              u.calculateFontSize(16, context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  Get.find<LandingPageController>()
                                          .dashboardStatsResultModel
                                          ?.unreadCount
                                          ?.toString() ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize: 24,
                                        fontFamily: "Bahij_bold",
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Flexible(
                              //   flex: 1,
                              //   child: Image(
                              //     image: AssetImage(
                              //       "assets/images/arrow_L.png",
                              //     ),
                              //     fit: BoxFit.contain,
                              //     //  width: 20,
                              //     //   height: double.infinity,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          openInbox(boxid: 0, context: context, nodeId: 20094);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "pendingCorrespondences".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.grey,
                                          fontSize:
                                              u.calculateFontSize(16, context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  Get.find<LandingPageController>()
                                          .dashboardStatsResultModel
                                          ?.forActionCount
                                          ?.toString() ??
                                      ""
                                  //controller.data?.transferData.sections[].destination
                                  // controller.data?.transferData.priorities
                                  //   controller.data?.transferData.privacies.
                                  // controller.data?.transferData.purposes.
                                  //  controller.data?.signature

                                  ,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize: 24,
                                        fontFamily: "Bahij_bold",
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Flexible(
                              //   flex: 1,
                              //   child: Image(
                              //     image: AssetImage(
                              //       "assets/images/arrow_L.png",
                              //     ),
                              //     fit: BoxFit.contain,
                              //     // width: 50,
                              //     // height: double.infinity,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Flexible(
            flex: 3,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                  left: 80, right: 80, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "settings".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.grey,
                                          fontSize:
                                              u.calculateFontSize(16, context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      size: 50,
                                      Icons.settings,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .color,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () async {
                          await showAllBasketsDialog(context);
                          // openInbox(boxid: 0, context: context, nodeId: 20094);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "Basket".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.grey,
                                          fontSize:
                                              u.calculateFontSize(16, context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      size: 50,
                                      Icons.wallet,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .color,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
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

  Container _buildInfoBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70.withOpacity(0.25),
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 6,
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        u.calculateDate("dd", 'en'),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: u.calculateFontSize(45, context)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        u.calculateDate("MMMM", u.getLocaleCode(context)) +
                            " " +
                            u.calculateDate("yyyy", 'en'),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontFamily: "Bahij_light",
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        u.calculateDate("hh:mm", 'en'),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        " " + u.calculateDate("a", 'en'),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.grey.shade400, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            FractionallySizedBox(
              heightFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                width: 0.5,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "myTransfersInMonth".tr +
                            " " +
                            u.calculateDate(
                                'MMMM', Get.locale?.languageCode ?? "en"),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.grey,
                            fontSize: u.calculateFontSize(16, context)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        Get.find<LandingPageController>()
                                .dashboardStatsResultModel
                                ?.transferredFromMeCount
                                ?.toString() ??
                            "",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 24,
                              fontFamily: "Bahij_bold",
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "mostMyTransferWentTo".tr,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.grey,
                            fontSize: u.calculateFontSize(16, context)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        Get.find<LandingPageController>()
                                .dashboardStatsResultModel
                                ?.mostTransfersWentTo ??
                            "",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 16,
                            fontFamily: "Bahij_bold",
                            height:
                                2.1 // the height between text, default is null
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  portiraitDashboard(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      // color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 20,
              ),
              _buildDataBoxDateTransfers(context,
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20)),
              Flexible(
                flex: 1,
                child: Container(
                  child: SizedBox(
                    height: 180,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 0, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 0),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.25),
                                            spreadRadius: 6,
                                            blurRadius: 6,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          openInbox(
                                              boxid: 0,
                                              context: context,
                                              nodeId: 20094);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  "pendingCorrespondences".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            u.calculateFontSize(
                                                                20, context),
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  Get.find<
                                                          LandingPageController>()
                                                      .dashboardStatsResultModel!
                                                      .forActionCount
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3!
                                                      .copyWith(
                                                        fontFamily:
                                                            "Bahij_bold",
                                                        fontSize:
                                                            u.calculateFontSize(
                                                                50, context),
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 0),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.25),
                                            spreadRadius: 6,
                                            blurRadius: 6,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: InkWell(
                                          onTap: () async {
                                            await showAllBasketsDialog(context);
                                            // openInbox(boxid: 0, context: context, nodeId: 20094);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Text(
                                                    "Basket".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: u
                                                                .calculateFontSize(
                                                                    16,
                                                                    context)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Flexible(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Icon(
                                                        Icons.wallet,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline2!
                                                            .color,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  child: SizedBox(
                    height: 180,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 0, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 0),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.25),
                                            spreadRadius: 6,
                                            blurRadius: 6,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          openInbox(
                                              boxid: 0,
                                              context: context,
                                              nodeId: 20094);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  "unreadCorrespondences".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                        color: Colors.grey,
                                                        // fontFamily: "Bahij_light",
                                                        fontSize:
                                                            u.calculateFontSize(
                                                                20, context),
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  Get.find<
                                                          LandingPageController>()
                                                      .dashboardStatsResultModel!
                                                      .unreadCount
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3!
                                                      .copyWith(
                                                        fontFamily:
                                                            "Bahij_bold",
                                                        fontSize:
                                                            u.calculateFontSize(
                                                                50, context),
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 0),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                            bottomLeft: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.25),
                                            spreadRadius: 6,
                                            blurRadius: 6,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: InkWell(
                                          onTap: () {
                                            _scaffoldKey.currentState
                                                ?.openDrawer();
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Text(
                                                    "settings".tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize: u
                                                                .calculateFontSize(
                                                                    16,
                                                                    context)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Flexible(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Icon(
                                                        Icons.settings,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline2!
                                                            .color,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
    );
  }

  Flexible _buildDataBoxDateTransfers(
      BuildContext context, EdgeInsetsGeometry padding) {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70.withOpacity(0.25),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 6,
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        u.calculateDate("dd", 'en'),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: u.calculateFontSize(45, context)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        u.calculateDate("MMMM", u.getLocaleCode(context)) +
                            " " +
                            u.calculateDate("yyyy", 'en'),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: u.calculateFontSize(45, context),
                              fontFamily: "Bahij_light",
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        u.calculateDate("hh:mm", 'en'),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.grey,
                              fontSize: u.calculateFontSize(50, context),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        " " + u.calculateDate("a", 'en'),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.grey.shade400,
                              fontSize: u.calculateFontSize(50, context),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              FractionallySizedBox(
                heightFactor: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  width: 0.5,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "myTransfersInMonth".tr +
                            " " +
                            u.calculateDate(
                                'MMMM', Get.locale?.languageCode ?? "en"),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.grey,
                              fontSize: u.calculateFontSize(
                                35,
                                context,
                              ),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        Get.find<LandingPageController>()
                                .dashboardStatsResultModel
                                ?.transferredFromMeCount
                                ?.toString() ??
                            "",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: u.calculateFontSize(45, context),
                              fontFamily: "Bahij_bold",
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "mostMyTransferWentTo".tr,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.grey,
                            fontSize: u.calculateFontSize(35, context)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        Get.find<LandingPageController>()
                                .dashboardStatsResultModel
                                ?.mostTransfersWentTo ??
                            " ? ",
                        //"???",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: u.calculateFontSize(10, context),
                              fontFamily: "Bahij_bold",
                              //height: 2.1 // the height between text, default is null
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  portiraitDataTable(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: u.createMaterialColor(Color.fromRGBO(255, 255, 255, 0.8)),
      ),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            _buildDataLabelTitleLabel(
              context,
              "mail".tr,
            ),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              children: Get.find<LandingPageController>()
                  .dashboardStatsResultModel!
                  .inboxCategories!
                  .map(
                    (e) => TableRow(
                      children: [
                        TableRowInkWell(
                          onTap: () {
                            openInbox(
                                boxid: 0,
                                context: context,
                                nodeId: e.value!.nodeId!);
                            //   openInbox(context);
                          },
                          child: _buildInboxesRow(
                            context,
                            e.key!,
                            e.value!.count!,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),

            _buildDataLabelTitleLabel(context, "folders".tr),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              children: [
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        Get.find<InboxController>().allCorrespondences.clear();
                        Get.find<InboxController>().nodeId = 0;
                        Get.find<InboxController>().isAllOrNot = true;
                        Get.find<InboxController>().getAllCorrespondencesData(
                            context: context, inboxId: 1);
                        Get.find<InboxController>().selectUserFilter = null;
                        Get.find<InboxController>().userFilter.clear();
                        Get.toNamed("/InboxPage");
                      },
                      child: _buildOtherFoldersRows(
                        context,
                        "allincom".tr,
                        "assets/images/incoming_icon.png",
                        true,
                        "",
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        Get.find<InboxController>().allCorrespondences.clear();
                        Get.find<InboxController>().nodeId = 0;
                        Get.find<InboxController>().isAllOrNot = true;
                        Get.find<InboxController>().getAllCorrespondencesData(
                            context: context, inboxId: 5);
                        Get.find<InboxController>().selectUserFilter = null;
                        Get.find<InboxController>().userFilter.clear();
                        Get.toNamed("/InboxPage");
                      },
                      child: _buildOtherFoldersRows(
                        context,
                        // "notifications".tr,
                        "allout".tr,
                        // "assets/images/notification.png",
                        "assets/images/outgoing_icon.png",
                        true,
                        "",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildDataLabelTitleLabel(context, "search".tr),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              children: [
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        Get.toNamed("SearchPage");
                      },
                      child: _buildOtherFoldersRows(
                          context,
                          "advancedSearch".tr,
                          "assets/images/search_icon.png",
                          true,
                          ""),
                    ),
                  ],
                ),
              ],
            ),
            // Container(
            //   height: 100,
            //   width: MediaQuery.of(context).size.width,
            //   child: _buildSideMenuPort(context),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 0),
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Image(
                            image: AssetImage(
                              u.returnImageNameBasedOnOppositeDirection(
                                  "assets/images/arrow", context, "png"),
                            ),
                          ),
                        ),
                        Text(
                          controller.data?.departmentName ??
                              "sharedServicesAdministration".tr,
                          // "sharedServicesAdministration".tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  landscapeDataTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 60,
          right: 60,
          top: u.calculateHeight(100, context),
          bottom: u.calculateHeight(80, context)),
      child: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: u.createMaterialColor(Color.fromRGBO(255, 255, 255, 0.8)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 6,
              blurRadius: 6,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildDataLabelTitleLabel(
              context,
              "mail".tr,
            ),

            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              children: Get.find<LandingPageController>()
                  .dashboardStatsResultModel!
                  .inboxCategories!
                  .map(
                    (e) => TableRow(
                      children: [
                        TableRowInkWell(
                          onTap: () {
                            openInbox(
                                boxid: 0,
                                context: context,
                                nodeId: e.value!.nodeId!
                                //20094
                                );
                          },
                          child: _buildInboxesRow(
                            context,
                            e.key!,
                            e.value!.count!,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),

            //  Container(color: Colors.red, height: 100,width: MediaQuery.of(context).size.width, child: _buildSideMenuPort(  context),),
            Container(
              height: 30,
            ),

            _buildDataLabelTitleLabel(context, "folders".tr),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              children: [
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        //openInbox(context);
                        Get.find<InboxController>().allCorrespondences.clear();
                        Get.find<InboxController>().nodeId = 0;
                        Get.find<InboxController>().isAllOrNot = true;
                        Get.find<InboxController>().getAllCorrespondencesData(
                            context: context, inboxId: 1);
                        Get.find<InboxController>().selectUserFilter = null;
                        Get.find<InboxController>().userFilter.clear();
                        Get.toNamed("/InboxPage");
                      },
                      child: _buildOtherFoldersRows(
                        context,
                        "allincom".tr,
                        "assets/images/incoming_icon.png",
                        true,
                        "",
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        //openInbox(context);
                        Get.find<InboxController>().allCorrespondences.clear();
                        Get.find<InboxController>().nodeId = 0;
                        Get.find<InboxController>().isAllOrNot = true;
                        Get.find<InboxController>().getAllCorrespondencesData(
                            context: context, inboxId: 5);
                        Get.find<InboxController>().selectUserFilter = null;
                        Get.find<InboxController>().userFilter.clear();
                        Get.toNamed("/InboxPage");
                      },
                      child: _buildOtherFoldersRows(
                        context,
                        "allout".tr,
                        // "assets/images/notification.png",
                        "assets/images/outgoing_icon.png",
                        true,
                        "",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            _buildDataLabelTitleLabel(context, "search".tr),
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
                bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid),
              ),
              children: [
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        Get.find<SearchController>().getAllData();

                        Get.toNamed("SearchPage");
                      },
                      child: _buildOtherFoldersRows(
                          context,
                          "advancedSearch".tr,
                          "assets/images/search_icon.png",
                          false,
                          ""),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildDataLabelTitleLabel(BuildContext context, String title) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      color: Colors.transparent,
      width: double.infinity,
      height: u.calculateHeight(
          orientation == Orientation.landscape ? 50 : 40, context),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Colors.grey.shade400, fontSize: 12),
        textAlign: TextAlign.start,
      ),
    );
  }

  _buildInboxesRow(BuildContext content, String title, int count) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
      width: double.infinity,
      height: u.calculateHeight(60, content),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(content).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                width: 12,
                height: 12,
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
            flex: 10,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Text(
                title,
                style: Theme.of(content).textTheme.headline1!.copyWith(
                    color: Colors.grey, fontFamily: "Bahij_bold", fontSize: 17),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              width: 70,
              child: Text(
                count.toString(),
                style: Theme.of(content)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Image(
              image: AssetImage(
                u.returnImageNameBasedOnOppositeDirection(
                    "assets/images/arrow", content, "png"),
              ),
              fit: BoxFit.contain,
              width: 35,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  _buildOtherFoldersRows(BuildContext context, String title, String iconTitle,
      bool showCount, count) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: orientation == Orientation.landscape ? 20 : 0,
          bottom: 0),
      width: double.infinity,
      height: u.calculateHeight(
          orientation == Orientation.landscape ? 80 : 60, context),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Image(
                image: AssetImage(
                  iconTitle,
                ),
                fit: BoxFit.contain,
                width: 32,
                height: 32,
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
            flex: 10,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.grey, fontSize: 17),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
            flex: 1,
            child: Visibility(
              //visible: showCount,
              child: Container(
                color: Colors.transparent,
                width: 70,
                child: Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 12),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Image(
              image: AssetImage(
                u.returnImageNameBasedOnOppositeDirection(
                    "assets/images/arrow", context, "png"),
              ),
              fit: BoxFit.contain,
              width: 35,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  openInbox(
      {required BuildContext context,
      required int boxid,
      required int nodeId}) {
    Get.find<InboxController>().allCorrespondences.clear();
    Get.find<InboxController>().isAllOrNot = false;
    Get.find<InboxController>().inboxId = boxid;
    Get.find<InboxController>().nodeId = nodeId;
    Get.find<InboxController>().context = context;
    Get.find<InboxController>().getAllData(context: context);
    Get.find<InboxController>().selectUserFilter = null;

    Get.find<InboxController>().userFilter.clear();
    Get.toNamed("/InboxPage");
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: pickerColor,
      onColorChanged: (Color color) {
        Get.find<MController>().setAppColor(color);
        print(color);
        pickerColor = color;
      },
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
}
