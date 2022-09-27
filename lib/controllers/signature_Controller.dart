import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../services/apis/update_signature_api.dart';
import '../services/json_model/login_model.dart';
import '../services/json_model/signature_Info_model.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import '../utility/utilitie.dart';

class SignaturePageController extends GetxController {
  bool saveSing=false;
  Map<String, dynamic>? logindata;
  List<MultiSignatures> multiSignatures = [];
  final SecureStorage secureStorage = SecureStorage();

  List newSing = [];
  final SignatureController controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  replaceSing(sin) {
    // newSing.clear();
    // newSing.add(sin);

    update();
  }

  updateSignature({context, required SignatureInfoModel signatureInfoModel}) async{
    saveSing=true;
    update();
    UpdateSignatureApi _updateSignatureApi = UpdateSignatureApi(context);
  await  _updateSignatureApi.post(signatureInfoModel.toMap()).then((value) {
    saveSing=false;
    update();
      print(value);
    });

    saveSing=false;
    update();

  }

  @override
  void onReady() {
    super.onReady();

    logindata = secureStorage.readSecureJsonData(AllStringConst.LogInData);
    if (logindata != null) {
      LoginModel data = LoginModel.fromJson(logindata!);
      multiSignatures = data.multiSignatures ?? [];
      update();
      //multiSignatures.add(secureStorage.readSecureData(AllStringConst.Signature))
    }
  }

  saveSign(context) async {
    print("9999999999999999999999999999999");
    final Uint8List? data = await controller.toPngBytes();

    SignatureInfoModel _signatureInfoModel = SignatureInfoModel(
        signature: base64.encode(data!),
        Token: secureStorage.token()!,
        SignatureId: multiSignatures[0].cNTGctId.toString());

    updateSignature(context: context, signatureInfoModel: _signatureInfoModel);

    secureStorage.writeSecureData(
        AllStringConst.Signature, base64.encode(data));

    replaceSing(base64.encode(data));
  }
}
