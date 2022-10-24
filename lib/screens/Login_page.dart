import 'package:cts/data/SettingsFields.dart';
import 'package:cts/utility/Extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/main_controller.dart';
import '../db/cts_database.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image_button.dart';
import '../widgets/custom_input_text_filed.dart';

class LoginPage extends GetWidget<LoginController> {
  // create some values
  Color pickerColor = Color.fromARGB(255, 72, 113, 136);
  Color currentColor = Color.fromARGB(255, 72, 113, 136);

  @override
  Widget build(BuildContext context) {
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Image.asset(
                              'assets/images/logo-new.png',
                              height: 130,

                              //
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
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
                        ],
                      ),
                    ),
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
        onTap: () => {FocusScope.of(context).requestFocus(FocusNode())},
      );
    }

    return SafeArea(
      child: Scaffold(
        body: orientation == Orientation.portrait
            ? Container(
                child: Column(
                  children: [
                    Expanded(child: logForm(context)),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                "assets/images/login_background.png",
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            : landscapeBody(context),
        floatingActionButton: showFab
            ? Row(
                textDirection: TextDirection.rtl,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            getSavedBaseUrlFormDatabase();
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
                                                      color:
                                                          Colors.grey.shade300,
                                                      // color: Colors.grey.shade200,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(6),
                                                      ),
                                                    ),
                                                    width: double.infinity,
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child:
                                                                CustomInputTextFiled(
                                                              validator: controller
                                                                  .validators
                                                                  .userNameValidator,
                                                              textEditingController:
                                                                  controller
                                                                      .baseUrl,
                                                              label:
                                                                  "Base Url".tr,
                                                            ),
                                                          ),
                                                          new TextButton(
                                                              onPressed: () {
                                                                controller
                                                                    .clear();
                                                              },
                                                              child: new Icon(
                                                                  Icons.clear))
                                                        ]))
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

                                                        Get.updateLocale(
                                                            locale);
                                                      },
                                                      child: Text(
                                                        "العربية",
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
                                                        "English",
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
                                          ]),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              controller.secureStorage
                                                  .writeSecureData(
                                                      AllStringConst.BaseUrl,
                                                      controller.baseUrl.text);

                                              // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                                              // final SharedPreferences prefs = await _prefs;
                                              // prefs.setString(AllStringConst.BaseUrl, controller.baseUrl.text);

                                              final settings = SettingItem(
                                                  baseUrl:
                                                      controller.baseUrl.text,
                                                  language: "ar",
                                                  color: "");
                                              await saveSettingsIntoDatabase(
                                                  settings);

                                              // Restart.restartApp();
                                              // Phoenix.rebirth(context);
                                              Navigator.of(context).pop();
                                              // RestartWidget.restartApp(
                                              //     context);
                                            },
                                            child: Text(
                                              "save".tr,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            ),
                                          ),
                                        ]));
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
                          ),
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
                        heroTag: "btn1",
                        onPressed: () async {
                          await selectAppColor(context, size);
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

  selectAppColor(BuildContext context, Size size) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("selectAppColor".tr, style: TextStyle(fontSize: 20)),
        content: Container(
            height: size.height / 2,
            width: size.width / 1.5,
            child: Column(children: [
              buildColorPicker(),
            ])),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              controller.secureStorage.writeSecureData(AllStringConst.AppColor,
                  Get.find<MController>().appcolor.value);
              final settingObj = SettingItem(
                  baseUrl: controller.baseUrl.text,
                  language: "ar",
                  color: pickerColor.toHex());
              List<SettingItem> settingItems =
                  await CtsSettingsDatabase.instance.readAllNotes();
              if (settingItems.isEmpty) {
                await CtsSettingsDatabase.instance.create(settingObj);
              } else {
                var settingItem = settingItems[0];
                settingItem = settingItem.copy(
                  color: settingObj.color,
                );
                await CtsSettingsDatabase.instance.update(settingItem);
              }
              Navigator.of(context).pop();
            },
            child: Text(
              "save".tr,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveSettingsIntoDatabase(SettingItem settingObj) async {
    List<SettingItem> settingItems =
        await CtsSettingsDatabase.instance.readAllNotes();
    if (settingItems.isEmpty) {
      await CtsSettingsDatabase.instance.create(settingObj);
    } else {
      var settingItem = settingItems[0];
      settingItem = settingItem.copy(
        baseUrl: settingObj.baseUrl,
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
                        padding: orientation == Orientation.landscape
                            ? EdgeInsets.only(
                                right: 60, left: 60, top: 10, bottom: 10)
                            : EdgeInsets.only(right: 20, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            orientation == Orientation.landscape
                                ? SizedBox(
                                    height: 30,
                                  )
                                : SizedBox(
                                    height: 10,
                                  ),
                            SizedBox(
                              width: size.width * .6,
                              child: CustomInputTextFiled(
                                  validator:
                                      controller.validators.userNameValidator,
                                  textEditingController: controller.userName,
                                  label: "name".tr),
                            ),
                            orientation == Orientation.landscape
                                ? SizedBox(
                                    height: 10,
                                  )
                                : SizedBox(
                                    height: 8,
                                  ),
                            SizedBox(
                              width: size.width * .6,
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
                                      top: 15.0, left: 0, right: 0)
                                  : EdgeInsets.only(
                                      top: 25.0, left: 0, right: 0),
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
                                    SizedBox(
                                      width:
                                          orientation == Orientation.landscape
                                              ? size.width * .248
                                              : size.width * .51,
                                      child: CustomButton(
                                          onPressed: controller.logIngRequst,
                                          name: "login".tr),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                        width: 50,
                                        height: 50,
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
    List<SettingItem> settingItems =
        await CtsSettingsDatabase.instance.readAllNotes();
    if (settingItems.isNotEmpty) {
      controller.baseUrl.text = settingItems[0].baseUrl;
    } else {}
  }
}
