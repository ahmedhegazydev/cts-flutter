import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../controllers/main_controller.dart';
import '../main.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
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
    controller.context = context;
    Size size = MediaQuery.of(context).size;
    // Orientation orientation = MediaQuery.of(context).orientation;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    landscapeBody(BuildContext context) {
      return Container(
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
      );
    }

    return SafeArea(
      child: Scaffold(
        body:

            //    DeviceSize.isPortrait(context) || DeviceSize.isTablet(context)  == Orientation.portrait
            // //
            //        ?
            //
            //    Padding(
            //            padding: const EdgeInsets.all(8.0),
            //            child: LayoutBuilder(builder: (context, constraint) {
            //              return SingleChildScrollView(
            //                child: ConstrainedBox(
            //                  constraints:
            //                      BoxConstraints(minHeight: constraint.maxHeight),
            //                  child: IntrinsicHeight(
            //                    child: Column(
            //                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                        crossAxisAlignment: CrossAxisAlignment.start,
            //                        children: [
            //                          const SizedBox(
            //                            height: 8,
            //                          ),
            //                          logForm(context),
            //                          const SizedBox(
            //                            height: 20,
            //                          ),
            //                          Row(
            //                            children: [
            //                              Align(
            //                                alignment: FractionalOffset.topRight,
            //                                child: Image.asset(
            //                                  "assets/images/login_background.png",
            //                                  height: size.height * .2,
            //                                  width: size.width * .4,
            //                                ),
            //                              ),
            //                              Padding(
            //                                padding: const EdgeInsets.only(
            //                                    bottom: 20, left: 20, top: 20),
            //                                child: Align(
            //                                  alignment: FractionalOffset.bottomLeft,
            //                                  child: Image.asset(
            //                                    "assets/images/arrow_right.png",
            //                                    height: size.height * .2,
            //                                    width: size.width * .4,
            //                                  ),
            //                                ),
            //                              ),
            //                            ],
            //                          ),
            //                          const Expanded(child: SizedBox()),
            //                          //  const Spacer(),
            //                          Center(
            //                            child: Padding(
            //                              padding: EdgeInsets.only(
            //                                  right: size.width * .3,
            //                                  left: size.width * .3),
            //                              child: const Divider(
            //                                thickness: 1,
            //                                color: Colors.grey,
            //                              ),
            //                            ),
            //                          ),
            //                          Center(
            //                            child: SizedBox(
            //                              //    height: 35,
            //                              child: Text(
            //                                "copyrights".tr + getCurrentYearString(),
            //                                style: Theme.of(context)
            //                                    .textTheme
            //                                    .headline2!
            //                                    .copyWith(color: Colors.grey),
            //                              ),
            //                            ),
            //                          ),
            //                        ]),
            //                  ),
            //                ),
            //              );
            //            }),
            //          )
            //        :
            //
            landscapeBody(context),
        floatingActionButton: showFab
            ? Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 31),
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
                                          onPressed: () {
                                            controller.secureStorage
                                                .writeSecureData(
                                                    AllStringConst.AppColor,
                                                    Get.find<MController>()
                                                        .appcolor
                                                        .value);
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
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 110,
                        ),
                        FloatingActionButton(
                            onPressed: () {
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
                                                CustomInputTextFiled(
                                                  validator: controller
                                                      .validators
                                                      .userNameValidator,
                                                  textEditingController:
                                                      controller.baseUrl,
                                                  label: "Base Url".tr,
                                                ),
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
                                                      onPressed: () {
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
                                                      onPressed: () {
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
                                                      const BorderRadius.all(
                                                          Radius.circular(6))),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  controller.secureStorage
                                                      .writeSecureData(
                                                          AllStringConst
                                                              .BaseUrl,
                                                          controller
                                                              .baseUrl.text);

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
                ],
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  Widget logForm(BuildContext context1) {
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
                        padding: const EdgeInsets.all(60),
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.red,
                              width: double.infinity,
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "appTitle".tr,
                                textDirection: TextDirection.rtl,
                                style:
                                Theme.of(context).textTheme.headline1!.copyWith(),
                              ),
                            ),
                            SizedBox(height: 60,),
                            CustomInputTextFiled(
                                validator:
                                    controller.validators.userNameValidator,
                                textEditingController: controller.userName,
                                label: "name".tr),
                            SizedBox(height: 20,),
                            CustomInputTextFiled(
                                validator:
                                    controller.validators.passWordValidator,
                                textEditingController: controller.passWord,
                                label: "password".tr),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50.0, left: 0, right: 0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                color: Colors.transparent,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Spacer(),
                                    Flexible(
                                        flex: 20,
                                        child: CustomButton(
                                            onPressed: controller.logIngRequst,
                                            name: "login".tr)),
                                    Flexible(
                                      //space
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Flexible(
                                        flex: 8,
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
                    Container(
                      height: 35,
                      child: Text(
                        "copyrights".tr + getCurrentYearString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
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
      onColorChanged: (Color color) {
        Get.find<MController>().setAppColor(color);
        print(color);
        pickerColor = color;
      },
    );
  }
}
