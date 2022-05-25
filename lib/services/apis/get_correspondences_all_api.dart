
import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';


import '../json_model/get_correspondences_all_model.dart';

class GetCorrespondencesAllAPI extends ApiManager{
  String data="";
  @override
  String apiUrl() {
   return SettingsApp.GetCorrespondencesAllUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
  return GetCorrespondencesAllModel.fromJson(data);
  }

}