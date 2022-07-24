import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';

import '../../json_model/inopendocModel/check_for_empty_structure_recipients_model.dart';

class CheckForEmptyStructureRecipientsAPI extends ApiManager{
  String data="";
  @override
  String apiUrl() {
  return SettingsApp.GetCheckForEmptyStructureRecipientsUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return CheckForEmptyStructureRecipientsModel.fromJson(data);
  }
  
}