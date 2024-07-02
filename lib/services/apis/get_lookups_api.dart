


import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/get_lookups_model.dart';

class GetLookupsApi extends ApiManager{
  String data="";

  GetLookupsApi(BuildContext? context) : super(context: context);
  @override
  String apiUrl() {
         return SettingsApp.GetLookupsUrl +data;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return GetLookupsModel.fromJson(data);
  }

}