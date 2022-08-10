import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';

import '../../../json_model/inopendocModel/g2g/export_usign_g2g_model.dart';
import '../../../json_model/inopendocModel/g2g/g2g_Info_for_export_model.dart';

class ExportUsingG2gAPI extends ApiManager{
  @override
  String apiUrl() {
    return SettingsApp.PostExportUsingG2GUrl;
  }
  @override
  AbstractJsonResource fromJson(data) {
   return ExportUsingG2gModel.fromJson(data);
  }
}