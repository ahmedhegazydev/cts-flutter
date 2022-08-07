

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/inopendocModel/multiple_transfers_model.dart';

class MultipleTransfersAPI extends ApiManager{
  @override
  String apiUrl() {
return SettingsApp.MultipleTransfersUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return MultipleTransfersModel.fromMap(data);
  }
  
}