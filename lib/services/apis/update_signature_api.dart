import 'package:cts/services/abstract_json_resource.dart';

import '../../utility/settings_app.dart';
import '../api_manager.dart';
import '../json_model/signature_Info_model.dart';

class UpdateSignatureApi extends ApiManager{
  @override
  String apiUrl() {
   return SettingsApp.PostUpdateSignatureUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return SignatureInfoModel.fromMap(data);
  }



}