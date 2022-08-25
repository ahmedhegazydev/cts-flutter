import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/signature_Controller.dart';
import '../services/json_model/signature_Info_model.dart';
import '../utility/utilitie.dart';

class SignaturePage extends GetView<SignaturePageController> {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Container(height: 300,
            width: double.infinity,
            child: Signature(controller: controller.controller,)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(onTap: () {
            controller.controller.clear();
          }, child: Icon(Icons.clear, size: 50,)),
          InkWell(onTap: ()async {
            print("9999999999999999999999999999999");
            final Uint8List? data =await controller.controller.toPngBytes();
            SignatureInfoModel _signatureInfoModel = SignatureInfoModel(
                signature:   base64.encode(data!), Token: controller.secureStorage.token()!,
                SignatureId: controller.multiSignatures[0].cNTGctId.toString());

               controller.updateSignature(
                   context: context,
                   signatureInfoModel: _signatureInfoModel);

controller.replaceSing(base64.encode(data!));
          }, child: Icon(Icons.save, size: 50,)),
        ],),
        Divider(color: Colors.grey)
        , Expanded(
          child: GetBuilder<SignaturePageController>(
            assignId: true,
            builder: (logic) {
              return
                GridView.builder(
                  itemCount: logic.haveNewSing?logic.newSing.length: controller
                      .multiSignatures.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return logic.haveNewSing?  Image.memory(dataFromBase64String(controller
                        .newSing[index])):   Image.memory(dataFromBase64String(controller
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
        )
      ],
    ),);
  }
}
