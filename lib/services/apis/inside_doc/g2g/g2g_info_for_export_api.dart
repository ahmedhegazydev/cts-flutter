import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';

class G2GInfoForExportAPI extends ApiManager{
  String data="";

  G2GInfoForExportAPI(BuildContext context) : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.GetG2GInfoForExportUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return G2GInfoForExportModel.fromJson(data);
  }
  
}