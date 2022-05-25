



import '../../models/CorrespondencesModel.dart';
import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';

class GetCorrespondencesApi extends ApiManager{
  String data="";
  @override
  String apiUrl() {
  return SettingsApp.GetCorrespondencesUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return CorrespondencesModel.fromJson(data);
  }
  
}