import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/web_view_controller.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/device_size.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_inboxes_row.dart';
import '../widgets/custom_landing_row.dart';
import '../widgets/landing_head_item.dart';

class LandingPage extends GetWidget<LandingPageController> {
  SecureStorage secureStorage = Get.find<SecureStorage>();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    print("the Token Is => ${secureStorage.readSecureData(AllStringConst.Token)}");
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: orientation == Orientation.landscape
            ? landscapeBody(context)
            : portraitBody(context),
      ),
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
              Flexible(
                flex: 1,
                child: FractionallySizedBox(
                  heightFactor: 0.88,
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: portiraitDashboardContainer(context),
                  ),
                ),
              ),
              Flexible(
                flex: DeviceSize.isMobile(context) == true ? 3 : 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 44),
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
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 5),
          child: Align(
            alignment: appLocale == "ar"
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: Image.asset(
              "assets/images/arrow_right.png",
              width: 200,
            ),
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
          Container(
            width: 120,
            height: double.infinity,
            color: Colors.grey.shade300,
            child: _buildSideMenu(context),
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    returnImageNameBasedOnDirection(
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

  portiraitDashboardContainer(BuildContext contex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(
          flex: 2,
        ),
        Flexible(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  child: Text(
                    "appTitle".tr,
                    style: Theme.of(contex).textTheme.headline1!.copyWith(
                          fontSize: calculateFontSize(60, contex),
                        ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Text(
                      "hello".tr +
                          "  ${secureStorage.readSecureData(AllStringConst.FirstName)} ${secureStorage.readSecureData(AllStringConst.LastName)}",
                      style: Theme.of(contex).textTheme.headline2!.copyWith(
                            color: Colors.grey,
                            fontSize: calculateFontSize(40, contex),
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 9,
          child: portiraitDashboard(contex),
        ),
      ],
    );
  }

  _buildSideMenu(BuildContext context) {
  return   ListView(children: [
    InkWell(onTap: (){
      print("999999999999");
      Get.toNamed("SignaturePage");
    },
    child: Container(
      height: calculateWidth(120, context),
      color: Colors.transparent,
      child: Column(
        //    mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(
            flex: 1,
          ),
          Flexible(
            flex: 3,
            child: Image(
              image: AssetImage(
                'assets/images/signature.png',
              ),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
      onTap: () {
        // Get.bottomSheet(
        //   Container(
        //     //height: 100,
        //       margin: EdgeInsets.all(20),
        //       padding: EdgeInsets.all(20),
        //       decoration: const BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //               topRight: Radius.circular(20))),
        //       child: ListView.builder(
        //           itemCount: //11
        //           controller.findRecipientModel?.sections?[0]
        //               .destination?.length,
        //           itemBuilder: (context, pos) {
        //             return Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Card(elevation: 5,
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Text(controller.findRecipientModel
        //                       ?.sections?[0].destination?[pos]?.value ??
        //                       ""),
        //                 ),
        //               ),
        //             );
        //           })),
        //   enterBottomSheetDuration: const Duration(seconds: 1),
        // );
      },
      child: Container(
        height: 140,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 3,
              child: Image(
                image: AssetImage(
                  'assets/images/fav_users.png',
                ),
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Flexible(
              flex: 2,
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
       InkWell(onTap: (){
         // Get.bottomSheet(
         //   Container(
         //     //height: 100,
         //       margin: EdgeInsets.all(20),
         //       padding: EdgeInsets.all(20),
         //       decoration: const BoxDecoration(
         //           color: Colors.white,
         //           borderRadius: BorderRadius.only(
         //               topLeft: Radius.circular(20),
         //               topRight: Radius.circular(20))),
         //       child: ListView.builder(
         //           itemCount: //11
         //           controller.findRecipientModel?.sections?[0]
         //               .destination?.length,
         //           itemBuilder: (context, pos) {
         //             return Padding(
         //               padding: const EdgeInsets.all(8.0),
         //               child: Card(elevation: 5,
         //                 child: Padding(
         //                   padding: const EdgeInsets.all(8.0),
         //                   child: Text(controller.findRecipientModel
         //                       ?.sections?[2].destination?[pos]?.value ??
         //                       ""),
         //                 ),
         //               ),
         //             );
         //           })),
         //   enterBottomSheetDuration: const Duration(seconds: 1),
         // );
       },
         child: Container(
           height: 120,
           color: Colors.transparent,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Spacer(
                 flex: 1,
               ),
               Flexible(
                 flex: 3,
                 child: Image(
                   image: AssetImage(
                     'assets/images/delegation.png',
                   ),
                   fit: BoxFit.contain,
                   width: double.infinity,
                   height: double.infinity,
                 ),
               ),
               Flexible(
                 flex: 1,
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

    InkWell(onTap: ()async{
      await    Get.find<InboxController>().getFetchBasketList();
      showDialog(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text(" "),
              content: Padding(
                padding:
                const EdgeInsets
                    .all(8.0),
                child: Container(
                    width: MediaQuery.of(
                        context)
                        .size
                        .width *
                        .3,
                    color: Colors
                        .grey[200],
                    child: ListView.builder(
                        itemCount: Get.find<
                            InboxController>()
                            .fetchBasketListModel
                            ?.baskets
                            ?.length,
                        itemBuilder:
                            (context,
                            pos) {
                          return InkWell(onTap: ()async{

print("${Get.find<InboxController>()
    .fetchBasketListModel
    ?.baskets?[pos].iD}");

Get.find<BasketController>().getBasketInbox(id:Get.find<InboxController>()
    .fetchBasketListModel
   !.baskets![pos].iD! ,pageSize:20 ,pageNumber: 0);

Get.back();


                             Get.toNamed("MyPocketsScreen");

                          },
                            child: Card(elevation: 10,child: Column(children: [
                              Text( Get.find<InboxController>()
                                  .fetchBasketListModel
                                  ?.baskets?[pos].name??""),
                              Text( Get.find<InboxController>()
                                  .fetchBasketListModel
                                  ?.baskets?[pos].nameAr??""),
                              // Text( "color :${Get.find<InboxController>()
                              //     .fetchBasketListModel
                              //     ?.baskets?[pos].color}",style: TextStyle( color: HexColor(Get.find<InboxController>()
                              //     .fetchBasketListModel
                              //     ?.baskets?[pos].color??"#000000"))),



                            ]),),
                          );
                        })),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed:
                      () async {

                    /// ToDo send Replay

                    Navigator.of(
                        ctx)
                        .pop();
                  },
                  child: Text("Ok"),
                ),
              ],
            ),
      );
     // Get.toNamed( "MyPocketsScreen",);//MyPocketsScreen
    },
      child: Container(
        height: 120,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 3,
              child: Image(
                image: AssetImage(
                  'assets/images/delegation.png',
                ),
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Flexible(
              flex: 1,
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
       InkWell(onTap: (){
         ///ToDo
         ///open url and go to userGuideUrl
       //  controller.data.userGuideUrl

Get.find<WebViewPageController>().url=controller.data?.userGuideUrl;
         Get.toNamed( "WebViewPage",);
       },
         child: Container(
           height: 120,
           color: Colors.transparent,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Spacer(
                 flex: 1,
               ),
               Flexible(
                 flex: 3,
                 child: Image(
                   image: AssetImage(
                     'assets/images/delegation.png',
                   ),
                   fit: BoxFit.contain,
                   width: double.infinity,
                   height: double.infinity,
                 ),
               ),
               Flexible(
                 flex: 1,
                 child: Text(
                   "user Guide".tr,
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

       Container(
         height: 120,
         color: Colors.transparent,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.max,
           children: [
             Spacer(
               flex: 1,
             ),
             Flexible(
               flex: 3,
               child: Image(
                 image: AssetImage(
                   'assets/images/palette_dark.png',
                 ),
                 fit: BoxFit.contain,
                 width: double.infinity,
                 height: double.infinity,
               ),
             ),
             Flexible(
               flex: 1,
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
       InkWell(
         onTap: () {



           /// ToDo
           /// delet token and go to login

           //   Globals.navigatorKey.currentState?.pushNamed(LoginPageRoute);
         },
         child: Container(
           height: 120,
           color: Colors.transparent,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Spacer(
                 flex: 1,
               ),
               Flexible(
                 flex: 3,
                 child: Image(
                   image: AssetImage(
                     'assets/images/logout.png',
                   ),
                   fit: BoxFit.contain,
                   width: double.infinity,
                   height: double.infinity,
                 ),
               ),
               Flexible(
                 flex: 1,
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
       )
],);
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.max,
    //   children: [
    //     Flexible(
    //       flex: 1,
    //       child:
    //
    //       Container(
    //         height: calculateWidth(120, context),
    //         color: Colors.transparent,
    //         child: Column(
    //           //    mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Spacer(
    //               flex: 1,
    //             ),
    //             Flexible(
    //               flex: 3,
    //               child: Image(
    //                 image: AssetImage(
    //                   'assets/images/signature.png',
    //                 ),
    //                 fit: BoxFit.contain,
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text(
    //                 "mySignatures".tr,
    //                 textAlign: TextAlign.center,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(color: Colors.grey.shade600),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //
    //
    //
    //
    //
    //     InkWell(
    //       onTap: () {
    //         Get.bottomSheet(
    //           Container(
    //               //height: 100,
    //               margin: EdgeInsets.all(20),
    //               padding: EdgeInsets.all(20),
    //               decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(20),
    //                       topRight: Radius.circular(20))),
    //               child: ListView.builder(
    //                   itemCount: //11
    //                       controller.findRecipientModel?.sections?[0]
    //                           .destination?.length,
    //                   itemBuilder: (context, pos) {
    //                     return Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Card(elevation: 5,
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(8.0),
    //                           child: Text(controller.findRecipientModel
    //                                   ?.sections?[0].destination?[pos]?.value ??
    //                               ""),
    //                         ),
    //                       ),
    //                     );
    //                   })),
    //           enterBottomSheetDuration: const Duration(seconds: 1),
    //         );
    //       },
    //       child: Container(
    //         height: 140,
    //         color: Colors.transparent,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Spacer(
    //               flex: 1,
    //             ),
    //             Flexible(
    //               flex: 3,
    //               child: Image(
    //                 image: AssetImage(
    //                   'assets/images/fav_users.png',
    //                 ),
    //                 fit: BoxFit.contain,
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Flexible(
    //               flex: 2,
    //               child: Text(
    //                 "favoritesUsers".tr,
    //                 textAlign: TextAlign.center,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(color: Colors.grey.shade600),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     InkWell(onTap: (){
    //       Get.bottomSheet(
    //         Container(
    //           //height: 100,
    //             margin: EdgeInsets.all(20),
    //             padding: EdgeInsets.all(20),
    //             decoration: const BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(20),
    //                     topRight: Radius.circular(20))),
    //             child: ListView.builder(
    //                 itemCount: //11
    //                 controller.findRecipientModel?.sections?[0]
    //                     .destination?.length,
    //                 itemBuilder: (context, pos) {
    //                   return Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Card(elevation: 5,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Text(controller.findRecipientModel
    //                             ?.sections?[2].destination?[pos]?.value ??
    //                             ""),
    //                       ),
    //                     ),
    //                   );
    //                 })),
    //         enterBottomSheetDuration: const Duration(seconds: 1),
    //       );
    //     },
    //       child: Container(
    //         height: 120,
    //         color: Colors.transparent,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Spacer(
    //               flex: 1,
    //             ),
    //             Flexible(
    //               flex: 3,
    //               child: Image(
    //                 image: AssetImage(
    //                   'assets/images/delegation.png',
    //                 ),
    //                 fit: BoxFit.contain,
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Text(
    //                 "myDelegations".tr,
    //                 textAlign: TextAlign.center,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(color: Colors.grey.shade600),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //
    //     InkWell(onTap: (){
    //       Get.bottomSheet(
    //         Container(
    //           //height: 100,
    //             margin: EdgeInsets.all(20),
    //             padding: EdgeInsets.all(20),
    //             decoration: const BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(20),
    //                     topRight: Radius.circular(20))),
    //             child:Text(  controller.data?.termsAndConditions??"")),
    //         enterBottomSheetDuration: const Duration(seconds: 1),
    //       );
    //     },
    //       child: Container(
    //         height: 120,
    //         color: Colors.transparent,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Spacer(
    //               flex: 1,
    //             ),
    //             Flexible(
    //               flex: 3,
    //               child: Image(
    //                 image: AssetImage(
    //                   'assets/images/delegation.png',
    //                 ),
    //                 fit: BoxFit.contain,
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Text(
    //                 "termsAndConditions".tr,
    //                 textAlign: TextAlign.center,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(color: Colors.grey.shade600),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     InkWell(onTap: (){
    //     ///ToDo
    //       ///open url and go to userGuideUrl
    //     },
    //       child: Container(
    //         height: 120,
    //         color: Colors.transparent,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Spacer(
    //               flex: 1,
    //             ),
    //             Flexible(
    //               flex: 3,
    //               child: Image(
    //                 image: AssetImage(
    //                   'assets/images/delegation.png',
    //                 ),
    //                 fit: BoxFit.contain,
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Text(
    //                 "user Guide".tr,
    //                 textAlign: TextAlign.center,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(color: Colors.grey.shade600),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //
    //
    //     Container(
    //       height: 120,
    //       color: Colors.transparent,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           Spacer(
    //             flex: 1,
    //           ),
    //           Flexible(
    //             flex: 3,
    //             child: Image(
    //               image: AssetImage(
    //                 'assets/images/palette_dark.png',
    //               ),
    //               fit: BoxFit.contain,
    //               width: double.infinity,
    //               height: double.infinity,
    //             ),
    //           ),
    //           Flexible(
    //             flex: 1,
    //             child: Text(
    //               "appTheme".tr,
    //               textAlign: TextAlign.center,
    //               style: Theme.of(context)
    //                   .textTheme
    //                   .headline3!
    //                   .copyWith(color: Colors.grey.shade600),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     InkWell(
    //       onTap: () {
    //
    //
    //
    //         /// ToDo
    //         /// delet token and go to login
    //
    //         //   Globals.navigatorKey.currentState?.pushNamed(LoginPageRoute);
    //       },
    //       child: Container(
    //         height: 120,
    //         color: Colors.transparent,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             Spacer(
    //               flex: 1,
    //             ),
    //             Flexible(
    //               flex: 3,
    //               child: Image(
    //                 image: AssetImage(
    //                   'assets/images/logout.png',
    //                 ),
    //                 fit: BoxFit.contain,
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Flexible(
    //               flex: 1,
    //               child: Text(
    //                 "logout".tr,
    //                 textAlign: TextAlign.center,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .headline3!
    //                     .copyWith(color: Colors.grey.shade600),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }

  landscapeDashboardContainer(BuildContext contex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            color: Colors.transparent,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 60,
                    child: Text(
                      "appTitle".tr,
                      style: Theme.of(contex).textTheme.headline1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 30,
                    child: Text(
                      "hello".tr +
                          "  ${secureStorage.readSecureData(AllStringConst.FirstName)} ${secureStorage.readSecureData(AllStringConst.LastName)}",
                      style: Theme.of(contex)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              ],
            ),
          ),
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
                          returnImageNameBasedOnOppositeDirection(
                              "assets/images/arrow", contex, "png"),
                        ),
                        fit: BoxFit.contain,
                        width: 50,
                        height: double.infinity,
                      ),
                      Text(
                        controller.data?.departmentName ?? "",
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
          Flexible(
            flex: 3,
            child: Container(
              color: Colors.transparent,
              padding:
                  EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
              child: Container(
                // width: double.infinity,
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                                calculateDate("dd", 'en'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        fontSize:
                                            calculateFontSize(65, context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                calculateDate("MMMM", getLocaleCode(context)) +
                                    " " +
                                    calculateDate("yyyy", 'en'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey.shade400,
                                        fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            )
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
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                calculateDate("hh:mm", 'en'),
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
                                " " + calculateDate("a", 'en'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.grey.shade400,
                                        fontSize: 24),
                              ),
                            )
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
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                controller.data?.inbox.toString() ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
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
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(

                                    "pendingCorrespondences"
                                //controller.data?.transferData.sections[].destination
                                // controller.data?.transferData.priorities
                                //   controller.data?.transferData.privacies.
                                // controller.data?.transferData.purposes.
                                //  controller.data?.signature

                                ,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
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
              padding:
                  EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    calculateDate(
                                        'MMMM', getLocaleCode(context)),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                "20",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
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
                                "mostMyTransferWentTo".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                "نورا الجيدا",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.transparent,
              padding:
                  EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(flex: 2),
                          const Flexible(
                            flex: 2,
                            child: Image(
                              image: AssetImage(
                                'assets/images/flagged.png',
                              ),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(flex: 1),
                          Flexible(
                            flex: 10,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "flagged".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "5",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontSize: 22,
                                      color: createMaterialColor(
                                        Color.fromRGBO(247, 148, 29, 1),
                                      ),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(flex: 2),
                          const Flexible(
                            flex: 2,
                            child: Image(
                              image: AssetImage(
                                'assets/images/notification.png',
                              ),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(flex: 1),
                          Flexible(
                            flex: 10,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "notifications".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "9",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontSize: 22,
                                      color: createMaterialColor(
                                        Color.fromRGBO(247, 148, 29, 1),
                                      ),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  portiraitDashboard(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      // color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 5,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 10, top: 0, bottom: 0),
                      child: Container(
                        height: 150,
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
                                        fontSize:
                                            calculateFontSize(30, context),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "5",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize:
                                            calculateFontSize(100, context),
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
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 0, top: 0, bottom: 0),
                      child: Container(
                        height: 150,
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
                                            calculateFontSize(30, context),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "19",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize:
                                            calculateFontSize(100, context),
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
                ],
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              color: Colors.transparent,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 10, top: 0, bottom: 0),
                      child: Container(
                        height: 150,
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
                                      calculateDate(
                                          'MMMM', getLocaleCode(context)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(30, context),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "20",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize:
                                            calculateFontSize(100, context),
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
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 0, top: 0, bottom: 0),
                      child: Container(
                        height: 150,
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
                                  "mostMyTransferWentTo".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(38, context),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  "نورا الجيدا",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontSize:
                                            calculateFontSize(47, context),
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
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)
                            // topLeft: Radius.circular(6),
                            // topRight: Radius.circular(6),
                            // bottomLeft: Radius.circular(6),
                            // bottomRight: Radius.circular(6)
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(flex: 2),
                          const Flexible(
                            flex: 2,
                            child: Image(
                              image: AssetImage(
                                'assets/images/flagged.png',
                              ),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(flex: 1),
                          Flexible(
                            flex: 10,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "flagged".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "5",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontSize: 22,
                                      color: createMaterialColor(
                                        Color.fromRGBO(247, 148, 29, 1),
                                      ),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(flex: 2),
                          Flexible(
                            flex: 2,
                            child: Image(
                              image: AssetImage(
                                'assets/images/notification.png',
                              ),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          Spacer(flex: 1),
                          Flexible(
                            flex: 10,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "notifications".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        color: Colors.grey,
                                        fontSize:
                                            calculateFontSize(16, context)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "9",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontSize: 22,
                                      color: createMaterialColor(
                                        Color.fromRGBO(247, 148, 29, 1),
                                      ),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  portiraitDataTable(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: createMaterialColor(Color.fromRGBO(255, 255, 255, 0.8)),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
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
            children: [
              TableRow(
                children: [
                  TableRowInkWell(
                    onTap: () {
                      openInbox();
                    },
                    child: _buildInboxesRow(
                      context,
                      "forAction".tr,
                      5,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableRowInkWell(
                    onTap: () {
                      openInbox();
                    },
                    child: _buildInboxesRow(
                      context,
                      "forSignature".tr,
                      07,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableRowInkWell(
                    onTap: () {
                      openInbox();
                    },
                    child: _buildInboxesRow(
                      context,
                      "forInfo".tr,
                      09,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableRowInkWell(
                    onTap: () {
                      openInbox();
                    },
                    child: _buildInboxesRow(
                      context,
                      "all".tr,
                      2,
                    ),
                  ),
                ],
              ),
            ],
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
                      openInbox();
                    },
                    child: _buildOtherFoldersRows(
                      context,
                      "flagged".tr,
                      "assets/images/flagged.png",
                      true,
                      5,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableRowInkWell(
                    onTap: () {
                      openInbox();
                    },
                    child: _buildOtherFoldersRows(
                      context,
                      "notifications".tr,
                      "assets/images/notification.png",
                      true,
                      9,
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
                    child: _buildOtherFoldersRows(context, "advancedSearch".tr,
                        "assets/images/search.png", false, 0),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  color: Colors.grey[200],
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image(
                          image: AssetImage(
                            returnImageNameBasedOnOppositeDirection(
                                "assets/images/arrow", context, "png"),
                          ),
                        ),
                      ),
                      Text(
                        controller.data?.departmentName ?? "",
                        //        "sharedServicesAdministration".tr,
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
    );
  }

  landscapeDataTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 60,
          right: 60,
          top: calculateHeight(100, context),
          bottom: calculateHeight(80, context)),
      child: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: createMaterialColor(Color.fromRGBO(255, 255, 255, 0.8)),
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
              children: [
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(
                        context,
                        "forAction".tr,
                        5,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(
                        context,
                        "forSignature".tr,
                        07,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(
                        context,
                        "forInfo".tr,
                        09,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(
                        context,
                        "all".tr,
                        2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                        openInbox();
                      },
                      child: _buildOtherFoldersRows(
                        context,
                        "flagged".tr,
                        "assets/images/flagged.png",
                        true,
                        5,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildOtherFoldersRows(
                        context,
                        "notifications".tr,
                        "assets/images/notification.png",
                        true,
                        9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 30,
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
                        openInbox();
                      },
                      child: _buildOtherFoldersRows(
                          context,
                          "advancedSearch".tr,
                          "assets/images/search.png",
                          false,
                          0),
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
      height: calculateHeight(
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
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80, content),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
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
          Spacer(flex: 1),
          Flexible(
            flex: 15,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Text(
                title,
                style: Theme.of(content)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.grey, fontSize: 17),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
            child: Container(
              color: Colors.transparent,
              width: 40,
              child: Text(
                count.toString(),
                style: Theme.of(content)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 17),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Image(
              image: AssetImage(
                returnImageNameBasedOnOppositeDirection(
                    "assets/images/arrow", content, "png"),
              ),
              fit: BoxFit.contain,
              width: 50,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  _buildOtherFoldersRows(BuildContext context, String title, String iconTitle,
      bool showCount, int count) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: orientation == Orientation.landscape ? 20 : 0,
          bottom: 0),
      width: double.infinity,
      height: calculateHeight(
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
                width: 50,
                height: double.infinity,
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
            flex: 15,
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
            child: Visibility(
              visible: showCount,
              child: Container(
                color: Colors.transparent,
                width: 40,
                child: Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 17),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Image(
              image: AssetImage(
                returnImageNameBasedOnOppositeDirection(
                    "assets/images/arrow", context, "png"),
              ),
              fit: BoxFit.contain,
              width: 50,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  openInbox() {
    Get.toNamed("/InboxPage");
    // Navigator.push(
    //   context,
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation1, animation2) => InboxPage(),
    //     transitionDuration: Duration(seconds: 0),
    //   ),
    // );
  }
}

//
// class LandingPage extends GetWidget<LandingPageController> {
//
//   @override
//   Widget build(BuildContext context) {
//
//      Orientation orientation = MediaQuery.of(context).orientation;
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//           body: Scaffold(
//         body: Stack(children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   width: size.width,
//                  height: orientation== Orientation.portrait?size.height * .3:size.height * .4,
//                   color: Colors.grey[300],
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "appTitle".tr,
//                           style: Theme.of(context).textTheme.headline1!.copyWith(
//                                 color: TextColor,
//                               ),
//                         ),
//                         Text(
//                           " hello ".tr + controller.userName(),
//                           style: Theme.of(context).textTheme.headline3!.copyWith(
//                                 color: TextColor,
//                               ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                            // Text(controller.correspondencesModel?.inbox?.correspondences?[0].fromStructure??""),
//                                 LandingHeadItem(
//                                   title: "unreadCorrespondences".tr,
//                                   value: "5",
//                                 ),
//                                 LandingHeadItem(
//                                   title: "pendingCorrespondences".tr,
//                                   value: "19",
//                                 ),
//                                 LandingHeadItem(
//                                   title: "myTransfersInMonth".tr +
//                                       " " +
//                                       calculateDate(
//                                           'MMMM', getLocaleCode(context)),
//                                   value: "20",
//                                 ),
//                                 LandingHeadItem(
//                                   title: "mostMyTransferWentTo".tr,
//                                   value: "controller" ,
//                                 ),
//
//                            Container(padding: const EdgeInsets.only(top: 4,bottom: 4),decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(9)),
//                                   width: MediaQuery.of(context).size.width * .18,
//                                   child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
//
//                                     Expanded(flex: 1,
//                                       child: Container(decoration: BoxDecoration(color: Colors.white,
//                                           borderRadius: BorderRadius.circular(9)),
//
//                                         child:Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//
//                                           children: [
//
//                                             const Image(
//                                               image: AssetImage(
//                                                 'assets/images/flagged.png',
//                                               ),
//                                               fit: BoxFit.contain,
//                                               width:20,
//                                               height: 20,
//                                               color: Colors.grey,
//                                             ),
//
//                                             Text(
//                                                "flagged".tr,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .headline2!
//                                                   .copyWith(
//                                                   color: Colors.grey,
//                                                   fontSize:
//                                                   calculateFontSize(20, context)),
//                                               textAlign: TextAlign.start,
//                                             ),
//                                             Text(
//                                               "5",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .headline3!
//                                                   .copyWith(
//                                                 fontSize: 22,
//                                                 color: createMaterialColor(
//                                                   const Color.fromRGBO(247, 148, 29, 1),
//                                                 ),
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4,),
//                                     Expanded(flex: 1,
//                                       child: Container(
//                                         decoration: BoxDecoration(color: Colors.white,
//                                             borderRadius: BorderRadius.circular(9)),
//                                         child:Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//
//                                           children: [
//
//                                             const Image(
//                                               image: AssetImage(
//                                                 'assets/images/notification.png',
//                                               ),
//                                               fit: BoxFit.contain,
//                                               width:20,
//                                               height: 20,
//                                               color: Colors.grey,
//                                             ),
//
//                                             Text(
//                                               "notifications".tr,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .headline2!
//                                                   .copyWith(
//                                                   color: Colors.grey,
//                                                   fontSize:
//                                                   calculateFontSize(20, context)),
//                                               textAlign: TextAlign.start,
//                                             ),
//                                             Text(
//                                               "5",
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .headline3!
//                                                   .copyWith(
//                                                 fontSize: 22,
//                                                 color: createMaterialColor(
//                                                   Color.fromRGBO(247, 148, 29, 1),
//                                                 ),
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ]),
//                                 )
//
//                               ],
//                             ),
//                           ),
//                         )
//
//
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//                 Table(
//                   border: TableBorder(
//                     horizontalInside: BorderSide(
//                         width: 1,
//                         color: Colors.grey.shade300,
//                         style: BorderStyle.solid),
//                     bottom: BorderSide(
//                         width: 1,
//                         color: Colors.grey.shade300,
//                         style: BorderStyle.solid),
//                   ),
//                   children: [
//                     TableRow(
//                       children: [
//                         TableRowInkWell(
//                           onTap: () {
//                            openInbox();
//                           },
//                           child: CustomInboxesRow(height: orientation== Orientation.portrait?size.height * .1:size.height * .2,
//                          title:
//                            "forAction".tr,
//                         count:     5,
//                           ),
//                         ),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         TableRowInkWell(
//                           onTap: () {
//                            openInbox();
//                           },
//                           child: CustomInboxesRow(count:07,title:  "forSignature".tr,height: orientation== Orientation.portrait?size.height * .1:size.height * .2,
//
//                           ),
//                         ),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         TableRowInkWell(
//                           onTap: () {
//                             openInbox();
//                           },
//                           child: CustomInboxesRow(height: orientation== Orientation.portrait?size.height * .1:size.height * .2,
//                            title:
//                             "forInfo".tr,count:
//                             09,
//                           ),
//                         ),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         TableRowInkWell(
//                           onTap: () {
//                             openInbox();
//                           },
//                           child: CustomInboxesRow(height: orientation== Orientation.portrait?size.height * .1:size.height * .2,
//                       title:
//                             "all".tr,count:
//                             2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 CustomLandingRow(title: "flagged".tr, count: 5,iconTitle:"assets/images/flagged.png" ,showCount: true,height: orientation== Orientation.portrait?size.height * .1:size.height * .2,)
//                , const Divider(thickness: 1,height: 1,)
//               ,  CustomLandingRow(title: "notifications".tr, count: 5,iconTitle:"assets/images/notification.png" ,showCount: true,height: orientation== Orientation.portrait?size.height * .1:size.height * .2,)
//                 , const Divider(thickness: 1,height: 1,)
//               ,  CustomLandingRow(title: "search".tr, count: 0,iconTitle:"assets/images/search.png" ,showCount: false,height: orientation== Orientation.portrait?size.height * .1:size.height * .2,)
//                 , const Divider(thickness: 1,height: 1,)
//
//
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 30, bottom: 5),
//             child: Align(
//               alignment: Alignment.bottomLeft
//
//               ,
//               child: Image.asset(
//                 "assets/images/arrow_right.png",
//                 width:orientation== Orientation.portrait? 200:15,
//               ),
//             ),
//           ),
//         ]),
//       )),
//     );
//   }
//
//   void openInbox() {
//
//
//     Get.toNamed("/InboxPage");
//   }
//
//
//
//   _buildSideMenu(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Flexible(
//           flex: 1,
//           child: Container(
//             height: calculateWidth(120, context),
//             color: Colors.transparent,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Spacer(
//                   flex: 1,
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: Image(
//                     image: AssetImage(
//                       'assets/images/signature.png',
//                     ),
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Text(
//                     "mySignatures",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3!
//                         .copyWith(color: Colors.grey.shade600),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             height: 140,
//             color: Colors.transparent,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Spacer(
//                   flex: 1,
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: Image(
//                     image: AssetImage(
//                       'assets/images/fav_users.png',
//                     ),
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 Flexible(
//                   flex: 2,
//                   child: Text(
//                     "favoritesUsers",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3!
//                         .copyWith(color: Colors.grey.shade600),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             height: 120,
//             color: Colors.transparent,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Spacer(
//                   flex: 1,
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: Image(
//                     image: AssetImage(
//                       'assets/images/delegation.png',
//                     ),
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Text(
//                     "myDelegations",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3!
//                         .copyWith(color: Colors.grey.shade600),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             height: 120,
//             color: Colors.transparent,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Spacer(
//                   flex: 1,
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: Image(
//                     image: AssetImage(
//                       'assets/images/palette_dark.png',
//                     ),
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 Flexible(
//                   flex: 1,
//                   child: Text(
//                     "appTheme",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3!
//                         .copyWith(color: Colors.grey.shade600),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: InkWell(
//             onTap: () {
//               //Globals.navigatorKey.currentState?.pushNamed(LoginPageRoute);
//             },
//             child: Container(
//               height: 120,
//               color: Colors.transparent,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Spacer(
//                     flex: 1,
//                   ),
//                   Flexible(
//                     flex: 3,
//                     child: Image(
//                       image: AssetImage(
//                         'assets/images/logout.png',
//                       ),
//                       fit: BoxFit.contain,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                   Flexible(
//                     flex: 1,
//                     child: Text(
//                       "logout",
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline3!
//                           .copyWith(color: Colors.grey.shade600),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//   // _buildInboxesRow(BuildContext content, String title, int count) {
//   //   return Container(
//   //     padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
//   //     width: double.infinity,
//   //     height: calculateHeight(80, content),
//   //     color: Colors.transparent,
//   //     child: Directionality(textDirection:TextDirection.rtl ,
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         crossAxisAlignment: CrossAxisAlignment.center,
//   //         mainAxisSize: MainAxisSize.max,
//   //         children: [
//   //           Flexible(
//   //             flex: 1,
//   //             child: Container(
//   //               decoration: BoxDecoration(
//   //                 color: Theme.of(content).colorScheme.primary,
//   //                 borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(6),
//   //                   topRight: Radius.circular(6),
//   //                   bottomLeft: Radius.circular(6),
//   //                   bottomRight: Radius.circular(6),
//   //                 ),
//   //               ),
//   //               width: 12,
//   //               height: 12,
//   //             ),
//   //           ),
//   //           Spacer(flex: 1),
//   //           Flexible(
//   //             flex: 15,
//   //             child: Container(
//   //               color: Colors.transparent,
//   //               width: double.infinity,
//   //               child: Text(
//   //                 title,
//   //                 style: Theme.of(content)
//   //                     .textTheme
//   //                     .headline1!
//   //                     .copyWith(color: Colors.grey, fontSize: 17),
//   //                 textAlign: TextAlign.start,
//   //               ),
//   //             ),
//   //           ),
//   //           Spacer(flex: 1),
//   //           Flexible(
//   //             child: Container(
//   //               color: Colors.transparent,
//   //               width: 40,
//   //               child: Text(
//   //                 count.toString(),
//   //                 style: Theme.of(content)
//   //                     .textTheme
//   //                     .headline2!
//   //                     .copyWith(fontSize: 17),
//   //                 textAlign: TextAlign.end,
//   //               ),
//   //             ),
//   //           ),
//   //           Flexible(
//   //             flex: 2,
//   //             child: Image(
//   //               image: AssetImage(
//   //                 returnImageNameBasedOnOppositeDirection(
//   //                     "assets/images/arrow", content, "png"),
//   //               ),
//   //               fit: BoxFit.contain,
//   //               width: 50,
//   //               height: double.infinity,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
