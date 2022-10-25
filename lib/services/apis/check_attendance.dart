import 'package:cts/services/abstract_json_resource.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../api_manager.dart';
import '../json_model/check_attendance_model.dart';
import '../json_model/signature_Info_model.dart';

class CheckAttendanceApi extends ApiManager {
  CheckAttendanceApi(BuildContext context) : super(context: context);

  @override
  String apiUrl() {
    return SettingsApp.CheckAttendanceUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return CheckAttendanceResponseModel.fromMap(data);
  }
}
