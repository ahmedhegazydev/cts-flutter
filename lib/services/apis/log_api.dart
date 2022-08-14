import 'package:get/get.dart';

import '../../utility/settings_app.dart';
import '../../utility/storage.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/login_model.dart';
import 'dart:developer';

class LogInApi extends ApiManager {
  String loginData = "";

  @override
  String apiUrl() {
    return SettingsApp.loginUrl + loginData;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return LoginModel.fromJson(data);
  }
}
