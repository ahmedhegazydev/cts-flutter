import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/inopendocModel/can_export_as_paperwork_model.dart';

class CanExportAsPaperworkAPI extends ApiManager{
  String data="";

  CanExportAsPaperworkAPI(BuildContext? context) : super(context: context);
  @override
  String apiUrl() {
   return SettingsApp.GetCanExportAsPaperworkUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return CanExportAsPaperworkModel.fromJson(data);
  }

}