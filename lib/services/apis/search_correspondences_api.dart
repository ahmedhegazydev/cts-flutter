

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/search_correspondences_model.dart';

class SearchCorrespondencesApi extends ApiManager{
  @override
  String apiUrl() {
   return SettingsApp.SearchCorrespondencesUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return  SearchCorrespondencesModel.fromJson(data) ;
     
  }

}