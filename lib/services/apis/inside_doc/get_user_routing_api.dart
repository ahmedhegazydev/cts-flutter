import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../json_model/inopendocModel/get_user_routing_model.dart';

class GetUserRoutingAPI extends ApiManager{
  String data="";

  GetUserRoutingAPI(BuildContext context) : super(context);
  @override
  String apiUrl() {
   return SettingsApp.GetGetUserRoutingUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return GetUserRoutingModel.fromJson(data);
  }
  
}