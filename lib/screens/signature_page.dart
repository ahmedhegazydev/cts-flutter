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
    return Scaffold(appBar: AppBar(title: Text("addsing".tr,style: TextStyle(color: Colors.white),),leading: SizedBox(),centerTitle: true),body: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 300,
            width: double.infinity,
            child: Signature(controller: controller.controller,)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(onTap: () {
            controller.controller.clear();
          }, child: Icon(Icons.clear, size: 50,)),
          InkWell(onTap: () {
            controller.saveSign(context);
          }, child: Icon(Icons.save, size: 50,)),
        ],),
        Divider(color: Colors.grey),
        SizedBox(height: 10,),
        Text("defaultsignature".tr),
        GetBuilder<SignaturePageController>(builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(  20.0),
            child: Image.memory(dataFromBase64String(
                controller.secureStorage.readSecureData(
                    AllStringConst.Signature)), height: 100,),
          );
        }),
        Divider(color: Colors.grey),

        Text("multisignature".tr),
        SizedBox(height: 10,)
        , Expanded(
          child: GetBuilder<SignaturePageController>(
            assignId: true,
            builder: (logic) {
              return
                GridView.builder(
                  itemCount: controller
                      .multiSignatures.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.memory(dataFromBase64String(controller
                        .multiSignatures[index].signature));
                  },
                );


              // ListView.builder(
              //     itemCount: controller.multiSignatures.length,
              //     itemBuilder: (context, pos) {
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Image.memory(dataFromBase64String(controller
              //             .multiSignatures[pos].signature)),
              //       );
              //     });
            },
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width, height: 50,
          child: CustomButton(
              onPressed: (){
                Get.back();
              },
              name: "bageback".tr),
        ),    ],
    ),);
  }
}
