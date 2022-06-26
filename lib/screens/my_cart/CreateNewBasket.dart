import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/main_controller.dart';
import '../../controllers/my_cart/create_basket_controller.dart';
import '../../utility/all_string_const.dart';
import '../../utility/storage.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_text_filed.dart';

// class CreateNewBasket extends GetWidget<CreateBasketController> {
class CreateNewBasket extends StatefulWidget {
  const CreateNewBasket({Key? key}) : super(key: key);

  @override
  State<CreateNewBasket> createState() => _CreateNewBasketState();
}

class _CreateNewBasketState extends State<CreateNewBasket> {
  final controller = Get.put(CreateBasketController());

  // Color pickerColor = Color(0xff443a49);
  // Color pickerColor = Colors.transparent;
  Color currentColor = Color(0xff443a49);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          createNewBasketForm(context),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: Container(
          //         padding: const EdgeInsets.all(10),
          //         child: RaisedButton(
          //             onPressed: () {
          //               // inboxController.applyFilter();
          //               // Navigator.pop(context);
          //               showDialog(
          //                   context: context,
          //                   builder: (context) => AlertDialog(
          //                         title: Text(
          //                           "pick your Color",
          //                         ),
          //                         content: Column(children: [
          //                           buildColorPicker(),
          //                           Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 8.0,
          //                                 bottom: 8,
          //                                 right: 20,
          //                                 left: 20),
          //                             child: Row(children: []),
          //                           ),
          //                           Container(
          //                             width: MediaQuery.of(context).size.width *
          //                                 .7,
          //                             padding: const EdgeInsets.only(
          //                                 left: 0, right: 0, top: 0, bottom: 0),
          //                             height: 60,
          //                             decoration: BoxDecoration(
          //                                 color: Theme.of(context)
          //                                     .colorScheme
          //                                     .primary,
          //                                 borderRadius: const BorderRadius.all(
          //                                     Radius.circular(6))),
          //                             child: ElevatedButton(
          //                               onPressed: () {
          //                                 // Get.find<SecureStorage>().writeSecureData(
          //                                 //     AllStringConst.AppColor,
          //                                 //     Get.find<MController>().appcolor.value);
          //                                 Navigator.of(context).pop();
          //                               },
          //                               child: Text(
          //                                 "save",
          //                                 // style: Theme.of(context)
          //                                 //     .textTheme
          //                                 //     .headline2!
          //                                 //     .copyWith(
          //                                 //     color: Colors.white),
          //                                 textAlign: TextAlign.center,
          //                               ),
          //                             ),
          //                           )
          //                         ]),
          //                       ));
          //             },
          //             child: GetBuilder<CreateBasketController>(
          //               init: CreateBasketController(),
          //               builder: (_) {
          //                 return Text("pick your Color",
          //                     style: TextStyle(
          //                         // backgroundColor: _.pickerColor,
          //                         color: _.pickerColor));
          //               },
          //             )),
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: <Widget>[
          // Expanded(
          //   child: Container(
          //     padding: const EdgeInsets.all(10),
          //     child: RaisedButton(
          //       onPressed: () {
          //         // inboxController.applyFilter();
          //         Navigator.pop(context);
          //       },
          //       child: Text(
          //         "register".tr,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 40,
          //   width: MediaQuery.of(context).size.width * .3,
          //   child: CustomButton(
          //       name: 'register'.tr,
          //       onPressed: () {
          //         controller.createNewBasket();
          //       }),
          // ),
          // ],
          // ),
        ],
      ),
    ));
  }

  Widget createNewBasketForm(context) {
    return Form(
        key: controller.createBasketFormKey,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: TextField(
                        controller: controller.textEditingControllerArabicName,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "arabic_name".tr,
                        ),
                      )),
                ),
              ],
            // ),
          // );
        // }
        ));
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: Get.find<CreateBasketController>().pickerColor,
      onColorChanged: (Color color) {
        // Get.find<MController>().setAppColor(color);
        // print(color);
        // controller.setPickerColor(color);
        Get.find<CreateBasketController>().setPickerColor(color);
        // setState(() {
        //   controller.setPickerColor(color);
        // });
      },
    );
  }
}
