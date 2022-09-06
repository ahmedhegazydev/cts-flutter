import 'package:cts/data/SettingsFields.dart';
import 'package:cts/utility/Extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../controllers/main_controller.dart';
import '../db/cts_database.dart';
import '../main.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/device_size.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image_button.dart';
import '../widgets/custom_input_text_filed.dart';
import 'package:restart_app/restart_app.dart';

class LoginPage extends GetWidget<LoginController> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    print("Orientation    =>${Orientation.landscape == true}");
    print("Orientation    =>${Orientation.portrait == true}");

    controller.context = context;

    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    landscapeBody(BuildContext context) {
      return GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                returnImageNameBasedOnDirection(
                    "assets/images/background", context, "png"),
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: logForm(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => {
        FocusScope.of(context).requestFocus(FocusNode())
      },
      );
    }

    return SafeArea(
      child: Scaffold(
        body:
//|| DeviceSize.isTablet(context)
//                DeviceSize.isPortrait(context) ==
//                    Orientation.portrait
            //
            orientation == Orientation.portrait
                ? Container(
                    child: Column(
                      children: [
                        Expanded(child: logForm(context)),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                  "assets/images/login_background.png"
                                  // returnImageNameBasedOnDirection(
                                  //     "assets/images/background", context, "png"

                                  //),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : landscapeBody(context),
        floatingActionButton: showFab
            ? Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // verticalDirection: VerticalDirection.up,
          // textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.rtl,
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(),
            Align(
              // alignment: Get.locale=="en" ?  Alignment.bottomRight : Alignment.bottomLeft,
              // alignment:  Alignment.bottomRight,
              alignment : Alignment.bottomLeft,
              child: Row(
                children: [
                  // SizedBox(
                  //   // width:  Get.locale=="en"? 0 : 110,
                  //   width: 110,
                  //   // width:  0,
                  // ) ,
                  FloatingActionButton(
                      onPressed: () {

                        getSavedBaseUrlFormDatabase();

                        // String? link =           controller.secureStorage.readSecureData(   AllStringConst.BaseUrl)??"";
                        // controller.baseUrl.text=link;
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Settings".tr),
                              content: SingleChildScrollView(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8,
                                        right: 0,
                                        left: 0),
                                    child: Column(children: [

                                    Container(
                                    decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                      // color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                  width: double.infinity,
                                      child:  Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(child:   CustomInputTextFiled(
                                              validator: controller
                                                  .validators
                                                  .userNameValidator,
                                              textEditingController: controller.baseUrl,
                                              label: "Base Url".tr,

                                            ),

                                            ),

                                            new FlatButton(
                                                onPressed: () {
                                                  controller.clear();
                                                },
                                                child: new Icon(Icons.clear))
                                          ]
                                      )
                                    )
                                    ]),
                                  ),
                                  // SizedBox(
                                  //   height: 100,
                                  // ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 30,
                                                  right: 0,
                                                  left: 0),
                                              child: Row(children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0),
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    6))),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        var locale =
                                                            const Locale(
                                                                'ar', 'AR');
                                                        SecureStorage
                                                            secureStorage =
                                                            SecureStorage();

                                                        secureStorage
                                                            .writeSecureData(
                                                                AllStringConst
                                                                    .AppLan,
                                                                "ar");

                                                        // final settings = SettingItem(
                                                        //   baseUrl: controller.baseUrl.text,
                                                        //   language: "ar",
                                                        // );
                                                        // await saveSettingsIntoDatabase(settings);

                                                        Get.updateLocale(
                                                            locale);
                                                      },
                                                      child: Text(
                                                        "عربي",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0),
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    6))),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        SecureStorage
                                                            secureStorage =
                                                            SecureStorage();
                                                        var locale =
                                                            const Locale(
                                                                'en', 'US');
                                                        secureStorage
                                                            .writeSecureData(
                                                                AllStringConst
                                                                    .AppLan,
                                                                "en");

                                                        // final settings = SettingItem(
                                                        //   baseUrl: controller.baseUrl.text,
                                                        //   language: "en",
                                                        // );
                                                        // await saveSettingsIntoDatabase(settings);

                                                        Get.updateLocale(
                                                            locale);
                                                      },
                                                      child: Text(
                                                        "En",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ),

                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .7,
                                              padding: const EdgeInsets.only(
                                                  left: 0,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6))),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  controller.secureStorage
                                                      .writeSecureData(
                                                          AllStringConst
                                                              .BaseUrl,
                                                          controller
                                                              .baseUrl.text);

                                                  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                                                  // final SharedPreferences prefs = await _prefs;
                                                  // prefs.setString(AllStringConst.BaseUrl, controller.baseUrl.text);

                                                  final settings = SettingItem(
                                                    baseUrl: controller.baseUrl.text,
                                                    language: "ar",
                                                    color: ""
                                                  );
                                        await saveSettingsIntoDatabase(settings);

                                                  // Restart.restartApp();
                                                  // Phoenix.rebirth(context);
                                                  Navigator.of(context).pop();
                                                  // RestartWidget.restartApp(
                                                  //     context);
                                                },
                                                child: Text(
                                                  "Save Settings".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                          color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ));
                            },
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            )
                            // Image(
                            //   image: AssetImage(
                            //     'assets/images/palette.png',
                            //   ),
                            //   fit: BoxFit.contain,
                            //   width: 25,
                            //   height: 25,
                            // ),
                            )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("pick your Color".tr),
                                    content: Column(children: [
                                      buildColorPicker(),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .7,
                                        padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0),
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(6))),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            controller.secureStorage
                                                .writeSecureData(
                                                    AllStringConst.AppColor,
                                                    Get.find<MController>()
                                                        .appcolor
                                                        .value);

                                            final settingObj = SettingItem(
                                                baseUrl: controller.baseUrl.text,
                                                language: "ar",
                                                color: pickerColor.toHex()
                                            );
                                            List<SettingItem> settingItems = await CtsSettingsDatabase.instance.readAllNotes();
                                            if(settingItems.isEmpty){
                                              // final settings = SettingItem(
                                              //   baseUrl: controller.baseUrl.text,
                                              //   language: controller.baseUrl.text,
                                              // );
                                              await CtsSettingsDatabase.instance.create(settingObj);

                                            }else{
                                              var settingItem = settingItems[0];
                                              settingItem = settingItem.copy(
                                                // baseUrl:  settingObj.baseUrl,
                                                // language: settingObj.language,
                                                color: settingObj.color,
                                              );
                                              await CtsSettingsDatabase.instance.update(settingItem);
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "save".tr,
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
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        child: Image(
                          image: AssetImage(
                            'assets/images/palette.png',
                          ),
                          fit: BoxFit.contain,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  Future<void> saveSettingsIntoDatabase(SettingItem settingObj) async {
    List<SettingItem> settingItems = await CtsSettingsDatabase.instance.readAllNotes();
    if(settingItems.isEmpty){
      // final settings = SettingItem(
      //   baseUrl: controller.baseUrl.text,
      //   language: controller.baseUrl.text,
      // );
      await CtsSettingsDatabase.instance.create(settingObj);

    }else{
      var settingItem = settingItems[0];
      settingItem = settingItem.copy(
        baseUrl:  settingObj.baseUrl,
      language: settingObj.language,
      color: settingObj.color,
      );
      await CtsSettingsDatabase.instance.update(settingItem);
    }
  }

  Widget logForm(BuildContext context1) {
    Orientation orientation = MediaQuery.of(context1).orientation;
    Size size = MediaQuery.of(context1).size;
    return Form(
        key: controller.loginFormKey,
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Spacer(),
                    Padding(
                        padding:  orientation == Orientation.landscape? EdgeInsets.only(right: 60, left: 60): EdgeInsets.only(right: 20, left: 20),

                        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 30,),
                            Container(
                              // color: Colors.red,
                            //  width: double.infinity,
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "appTitle".tr,
                                // textAlign: TextAlign.center,
                                textDirection: Get.locale?.languageCode == "en"
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(),
                              ),
                            ),
                            orientation == Orientation.landscape
                                ? SizedBox(
                                    height: 60,
                                  )
                                : SizedBox(
                                    height: 10,
                                  ),
                            SizedBox(width: size.width*.6,
                              child: CustomInputTextFiled(
                                  validator:
                                      controller.validators.userNameValidator,
                                  textEditingController: controller.userName,
                                  label: "name".tr),
                            ),
                            orientation == Orientation.landscape
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(
                                    height: 8,
                                  ),
                            SizedBox(width:     size.width*.6 ,
                              child: CustomInputTextFiled(
                                  validator:
                                      controller.validators.passWordValidator,
                                  textEditingController: controller.passWord,
                                  obscureText: true,
                                  label: "password".tr),
                            ),
                            Padding(
                              padding: orientation == Orientation.landscape
                                  ? EdgeInsets.only(
                                      top: 25.0, left: 0, right: 0)
                                  : EdgeInsets.only(
                                      top: 15.0, left: 0, right: 0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                color: Colors.transparent,
                                child: Row(
                                  // mainAxisAlignment:
                                  //     Get.locale?.languageCode == "en"
                                  //         ? MainAxisAlignment.end
                                  //         : MainAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [

                                    SizedBox(width: orientation == Orientation.landscape? size.width*.2:size.width*.4,
                                      child: CustomButton(
                                          onPressed: controller.logIngRequst,
                                          name: "login".tr),
                                    ),
                                   SizedBox(width: 8,),
                                    SizedBox(
                                         width: 50,height: 50,
                                        child: CustomImageButton(
                                          imagePath: 'assets/images/faceid.png',
                                          onClick:
                                              controller.faceIdButtonOnClick,
                                        )),
                             ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    Spacer(),
                    orientation == Orientation.landscape
                        ? Container(
                            height: 35,
                            child: Text(
                              "copyrights".tr + getCurrentYearString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: Colors.grey),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: pickerColor,
      onColorChanged: (Color color) async {
        Get.find<MController>().setAppColor(color);
        Get.find<MController>().setChangeColorImmediately(false);
        print(color);
        pickerColor = color;
      },
    );
  }

  void getSavedBaseUrlFormDatabase() async {
    List<SettingItem> settingItems = await CtsSettingsDatabase.instance.readAllNotes();
    if(settingItems.isNotEmpty){
      controller.baseUrl.text = settingItems[0].baseUrl;
    }else{
    }
  }

}
