

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';

class MultipleTransfersAPI extends ApiManager{
  @override
  String apiUrl() {
return SettingsApp.MultipleTransfersUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
  
}