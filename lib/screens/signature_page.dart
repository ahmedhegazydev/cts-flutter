import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/signature_Controller.dart';
import '../services/json_model/signature_Info_model.dart';
import '../utility/all_string_const.dart';
import '../utility/utilitie.dart';
import '../widgets/custom_button.dart';

class SignaturePage extends GetView<SignaturePageController> {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ))),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text("addsing".tr,
                    style: TextStyle(
                        // fontFamily: 'Roboto',
                        fontSize: 20,
                        color: Colors.white
                        // letterSpacing: 0.15,
                        // fontWeight: FontWeight.w500,
                        // color: _themeData!.colorScheme.onSurface
                        //     .withOpacity(0.87),
                        )),
              ),
            ),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                    onTap: () {
                      controller.controller.clear();
                    },
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
                    ))),
            Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                    onTap: () {
                      controller.saveSign(context);
                    },
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30,
                    ))),
          ],
          // title: Text(
          //   "addsing".tr,
          //   style: TextStyle(color: Colors.white),
          // ),
          leading: SizedBox(),
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 1,
              child: Container(
                // color: Colors.red,
                child: Container(
                    // height: 300,
                    width: double.infinity,
                    height: double.infinity,
                    child: Signature(
                      controller: controller.controller,
                    )),
              )),
          Flexible(
              // color: Colors.yellow,
              child: Row(
            children: [
              Flexible(
                  child: Expanded(
                // color: Colors.red,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("defaultsignature".tr,
                          style: TextStyle(
                            // fontFamily: 'Roboto',
                            fontSize: 20,
                            // letterSpacing: 0.15,
                            // fontWeight: FontWeight.w500,
                            // color: _themeData!.colorScheme.onSurface
                            //     .withOpacity(0.87),
                          )),
                    ),
                    GetBuilder<SignaturePageController>(builder: (logic) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.memory(
                          dataFromBase64String(controller.secureStorage
                              .readSecureData(AllStringConst.Signature)),
                          height: 100,
                        ),
                      );
                    }),
                  ],
                ),
              )),
              Flexible(
                  child: Expanded(
                // color: Colors.yellow,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "multisignature".tr,
                        style: TextStyle(
                          // fontFamily: 'Roboto',
                          fontSize: 20,
                          // letterSpacing: 0.15,
                          // fontWeight: FontWeight.w500,
                          // color: _themeData!.colorScheme.onSurface
                          //     .withOpacity(0.87),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GetBuilder<SignaturePageController>(
                            assignId: true,
                            builder: (logic) {
                              return GridView.builder(
                                itemCount: controller.multiSignatures.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return Image.memory(dataFromBase64String(
                                      controller
                                          .multiSignatures[index].signature));
                                },
                              );
                            })
                        //    new ListView.builder(
                        //        itemCount: controller.multiSignatures.length,
                        //        itemBuilder: (context, pos) {
                        //          return Padding(
                        //            padding: const EdgeInsets.all(8.0),
                        //            child: Image.memory(dataFromBase64String(controller
                        //                .multiSignatures[pos].signature)),
                        //          );
                        //        }
                        //        )

                        )
                  ],
                ),
              ))
            ],
          )),

          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: 50,
          //   child: CustomButton(
          //       onPressed: () {
          //         Get.back();
          //       },
          //       name: "bageback".tr),
          // ),
        ],
      ),
    );
  }
}
