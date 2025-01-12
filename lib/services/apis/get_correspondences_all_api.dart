import 'package:flutter/src/widgets/framework.dart';

import '../../models/CorrespondencesModel.dart';
import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';

class GetCorrespondencesAllAPI extends ApiManager {
  String data = "";

  GetCorrespondencesAllAPI(BuildContext context) : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.GetCorrespondencesAllUrl + data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    return CorrespondencesModel.fromJson(data);
  }
}
