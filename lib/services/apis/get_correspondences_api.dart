



import 'package:flutter/src/widgets/framework.dart';

import '../../models/CorrespondencesModel.dart';
import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';

class GetCorrespondencesApi extends ApiManager{
  String data="";

  GetCorrespondencesApi(BuildContext context) : super(context);
  @override
  String apiUrl() {
  return SettingsApp.GetCorrespondencesUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return CorrespondencesModel.fromJson(data);
  }
  
}