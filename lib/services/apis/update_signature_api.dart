import 'package:cts/services/abstract_json_resource.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../api_manager.dart';
import '../json_model/signature_Info_model.dart';

class UpdateSignatureApi extends ApiManager{
  UpdateSignatureApi(BuildContext context) : super(context: context);

  @override
  String apiUrl() {
   return SettingsApp.PostUpdateSignatureUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return SignatureInfoModel.fromMap(data);
  }



}