import 'package:cts/services/json_model/request_edit_in_office_model.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';

class RequestRefreshEditInOfficeAPI extends ApiManager {
  String data = "";

  RequestRefreshEditInOfficeAPI(BuildContext context) : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.PostRefreshOfficeFile;
  }

  @override
  AbstractJsonResource fromJson(data) {
    print(data);
    return RequestEditInOfficeModel.fromJson(data);
  }
}
