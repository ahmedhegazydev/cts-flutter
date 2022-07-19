import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';

class IsAlreadyExportedAsPaperworkAPI extends ApiManager{
  @override
  String apiUrl() {
return SettingsApp.GetIsAlreadyExportedAsPaperworkUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
  
}