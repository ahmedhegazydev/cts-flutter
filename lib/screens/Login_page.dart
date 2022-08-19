import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';


import '../controllers/login_controller.dart';
import '../controllers/main_controller.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image_button.dart';
import '../widgets/custom_input_text_filed.dart';

class LoginPage extends GetWidget<LoginController> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
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
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("pick your Color"),
                            content: Column(children: [
                              buildColorPicker(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, right: 20, left: 20),
                                child: Row(children: [
                                Expanded(
                                  child: Container(
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: ElevatedButton(
                                    onPressed:(){
                                      var locale = const Locale('ar', 'AR');
                                      Get.updateLocale(locale);
                                    },
                                    child: Text(
                                      "عربي",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ),
                                )
                            ,SizedBox(width: 10,)   ,

                  Expanded(
                    child: Container(
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
                    borderRadius: const BorderRadius.all(
                    Radius.circular(6))),
                    child: ElevatedButton(
                    onPressed:(){
                      var locale = const Locale('en', 'US');
                      Get.updateLocale(locale);
                    },
                    child: Text(
                      "En",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(
                    color: Colors.white),
                    textAlign: TextAlign.center,
                    ),
                    ),
                    ),
                  )

                                ]),
                              ),



                              Container(width: MediaQuery.of(context).size.width*.7,
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: ElevatedButton(
                                  onPressed:(){
                                    Get.find<SecureStorage>().writeSecureData(
                                        AllStringConst.AppColor,
                                        Get.find<MController>().appcolor.value);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "save",
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
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  Widget logForm(context) {
    return Form(
        key: controller.loginFormKey,
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "appTitle".tr,
                        style:
                            Theme.of(context).textTheme.headline1!.copyWith(),
                      ),
                    ),
                    CustomInputTextFiled(
                        validator: controller.validators.userNameValidator,
                        textEditingController: controller.userName,
                        label: "name".tr),
                    CustomInputTextFiled(
                        validator: controller.validators.passWordValidator,
                        textEditingController: controller.passWord,
                        label: "password".tr),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50.0, left: 8, right: 8),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Spacer(),
                            Flexible(
                                flex: 8,
                                child: CustomImageButton(
                                  imagePath: 'assets/images/faceid.png',
                                  onClick: controller.faceIdButtonOnClick,
                                )),
                            Flexible(
                              //space
                              flex: 1,
                              child: Container(),
                            ),
                            Flexible(
                              flex: 20,
                              child:
                                  GetBuilder<LoginController>(builder: (logic) {
                                return logic.islogin
                                    ? const Center(
                                        child: SizedBox(
                                            child: CircularProgressIndicator(),
                                            width: 50))
                                    : CustomButton(
                                        onPressed: controller.logIngRequst,
                                        name: "login".tr);
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
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
