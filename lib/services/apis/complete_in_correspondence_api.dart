import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../utility/settings_app.dart';
import '../json_model/complete_in_correspondence_model.dart';

class CompleteInCorrespondenceAPI extends ApiManager{
  String data="";
  @override
  String apiUrl() {
   return  SettingsApp.ExecuteCustomActionsUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return   CompleteInCorrespondenceModel.fromJson(data);
  }
  
}