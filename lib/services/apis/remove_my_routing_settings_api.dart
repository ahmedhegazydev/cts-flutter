import 'package:flutter/material.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/my_transfer_routing_dto_result.dart';

class RemoveMyRoutingSettingsApi extends ApiManager{
  RemoveMyRoutingSettingsApi(BuildContext context) : super(context);

  @override
  String apiUrl() {
    return SettingsApp.RemoveMyRoutingSettingsUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return MyTransferRoutingDto.fromJson(data);
  }
}