


import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/get_lookups_model.dart';

class GetLookupsApi extends ApiManager{
  String data="";
  @override
  String apiUrl() {
         return SettingsApp.GetLookupsUrl +data;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return GetLookupsModel.fromJson(data);
  }

}