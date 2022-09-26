import 'package:flutter/material.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/login_model.dart';

class LogInApi extends ApiManager {
  String loginData = "";

  LogInApi(BuildContext context) : super(context: context);

  @override
  String apiUrl() {
    return SettingsApp.loginUrl + loginData;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return LoginModel.fromJson(data);
  }
}
