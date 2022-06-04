import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/signature_Controller.dart';
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
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          InkWell(onTap: () {
            controller.controller.clear();
          }, child: Icon(Icons.clear,size: 50,)),
          InkWell(onTap: () {}, child: Icon(Icons.save,size: 50,)),
        ],),
        Divider(color: Colors.grey)
        , Expanded(
          child: GetBuilder<SignaturePageController>(
            assignId: true,
            builder: (logic) {
              return ListView.builder(
                  itemCount: controller.multiSignatures.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(dataFromBase64String(controller
                          .multiSignatures[pos].signature)),
                    );
                  });
            },
          ),
        )
      ],
    ),);
  }
}
