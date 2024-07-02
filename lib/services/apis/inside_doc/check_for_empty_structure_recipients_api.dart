import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/services/json_model/inopendocModel/export_response_model.dart';
import 'package:cts/utility/settings_app.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../json_model/inopendocModel/check_for_empty_structure_recipients_model.dart';

class CheckForEmptyStructureRecipientsAPI extends ApiManager {
  String data = "";

  CheckForEmptyStructureRecipientsAPI(BuildContext? context)
      : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.GetCheckForEmptyStructureRecipientsUrl + data;
  }

  @override
  ExportResponse fromJson(data) {
    return ExportResponse.fromJson(data);
  }
}
