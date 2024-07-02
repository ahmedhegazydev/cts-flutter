

import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/find_recipient_model.dart';

class FindRecipient extends ApiManager{
  String data="";

  FindRecipient(BuildContext? context) : super();
  @override
  String apiUrl() {
    return SettingsApp.FindRecipientUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return FindRecipientModel.fromJson(data);
  }
  
}