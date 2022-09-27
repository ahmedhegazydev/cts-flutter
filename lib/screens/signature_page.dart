import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/signature_Controller.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/utilitie.dart';

class SignaturePage extends GetView<SignaturePageController> {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
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
          Spacer(),
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
        ], leading: SizedBox(), centerTitle: true),
        body: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "توقيعي",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GetBuilder<SignaturePageController>(builder: (logic) {
                            return Container(
                              height: 100,
                              padding: EdgeInsets.all(8),
                              color: Colors.grey.withOpacity(.5),
                              child: CachedMemoryImage(
                                uniqueKey: "defaultsignature",
                                errorWidget: const Text('Error'),
                                bytes: dataFromBase64String(controller
                                    .secureStorage
                                    .readSecureData(AllStringConst.Signature)),
                                placeholder: const CircularProgressIndicator(),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "اخري",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GetBuilder<SignaturePageController>(builder: (logic) {
                            return Expanded(
                                child: GetBuilder<SignaturePageController>(
                                    assignId: true,
                                    builder: (logic) {
                                      return ListView.builder(
                                        itemCount:
                                        controller.multiSignatures.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Container(
                                              height: 100,
                                              padding: EdgeInsets.all(8),
                                              color:
                                              Colors.grey.withOpacity(.5),
                                              child: CachedMemoryImage(
                                                fit: BoxFit.fill,
                                                uniqueKey: index.toString(),
                                                errorWidget:
                                                const Text('Error'),
                                                bytes: dataFromBase64String(
                                                    controller
                                                        .multiSignatures[index]
                                                        .signature),
                                                placeholder:
                                                const CircularProgressIndicator(),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }));
                          }),
                        ]),
                  ),
                )),
            SizedBox(
              width: size.width * .05,
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.grey.withOpacity(.1),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "رسم توقيع جديد",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: double.infinity,
                      height: size.height * .4,
                      child: Signature(
                        //dynamicPressureSupported: true,
                        backgroundColor: Colors.grey.withOpacity(.5),
                        controller: controller.controller,
                        width: size.width * 0.7,
                        height: size.height * .4,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          controller.controller.clear();
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                                "محو التوقيع",
                                style: TextStyle(color: Colors.white),
                              )),
                          height: 50,
                          width: size.width * .1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: RedColor),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),

                        GetBuilder<SignaturePageController>(builder: (logic) {
                   return    logic.saveSing? SizedBox(height: 50,
                          width: 50,
                          child: Center(child: CircularProgressIndicator(),))
                        : InkWell(
                          onTap: () {
                            controller.saveSign(context);
                          },
                          child: Container(
                            child: Center(
                                child: Text(
                                  "متابعة",
                                  style: TextStyle(color: Colors.white),
                                )),
                            height: 50,
                            width: size.width * .1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: AppColor),
                          ),
                        );
                      }),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ));
  }
}

//
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Flexible(
// flex: 1,
// child: Container(
// // color: Colors.red,
// child: Container(
// // height: 300,
// width: double.infinity,
// height: double.infinity,
// child: Signature(
// controller: controller.controller,
// )),
// )),
// Flexible(
// // color: Colors.yellow,
// child: Row(
// children: [
// Flexible(
// child: Expanded(
// // color: Colors.red,
// child: Column(
// children: [
// Padding(
// padding: EdgeInsets.all(10),
// child: Text("defaultsignature".tr,
// style: TextStyle(
// // fontFamily: 'Roboto',
// fontSize: 20,
// // letterSpacing: 0.15,
// // fontWeight: FontWeight.w500,
// // color: _themeData!.colorScheme.onSurface
// //     .withOpacity(0.87),
// )),
// ),
// GetBuilder<SignaturePageController>(builder: (logic) {
// return Padding(
// padding: const EdgeInsets.all(20.0),
// // child: Image.memory(
// //   dataFromBase64String(controller.secureStorage
// //       .readSecureData(AllStringConst.Signature)),
// //   height: 100,
// // ),
// child: CachedMemoryImage(
// uniqueKey: "defaultsignature",
// errorWidget: const Text('Error'),
// bytes: dataFromBase64String(controller.secureStorage
//     .readSecureData(AllStringConst.Signature)),
// placeholder: const CircularProgressIndicator(),
// ));
// }),
// ],
// ),
// )),
// Flexible(
// child: Expanded(
// // color: Colors.yellow,
// child: Column(
// children: [
// Padding(
// padding: EdgeInsets.all(10),
// child: Text(
// "multisignature".tr,
// style: TextStyle(
// // fontFamily: 'Roboto',
// fontSize: 20,
// // letterSpacing: 0.15,
// // fontWeight: FontWeight.w500,
// // color: _themeData!.colorScheme.onSurface
// //     .withOpacity(0.87),
// ),
// ),
// ),
// Expanded(
// child: GetBuilder<SignaturePageController>(
// assignId: true,
// builder: (logic) {
// return GridView.builder(
// physics: ScrollPhysics(),
// itemCount: controller.multiSignatures.length,
// gridDelegate:
// SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 3,
// // crossAxisSpacing: 4.0,
// // mainAxisSpacing: 4.0
// ),
// itemBuilder: (BuildContext context, int index) {
// return Container(
// // child: Image.memory(
// //     dataFromBase64String(
// //     controller
// //         .multiSignatures[index].signature),
// // ),
// // child: CachedNetworkImage(
// //   imageUrl: controller.multiSignatures[index].signature ?? "",
// //   progressIndicatorBuilder: (context, url, downloadProgress) =>
// //       CircularProgressIndicator(value: downloadProgress.progress),
// //   errorWidget: (context, url, error) => Icon(Icons.error),
// // ),
// child: CachedMemoryImage(
// uniqueKey: index.toString(),
// errorWidget: const Text('Error'),
// bytes: dataFromBase64String(controller
//     .multiSignatures[index].signature),
// placeholder:
// const CircularProgressIndicator(),
// ),
// );
// },
// );
// })
// //    new ListView.builder(
// //        itemCount: controller.multiSignatures.length,
// //        itemBuilder: (context, pos) {
// //          return Padding(
// //            padding: const EdgeInsets.all(8.0),
// //            child: Image.memory(dataFromBase64String(controller
// //                .multiSignatures[pos].signature)),
// //          );
// //        }
// //        )
//
// )
// ],
// ),
// ))
// ],
// )),

// // SizedBox(
// //   width: MediaQuery.of(context).size.width,
// //   height: 50,
// //   child: CustomButton(
// //       onPressed: () {
// //         Get.back();
// //       },
// //       name: "bageback".tr),
// // ),
// ],
// ),
