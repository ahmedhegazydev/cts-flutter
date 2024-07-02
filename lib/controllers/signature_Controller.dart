import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../db/cts_database.dart';
import '../services/apis/update_signature_api.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/signature_Info_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';

class SignaturePageController extends GetxController {
  bool saveSing = false;
  Map<String, dynamic>? logindata;
  List<MultiSignatures> multiSignatures = [];
  // final SecureStorage secureStorage = SecureStorage();

  List newSing = [];
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  replaceSing(sin) {
    newSing.clear();
    newSing.add(sin);

    update();
  }

  updateSignature(
      {context, required SignatureInfoModel signatureInfoModel}) async {
    saveSing = true;
    update();
    UpdateSignatureApi _updateSignatureApi = UpdateSignatureApi(context);
    var value = await _updateSignatureApi
        .post(signatureInfoModel.toMap()); //.then((value) {
    // saveSing = false;
    print(value);
    // });
  }

  @override
  void onReady() {
    super.onReady();

    logindata = SecureStorage.to.readSecureJsonData(AllStringConst.LogInData);
    if (logindata != null) {
      LoginModel data = LoginModel.fromJson(logindata!);
      multiSignatures = data.multiSignatures ?? [];
      //  multiSignatures.add(SecureStorage.to.readSecureData(AllStringConst.Signature))
      update();
    }
  }

  Future saveSign(context) async {
    saveSing = true;
    if (controller.points.isEmpty) {
      controller.clear();
      return;
    }
    final Uint8List? data = await controller.toPngBytes();

    SignatureInfoModel _signatureInfoModel = SignatureInfoModel(
        signature: base64.encode(data!),
        Token: SecureStorage.to.token()!,
        SignatureId: "");

    await updateSignature(
        context: context, signatureInfoModel: _signatureInfoModel);
    await SecureStorage.to
        .writeSecureData(AllStringConst.Signature, base64.encode(data));

    saveSing = false;
    Get.offNamed("/Landing");
    return;
  }
}
