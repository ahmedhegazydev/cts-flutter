import 'package:cts/services/abstract_json_resource.dart';

import '../../utility/settings_app.dart';
import '../api_manager.dart';
import '../json_model/search_correspondences_model.dart';

class SummariesInCorrespondenceAPI extends ApiManager{
  @override
  String apiUrl() {
    return SettingsApp.GetSummariesUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
  return SearchCorrespondencesModel.fromJson(data) ;
  }

}