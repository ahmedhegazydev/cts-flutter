import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../controllers/signature_Controller.dart';
import '../db/cts_database.dart';
import '../utility/all_const.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';

class SignaturePage extends GetView<SignaturePageController> {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // controller.controller
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
            Expanded(flex: 1, child: buildSavedSignaturesBar(context)),
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
                      color: Colors.grey.withOpacity(.5),
                      child: Signature(
                        //dynamicPressureSupported: true,
                        backgroundColor: Colors.transparent,
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
                        return logic.saveSing
                            ? SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ))
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

  Container buildSavedSignaturesBar(context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          DefaultSignature(context),
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
          buildList(),
        ]),
      ),
    );
  }

  Widget DefaultSignature(context) {
    var sign = SecureStorage.to.readSecureData(AllStringConst.Signature);

    if (sign != null && sign.isNotEmpty) {
      return Container(
        height: 100,
        padding: EdgeInsets.all(8),
        color: Colors.grey.withOpacity(.5),
        child: Image(
          fit: BoxFit.fill,
          image: MemoryImage(
            dataFromBase64String(sign!),
          ),
        ),
      );
    } else {
      return Container(
        height: 100,
      );
    }
  }

  // Widget DefaultSignature(context) {
  //   return FutureBuilder<String?>(
  //       future:
  //           CtsSettingsDatabase.instance.getString(AllStringConst.Signature),
  //       builder: (context, AsyncSnapshot<String?> snapshot) {
  //         if (snapshot.hasData) {
  //           if (snapshot.data != null && snapshot.data!.isNotEmpty) {
  //             return Container(
  //               height: 100,
  //               padding: EdgeInsets.all(8),
  //               color: Colors.grey.withOpacity(.5),
  //               child: Image(
  //                 fit: BoxFit.fill,
  //                 image: MemoryImage(
  //                   dataFromBase64String(snapshot.data!),
  //                 ),
  //               ),
  //             );
  //           } else {
  //             return Container(
  //               height: 100,
  //             );
  //           }
  //         } else {
  //           return CircularProgressIndicator();
  //         }
  //       });
  // }

  GetBuilder<SignaturePageController> buildList() {
    return GetBuilder<SignaturePageController>(builder: (logic) {
      return Expanded(
          child: GetBuilder<SignaturePageController>(
              assignId: true,
              builder: (logic) {
                return ListView.builder(
                  itemCount: controller.multiSignatures.length,
                  itemBuilder: (BuildContext context, int index) {
                    var signature2 =
                        controller.multiSignatures[index].signature;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(8),
                        color: Colors.grey.withOpacity(.5),
                        child: Image(
                          fit: BoxFit.fill,
                          image: MemoryImage(
                            dataFromBase64String(signature2),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }));
    });
  }
}
