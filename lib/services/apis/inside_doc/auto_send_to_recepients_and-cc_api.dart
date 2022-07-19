import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';

import '../../json_model/inopendocModel/auto_send_to_recepients_and_cc_model.dart';

class AutoSendToRecepientsAndCCAPI extends ApiManager{
  String data="";
  @override
  String apiUrl() {
 return SettingsApp.GetAutoSendToRecepientsAndCCUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
return AutoSendToRecepientsAndCCModel.fromJson(data);
  }

}
