import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../controllers/basket_controller.dart';
import '../../controllers/document_controller.dart';
import '../../controllers/inbox_controller.dart';
import '../../controllers/my_cart/create_basket_controller.dart';
import '../../services/apis/reply_with_voice_note_api.dart';
import '../../services/json_model/login_model.dart';
import '../../services/json_model/reply_with_voicenote_model.dart';
import '../../services/json_model/send_json_model/reply_with_voice_note_request.dart';
import '../../utility/all_const.dart';
import '../../utility/storage.dart';
import '../../utility/utilitie.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_button_with_icon.dart';

class MyPocketsScreen extends GetWidget<InboxController> {
  SecureStorage secureStorage = SecureStorage();

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
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: _buildTopBar(context),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: ListView1()),
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

  static Future<String?> showInputDialog(
      BuildContext context, String title, String defaultInput, String message) {
    var textController = TextEditingController(text: defaultInput);
    var content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Text(message), TextField(controller: textController)
        // CreateNewBasket(),

        Form(
            // key: controller.createBasketFormKey,
            // child: LayoutBuilder(builder: (context, constraint) {
            //   return Container(
            child: Column(
          children: [
            // Spacer(),
            // CustomInputTextFiled(
            //     validator: controller.validators.nameValidator,
            //     textEditingController: controller.englishName,
            //     label: "english_name".tr),
            // CustomInputTextFiled(
            //     validator: controller.validators.nameValidator,
            //     textEditingController: controller.arabicName,
            //     label: "arabic_name".tr),

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
                    // controller: controller.textEditingControllerEnglishName,
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
                    // controller: controller.textEditingControllerArabicName,
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
                                "pick your Color",
                              ),
                              content: Column(children: [
                                ColorPicker(
                                  pickerColor:
                                      Get.find<CreateBasketController>()
                                          .pickerColor,
                                  onColorChanged: (Color color) {
                                    // Get.find<MController>().setAppColor(color);
                                    // print(color);
                                    // controller.setPickerColor(color);
                                    Get.find<CreateBasketController>()
                                        .setPickerColor(color);
                                    // setState(() {
                                    //   controller.setPickerColor(color);
                                    // });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8, right: 20, left: 20),
                                  child: Row(children: []),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .7,
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
                                      // Get.find<SecureStorage>().writeSecureData(
                                      //     AllStringConst.AppColor,
                                      //     Get.find<MController>().appcolor.value);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "save",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .headline2!
                                      //     .copyWith(
                                      //     color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ]),
                            ));
                  },
                  child: GetBuilder<CreateBasketController>(
                    init: CreateBasketController(),
                    builder: (_) {
                      return Text("pick your Color",
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
                    // controller.createNewBasket();
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
            // actions: <Widget>[
            //   TextButton(
            //     child: const Text('Cancel'),
            //     onPressed: () => Navigator.pop(context),
            //   ),
            //   TextButton(
            //     child: const Text('Okay'),
            //     onPressed: () => Navigator.pop(context, textController.text),
            //   ),
            // ],
          ),
        );
      },
    );
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: Get.find<CreateBasketController>().pickerColor,
      onColorChanged: (Color color) {
        Get.find<CreateBasketController>().setPickerColor(color);
      },
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

  // _buildSideMenu(context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.max,
  //     children: [
  //       Container(
  //         width: 10,
  //         height: double.infinity,
  //         color: Colors.grey.shade400,
  //       ),
  //       Expanded(
  //         child: Column(
  //           children: [
  //             //hello container
  //             Container(
  //               padding: const EdgeInsets.only(
  //                   left: 20, right: 20, top: 20, bottom: 20),
  //               width: double.infinity,
  //               height: 120,
  //               color: Colors.transparent,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 mainAxisSize: MainAxisSize.max,
  //                 children: [
  //                   Text(
  //                     "hello".tr,
  //                     style: Theme
  //                         .of(context)
  //                         .textTheme
  //                         .headline2!
  //                         .copyWith(color: Colors.grey, fontSize: 14),
  //                     textAlign: TextAlign.start,
  //                   ),
  //                   FittedBox(
  //                     child: Text(
  //                       //  "hello".tr +
  //                       "${secureStorage.readSecureData(
  //                           AllStringConst.FirstName)} ${secureStorage
  //                           .readSecureData(AllStringConst.LastName)}",
  //                       style: Theme
  //                           .of(context)
  //                           .textTheme
  //                           .headline2!
  //                           .copyWith(
  //                           color: createMaterialColor(
  //                             const Color.fromRGBO(77, 77, 77, 1),
  //                           ),
  //                           fontSize: 20),
  //                       textAlign: TextAlign.start,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             //empty space
  //             Container(
  //               width: double.infinity,
  //               height: 30,
  //               color: Colors.transparent,
  //             ),
  //             //side menu filter (filters with inbox type or with purpose -- depends on the configuration)
  //             Expanded(
  //               child: _buildSideMenuFilters(context),
  //             ),
  //             //department container
  //             SizedBox(
  //               height: 80,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.max,
  //                 children: [
  //                   //line separator
  //                   Container(
  //                     height: 1,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey.shade400,
  //                       borderRadius: const BorderRadius.all(
  //                         Radius.circular(4),
  //                       ),
  //                     ),
  //                   ),
  //                   //space
  //                   Container(
  //                     height: 20,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Image(
  //                         image: AssetImage(
  //                           returnImageNameBasedOnOppositeDirection(
  //                             "assets/images/arrow",
  //                             context,
  //                             "png",
  //                           ),
  //                         ),
  //                         fit: BoxFit.contain,
  //                         width: 35,
  //                       ),
  //                       Align(
  //                         alignment: isDirectionRTL(context)
  //                             ? FractionalOffset.centerRight
  //                             : FractionalOffset.centerLeft,
  //                         child: Text(
  //                           "sharedServicesAdministration".tr,
  //                           style:
  //                           Theme
  //                               .of(context)
  //                               .textTheme
  //                               .headline2!
  //                               .copyWith(
  //                             color: createMaterialColor(
  //                               const Color.fromRGBO(77, 77, 77, 1),
  //                             ),
  //                             fontSize: 15,
  //                           ),
  //                           textAlign: TextAlign.start,
  //                           maxLines: 3,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

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
                        .copyWith(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     //  Get.back();
          //     Navigator.pop(context);
          //   },
          //   child: Container(
          //     width: 120,
          //     height: double.infinity,
          //     color: Colors.transparent,
          //     child: const Image(
          //       image: AssetImage(
          //         'assets/images/menu.png',
          //       ),
          //       fit: BoxFit.contain,
          //       width: double.infinity,
          //       height: double.infinity,
          //     ),
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     //  Get.back();
          //     // Navigator.pop(context);
          //     // controller
          //     //     .showMyFavListScreen(!controller.showHideMyFavListScreen);
          //     // controller.showFilterScreen(!controller.showHideFilterScreen);
          //     showGeneralDialog(
          //         context: context,
          //         barrierDismissible: true,
          //         barrierLabel: MaterialLocalizations.of(context)
          //             .modalBarrierDismissLabel,
          //         barrierColor: Colors.black45,
          //         transitionDuration: const Duration(milliseconds: 200),
          //         pageBuilder: (BuildContext buildContext, Animation animation,
          //             Animation secondaryAnimation) {
          //           return Center(
          //             child: Container(
          //               width: MediaQuery.of(context).size.width - 100,
          //               height: MediaQuery.of(context).size.height - 130,
          //               // padding: EdgeInsets.all(20),
          //               color: Colors.white,
          //               child: MyFavListViewWidget(),
          //               // RaisedButton(
          //               //   onPressed: () {
          //               //     Navigator.of(context).pop();
          //               //   },
          //             ),
          //           );
          //         });
          //   },
          //   child: Visibility(
          //     child: Container(
          //       width: 40,
          //       padding: const EdgeInsets.only(right: 10),
          //       // height: double.infinity,
          //       height: 40,
          //       color: Colors.transparent,
          //       // color: Colors.white,
          //       child: const Image(
          //         image: AssetImage(
          //           'assets/images/favorites.png',
          //         ),
          //         fit: BoxFit.contain,
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.white,
          //       ),
          //     ),
          //     // visible: controller.showHideFilterScreen,
          //     visible: true,
          //   ),
          // ),
          //
          // InkWell(
          //   onTap: () {
          //     //  Get.back();
          //     // Navigator.pop(context);
          //     // controller.showFilterScreen(!controller.showHideFilterScreen);
          //     showGeneralDialog(
          //         context: context,
          //         barrierDismissible: true,
          //         barrierLabel: MaterialLocalizations.of(context)
          //             .modalBarrierDismissLabel,
          //         barrierColor: Colors.black45,
          //         transitionDuration: const Duration(milliseconds: 200),
          //         pageBuilder: (BuildContext buildContext, Animation animation,
          //             Animation secondaryAnimation) {
          //           return Center(
          //             child: Container(
          //               width: MediaQuery.of(context).size.width - 100,
          //               height: MediaQuery.of(context).size.height - 130,
          //               // padding: EdgeInsets.all(20),
          //               color: Colors.white,
          //               child: AllAvailablePocketsPage(),
          //               // RaisedButton(
          //               //   onPressed: () {
          //               //     Navigator.of(context).pop();
          //               //   },
          //             ),
          //           );
          //         });
          //   },
          //   child: Visibility(
          //     child: Container(
          //       width: 40,
          //       padding: const EdgeInsets.only(right: 10),
          //       // height: double.infinity,
          //       height: 40,
          //       color: Colors.transparent,
          //       // color: Colors.white,
          //       child: const Image(
          //         image: AssetImage(
          //           // 'assets/images/pin.png',
          //           'assets/images/import.png',
          //         ),
          //         fit: BoxFit.contain,
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.white,
          //       ),
          //     ),
          //     // visible: controller.showHideFilterScreen,
          //     visible: true,
          //   ),
          // ),
          //
          // InkWell(
          //   onTap: () {
          //     //  Get.back();
          //     // Navigator.pop(context);
          //     // controller.showCreateNewBasketScreen(
          //     //     !controller.showHideCreateNewBasketScreen);
          //     // showGeneralDialog(
          //     //     context: context,
          //     //     barrierDismissible: true,
          //     //     barrierLabel: MaterialLocalizations.of(context)
          //     //         .modalBarrierDismissLabel,
          //     //     barrierColor: Colors.black45,
          //     //     transitionDuration: const Duration(milliseconds: 200),
          //     //     pageBuilder: (BuildContext buildContext, Animation animation,
          //     //         Animation secondaryAnimation) {
          //     //       return Center(
          //     //         child: Container(
          //     //           width: MediaQuery.of(context).size.width - 700,
          //     //           height: MediaQuery.of(context).size.height - 200,
          //     //           // padding: EdgeInsets.all(20),
          //     //           color: Colors.white,
          //     //           child: CreateNewBasket(),
          //     //           // RaisedButton(
          //     //           //   onPressed: () {
          //     //           //     Navigator.of(context).pop();
          //     //           //   },
          //     //         ),
          //     //       );
          //     //     });
          //
          //     showInputDialog(
          //         context, 'CreateNewBasket', 'default inpit', 'message');
          //   },
          //   child: Visibility(
          //     child: Container(
          //       width: 40,
          //       padding: const EdgeInsets.only(right: 10),
          //       // height: double.infinity,
          //       height: 40,
          //       color: Colors.transparent,
          //       // color: Colors.white,
          //       child: const Image(
          //         image: AssetImage(
          //           'assets/images/add.png',
          //         ),
          //         fit: BoxFit.contain,
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.white,
          //       ),
          //     ),
          //     // visible: controller.showHideFilterScreen,
          //     visible: true,
          //   ),
          // ),

          // InkWell(
          //   onTap: () {
          //     //  Get.back();
          //     // Navigator.pop(context);
          //     // controller.showFilterScreen(!controller.showHideFilterScreen);
          //     showGeneralDialog(
          //         context: context,
          //         barrierDismissible: true,
          //         barrierLabel: MaterialLocalizations.of(context)
          //             .modalBarrierDismissLabel,
          //         barrierColor: Colors.black45,
          //         transitionDuration: const Duration(milliseconds: 200),
          //         pageBuilder: (BuildContext buildContext, Animation animation,
          //             Animation secondaryAnimation) {
          //           return Center(
          //             child: Container(
          //               width: MediaQuery.of(context).size.width - 100,
          //               height: MediaQuery.of(context).size.height - 130,
          //               // padding: EdgeInsets.all(20),
          //               color: Colors.white,
          //               child: FilterSlidePage(),
          //               // RaisedButton(
          //               //   onPressed: () {
          //               //     Navigator.of(context).pop();
          //               //   },
          //             ),
          //           );
          //         });
          //   },
          //   child: Visibility(
          //     child: Container(
          //       width: 40,
          //       padding: const EdgeInsets.only(right: 10),
          //       // height: double.infinity,
          //       height: 40,
          //       color: Colors.transparent,
          //       // color: Colors.white,
          //       child: const Image(
          //         image: AssetImage(
          //           'assets/images/filter.png',
          //         ),
          //         fit: BoxFit.contain,
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Colors.white,
          //       ),
          //     ),
          //     // visible: controller.showHideFilterScreen,
          //     visible: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  // _buildTopInboxMenu(BuildContext context) {
  //   return Container(
  //     color: Colors.transparent,
  //     width: MediaQuery
  //         .of(context)
  //         .size
  //         .width,
  //     height: MediaQuery
  //         .of(context)
  //         .size
  //         .height,
  //     child: DefaultTabController(
  //       length: 4,
  //       child: ContainedTabBarView(
  //         tabs: [
  //           // Text(
  //           //   "all".tr,
  //           //   style: Theme.of(context).textTheme.headline1!.copyWith(
  //           //         color: Colors.grey,
  //           //         fontSize: 21,
  //           //       ),
  //           // ),
  //           Text(
  //             "incoming".tr,
  //             style: Theme
  //                 .of(context)
  //                 .textTheme
  //                 .headline1!
  //                 .copyWith(color: Colors.grey, fontSize: 21),
  //           ),
  //           Text(
  //             "outgoing".tr,
  //             style: Theme
  //                 .of(context)
  //                 .textTheme
  //                 .headline1!
  //                 .copyWith(color: Colors.grey, fontSize: 21),
  //           ),
  //           Text(
  //             "internal".tr,
  //             style: Theme
  //                 .of(context)
  //                 .textTheme
  //                 .headline1!
  //                 .copyWith(color: Colors.grey, fontSize: 21),
  //           ),
  //         ],
  //         tabBarProperties: TabBarProperties(
  //           width: MediaQuery
  //               .of(context)
  //               .size
  //               .width,
  //           height: 70.0,
  //           indicatorColor: Theme
  //               .of(context)
  //               .colorScheme
  //               .primary,
  //           indicatorWeight: 5.0,
  //           labelColor: Colors.black,
  //           unselectedLabelColor: Colors.black87,
  //           alignment: TabBarAlignment.start,
  //         ),
  //         views: [
  //           // Center(
  //           //     child: controller.getData && !controller.addToList
  //           //         ? const Center(child: CircularProgressIndicator())
  //           //         : Column(
  //           //             children: [
  //           //               _filterMail(context),
  //           //               Expanded(
  //           //                 child: CustomListView(
  //           //                   function: controller.onRefresh(),
  //           //                   correspondences: controller.correspondences ?? [],
  //           //                   scrollController: controller.scrollController,
  //           //                   haveMoreData: controller.haveMoreData,
  //           //                   onClickItem: () {
  //           //
  //           //
  //           //
  //           //                  //   Get.toNamed("/DocumentPage");
  //           //                   },
  //           //                 ),
  //           //               ),
  //           //             ],
  //           //           )),
  //
  //           Center(
  //               child: controller.getData
  //                   ? const Center(child: CircularProgressIndicator())
  //                   : Column(
  //                 children: [
  //                   Visibility(
  //                       visible: false, child: _filterMail(context)),
  //                   Expanded(
  //                     child: CustomListView(
  //                       function: controller.onRefresh(),
  //                       correspondences: controller.correspondences ?? [],
  //                       scrollController: controller.scrollController,
  //                       haveMoreData: controller.haveMoreData,
  //                       onClickItem: () {
  //                         //     Get.toNamed("/DocumentPage");
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //           Center(
  //               child: controller.getData
  //                   ? const Center(child: CircularProgressIndicator())
  //                   : Column(
  //                 children: [
  //                   Visibility(
  //                       visible: false, child: _filterMail(context)),
  //                   Expanded(
  //                     child: CustomListView(
  //                       function: controller.onRefresh(),
  //                       correspondences: controller.correspondences ?? [],
  //                       scrollController: controller.scrollController,
  //                       haveMoreData: controller.haveMoreData,
  //                       onClickItem: () {
  //                         Get.toNamed("/DocumentPage");
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //           Center(
  //               child: controller.getData
  //                   ? const Center(child: CircularProgressIndicator())
  //                   : Column(
  //                 children: [
  //                   Visibility(
  //                       visible: false, child: _filterMail(context)),
  //                   Expanded(
  //                     child: CustomListView(
  //                       function: controller.onRefresh(),
  //                       correspondences: controller.correspondences ?? [],
  //                       scrollController: controller.scrollController,
  //                       haveMoreData: controller.haveMoreData,
  //                       onClickItem: () {
  //                         Get.toNamed("/DocumentPage");
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //         ],
  //         onChange: (value) {
  //           controller.getData = true;
  //           controller.addToList = false;
  //           controller.index = 0;
  //           if (value == 0) {
  //             //  Globals.inboxIdForCorrespondencesList = 5;
  //
  //             controller.inboxId = 5;
  //             controller.getCorrespondencesData(inboxId: 5);
  //           } else if (value == 1) {
  //             controller.inboxId = 1;
  //             controller.getCorrespondencesData(inboxId: 1);
  //             //     Globals.inboxIdForCorrespondencesList = 1;
  //             controller.inboxId = 1;
  //           } else if (value == 2) {
  //             controller.inboxId = 5;
  //             controller.getCorrespondencesData(inboxId: 5);
  //             //  Globals.inboxIdForCorrespondencesList = 5;
  //           } else if (value == 3) {
  //             controller.inboxId = 3;
  //             controller.getCorrespondencesData(inboxId: 3);
  //             //   Globals.inboxIdForCorrespondencesList = 3;
  //           }
  //           //  else {
  //           //    controller.     getCorrespondencesData(index: 5);
  //           // //   Globals.inboxIdForCorrespondencesList = 5;
  //           //  }
  //           //  print(Globals.inboxIdForCorrespondencesList);
  //         },
  //       ),
  //     ),
  //   );
  // }

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
                "وارد للكل".tr,
                "assets/images/incoming_icon.png",
                false,
                05),
            _buildSideMenuFolders(
                context,
                // "notifications".tr,
                "صادر للكل".tr,
                "assets/images/outgoing_icon.png",
                false,
                19)
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

const List<String> texts1 = [
  "للعلم والاطلاع",
  "لاجراء اللازم",
  "للافاده",
  "للتوجيه",
];

class ListView1 extends StatefulWidget {
  const ListView1({Key? key}) : super(key: key);

  @override
  State<ListView1> createState() => _ListView1State();
}

class _ListView1State extends State<ListView1> {
  // You can also use `Map` but for the sake of simplicity I'm using two separate `List`.
  // List<int> _list = List.generate(20, (i) => i);
  // List<bool> _selected = List.generate(
  //     texts1.length, (i) => false); // Fill it with false initially

  bool isSelected = false;
  BasketController controller = Get.find<BasketController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return GetBuilder<BasketController>(builder: (logic) {
      return logic.getBasketInboxModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              controller: controller.scrollController,
              itemBuilder: (context, pos) {
                if (pos < logic.getBasketInboxModel!.correspondences!.length) {
                  return InkWell(
                    onTap: () {
                      Get.find<InboxController>().openDocument(
                          context: context,
                          correspondence:
                              logic.getBasketInboxModel!.correspondences![pos]);
                      // Get.find<DocumentController>().correspondences =
                      //     logic.getBasketInboxModel!.correspondences![pos];
                      // Get.find<DocumentController>()
                      //     .documentEditedInOfficeId
                      //     .value = 0;
                      // Get.toNamed("/DocumentPage");
                    },
                    child: SizedBox(
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
                                          itemCount: logic
                                              .getBasketInboxModel!
                                              .correspondences?[pos]
                                              .gridInfo
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .1,
                                                    child: Text(
                                                      logic
                                                              .getBasketInboxModel!
                                                              .correspondences![
                                                                  pos]
                                                              .gridInfo?[index]
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
                                                    child: Text(
                                                      logic
                                                              .getBasketInboxModel!
                                                              .correspondences![
                                                                  pos]
                                                              .gridInfo?[index]
                                                              .value ??
                                                          "",
                                                      softWrap: true,
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(logic
                                                  .getBasketInboxModel!
                                                  .correspondences![pos]
                                                  .isLocked!
                                              ? Icons.lock
                                              : Icons.lock_open),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: logic
                                                            .getBasketInboxModel!
                                                            .correspondences![
                                                                pos]
                                                            .priorityId ==
                                                        "1"
                                                    ? Colors.green
                                                    : Colors.red,
                                                shape: BoxShape.circle),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(logic
                                                  .getBasketInboxModel!
                                                  .correspondences![pos]
                                                  .fromUser ??
                                              ""),
                                          if (logic
                                                  .getBasketInboxModel!
                                                  .correspondences![pos]
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
                                        if (logic.getBasketInboxModel!
                                            .correspondences![pos].isSelect) {
                                          logic
                                              .getBasketInboxModel!
                                              .correspondences![pos]
                                              .isSelect = false;
                                        } else {
                                          logic
                                              .getBasketInboxModel!
                                              .correspondences![pos]
                                              .isSelect = true;
                                        }
                                        if (logic.getBasketInboxModel!
                                            .correspondences![pos].isSelect) {
                                          Get.find<InboxController>()
                                              .listSelectCorrespondences
                                              .add(int.parse(logic
                                                  .getBasketInboxModel!
                                                  .correspondences![pos]
                                                  .correspondenceId!));
                                        } else {
                                          Get.find<InboxController>()
                                              .listSelectCorrespondences
                                              .remove(logic.getBasketInboxModel!
                                                  .correspondences![pos]);
                                        }

                                        Get.find<InboxController>().update();
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset(logic
                                                      .getBasketInboxModel!
                                                      .correspondences![pos]
                                                      .isSelect
                                                  ? "assets/images/check.png"
                                                  : "assets/images/uncheck.png"))),
                                    )
                                  : PopupMenuButton(
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
                                              onTap: () {},
                                              //logic.functionReply,
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.account_circle,
                                                      color: Colors.red),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text("Transfer"),
                                                ],
                                              ),
                                              value: 2,
                                              onTap: () {},
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
                                              onTap: () {},
                                              value: 3,
                                            ),
                                            if (logic
                                                    .getBasketInboxModel!
                                                    .correspondences![pos]
                                                    .hasSummaries ??
                                                false)
                                              PopupMenuItem(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.menu,
                                                        color:
                                                            Colors.blueAccent),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text("Summary"),
                                                  ],
                                                ),
                                                onTap: () {},
                                                value: 4,
                                              ),
                                          ],
                                      enableFeedback: true,
                                      onSelected: (v) async {
                                        if (v == 1) {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text(" "),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .8,
                                                  color: Colors.grey[200],
                                                  child: SingleChildScrollView(
                                                    child: Column(children: [
                                                      Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(logic
                                                                      .getBasketInboxModel!
                                                                      .correspondences![
                                                                          pos]
                                                                      .fromUser ??
                                                                  ""),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "name".tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline3!
                                                                  .copyWith(
                                                                    color:
                                                                        createMaterialColor(
                                                                      const Color
                                                                              .fromRGBO(
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
                                                                        child: GetBuilder<
                                                                                InboxController>(
                                                                            id:
                                                                                "id",
                                                                            builder:
                                                                                (logic) {
                                                                              return Icon(Get.find<InboxController>().recording ? Icons.stop : Icons.mic);
                                                                            }),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {},
                                                                        child: Icon(
                                                                            Icons.play_arrow),
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
                                                            Get.find<
                                                                    InboxController>()
                                                                .replyNote = v;
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
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    String? audioFileBes64 =
                                                        await audiobase64String(
                                                            file: Get.find<
                                                                    InboxController>()
                                                                .recordFile);

                                                    ReplyWithVoiceNoteApi
                                                        replayAPI =
                                                        ReplyWithVoiceNoteApi(
                                                            context);

                                                    ReplyWithVoiceNoteRequestModel v = ReplyWithVoiceNoteRequestModel(
                                                        userId: logic
                                                            .getBasketInboxModel!
                                                            .correspondences![
                                                                pos]
                                                            .fromUserId
                                                            .toString(),
                                                        transferId: logic
                                                            .getBasketInboxModel!
                                                            .correspondences![
                                                                pos]
                                                            .transferId,
                                                        token: Get.find<
                                                                InboxController>()
                                                            .secureStorage
                                                            .token(),
                                                        correspondencesId: logic
                                                            .getBasketInboxModel!
                                                            .correspondences![
                                                                pos]
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
                                                        voiceNoteExt: "m4a",
                                                        voiceNotePrivate:
                                                            false);

                                                    replayAPI
                                                        .post(v.toMap())
                                                        .then((value) {
                                                      print("1" * 50);
                                                      ReplyWithVoiceNoteModel
                                                          v = value
                                                              as ReplyWithVoiceNoteModel;
                                                      print(v.errorMessage);
                                                      print(v.status);
                                                      print("1" * 50);
                                                    });

                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text("Ok"),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (v == 2) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Row(children: [
                                                    Image.asset(
                                                      'assets/images/refer.png',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "refer".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                            color:
                                                                createMaterialColor(
                                                              const Color
                                                                      .fromRGBO(
                                                                  77,
                                                                  77,
                                                                  77,
                                                                  1),
                                                            ),
                                                            fontSize: 15,
                                                          ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.find<
                                                                InboxController>()
                                                            .filterWord = "";
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/close_button.png',
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                    ),
                                                  ]),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Container(
                                                                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: const BorderRadius.all(Radius.circular(6))),
                                                                      child: TextField(
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              UnderlineInputBorder(),
                                                                          labelText:
                                                                              'To',
                                                                        ),
                                                                        onChanged:
                                                                            Get.find<InboxController>().filterUser,
                                                                      ))),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              CustomButtonWithIcon(
                                                                  icon: Icons
                                                                      .person,
                                                                  onClick: () {
                                                                    Get.find<
                                                                            InboxController>()
                                                                        .listOfUser(
                                                                            0);
                                                                  }),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              CustomButtonWithIcon(
                                                                  icon: Icons
                                                                      .account_balance,
                                                                  onClick: () {
                                                                    Get.find<
                                                                            InboxController>()
                                                                        .listOfUser(
                                                                            1);
                                                                  }),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              CustomButtonWithIcon(
                                                                  icon: Icons
                                                                      .person,
                                                                  onClick: () {
                                                                    Get.find<
                                                                            InboxController>()
                                                                        .listOfUser(
                                                                            2);
                                                                  }),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text("referTo".tr),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .8,
                                                              height: 100,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: GetBuilder<
                                                                          InboxController>(
                                                                    assignId:
                                                                        true,
                                                                    builder:
                                                                        (logic) {
                                                                      return ListView.builder(
                                                                          scrollDirection: Axis.horizontal,
                                                                          itemCount: Get.find<InboxController>().users.length,
                                                                          itemBuilder: (context, pos) {
                                                                            print("*" *
                                                                                100);
                                                                            print(logic.users[pos].value?.split(" ").length);
                                                                            List<String>?
                                                                                a =
                                                                                logic.users[pos].value?.split(" ");
                                                                            if (logic.users[pos].value?.contains(logic.filterWord) ??
                                                                                false) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    Get.find<InboxController>().addTousersWillSendTo(user: logic.users[pos]);
                                                                                    Get.find<InboxController>().SetMultipleReplyWithVoiceNoteRequestModel(correspondencesId: logic.allCorrespondences[pos].correspondenceId!, transferId: logic.allCorrespondences[pos].transferId!, id: logic.users[pos].id!);
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                                                                                    ),
                                                                                    padding: EdgeInsets.all(2.0),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                            color: Theme.of(context).colorScheme.primary,
                                                                                          ),
                                                                                          child: Center(child: FittedBox(child: Text("${a?[0][0]} ${a?[0][0] ?? ""}"))),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(top: 2.0, bottom: 2, right: 8, left: 8),
                                                                                          child: Text(
                                                                                            logic.users[pos].value ?? "",
                                                                                            maxLines: 3,
                                                                                            softWrap: true,
                                                                                          ),
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
                                                                ],
                                                              )),
                                                          const Divider(
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .8,
                                                              height: 300,
                                                              child: GetBuilder<
                                                                  InboxController>(
                                                                builder:
                                                                    (logic) {
                                                                  return ListView
                                                                      .builder(
                                                                          scrollDirection: Axis
                                                                              .vertical,
                                                                          itemCount: Get.find<InboxController>()
                                                                              .usersWillSendTo
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, pos) {
                                                                            return //Text(controller.filterWord);

                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Container(
                                                                                color: Colors.grey[200],
                                                                                child: Column(children: [
                                                                                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Text(logic.usersWillSendTo[pos].value ?? ""),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 8,
                                                                                    ),
                                                                                    Text(
                                                                                      "الاسم",
                                                                                      style: Theme.of(context).textTheme.headline3!.copyWith(
                                                                                            color: createMaterialColor(
                                                                                              const Color.fromRGBO(77, 77, 77, 1),
                                                                                            ),
                                                                                            fontSize: 15,
                                                                                          ),
                                                                                      textAlign: TextAlign.center,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    ),
                                                                                    Spacer(),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        Get.find<InboxController>().delTousersWillSendTo(user: logic.usersWillSendTo[pos]);

                                                                                        Get.find<InboxController>().deltransfarForMany(id: logic.users[pos].id!);
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
                                                                                          child: DropdownButton<CustomActions>(
                                                                                            alignment: Alignment.topRight,
                                                                                            value: Get.find<InboxController>().getactions(logic.usersWillSendTo[pos].id),
                                                                                            icon: const Icon(Icons.arrow_downward),
                                                                                            elevation: 16,
                                                                                            style: const TextStyle(color: Colors.deepPurple),
                                                                                            underline: Container(
                                                                                              height: 2,
                                                                                              color: Colors.deepPurpleAccent,
                                                                                            ),
                                                                                            hint: Text("اختار"),
                                                                                            onChanged: (CustomActions? newValue) {
                                                                                              logic.setactions(logic.usersWillSendTo[pos].id, newValue!);
                                                                                            },
                                                                                            items: Get.find<InboxController>().customActions?.map<DropdownMenuItem<CustomActions>>((CustomActions value) {
                                                                                              return DropdownMenuItem<CustomActions>(
                                                                                                value: value,
                                                                                                child: Text(value.name!),
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
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                GestureDetector(
                                                                                                  onTap: () async {
                                                                                                    Get.find<InboxController>().recording ? Get.find<InboxController>().stop2() : Get.find<InboxController>().record2();

                                                                                                    //            Get.find<InboxController>().recording ? Get.find<InboxController>().stopMathod2(id: logic.usersWillSendTo[pos].id!) : Get.find<InboxController>().recordForMany();
                                                                                                  },
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: GetBuilder<DocumentController>(builder: (logic) {
                                                                                                      return Icon(Get.find<InboxController>().recording ? Icons.stop : Icons.mic);
                                                                                                    }),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      Get.find<InboxController>().playRec();
                                                                                                    },
                                                                                                    child: Icon(Icons.play_arrow),
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
                                                                                        Get.find<InboxController>().setNots(id: logic.users[pos].id!, not: v);
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
                                                        Get.find<
                                                                InboxController>()
                                                            .transfarForMany
                                                            .forEach(
                                                                (key, value) {
                                                          print(
                                                              "$key      ${value.toMap()}");
                                                        });
                                                      },
                                                      child: Text("Ok"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        } else if (v == 3) {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text(" "),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .8,
                                                  color: Colors.grey[200],
                                                  child: SingleChildScrollView(
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
                                                TextButton(
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
                                                        'Token=${Get.find<InboxController>().secureStorage.token()}&correspondenceId=${logic.getBasketInboxModel!.correspondences![pos].correspondenceId}&transferId=${logic.getBasketInboxModel!.correspondences![pos].transferId}&actionType=${Get.find<InboxController>().completeCustomActions?.name ?? ""}&note=${Get.find<InboxController>().completeNote}&language=${Get.locale?.languageCode == "en" ? "en" : "ar"}';

                                                    Get.find<InboxController>()
                                                        .completeInCorrespondence(
                                                            context: context,
                                                            data: data);

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

                                          print("ppp" * 10);
                                          print(Get.find<InboxController>()
                                              .customAction
                                              ?.name);
                                        } else if (v == 4) {}
                                      }),
                            ],
                          )),
                    ),
                  );
                } else {
                  return logic.haveMoreData
                      ? const SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox();
                }
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  logic.getBasketInboxModel!.correspondences!.length + 1);
    });
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({required Key key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
