import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/inopendocModel/is_already_exported_as_paperwork_model.dart';

class IsAlreadyExportedAsPaperworkAPI extends ApiManager{
  String data="";

  IsAlreadyExportedAsPaperworkAPI(BuildContext context) : super(context: context);
  @override
  String apiUrl() {
return SettingsApp.GetIsAlreadyExportedAsPaperworkUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
  return IsAlreadyExportedAsPaperworkModel.fromJson(data);
  }
  
}