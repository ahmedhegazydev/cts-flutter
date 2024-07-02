import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../json_model/my_transfer_routing_dto_result.dart';

class SaveMyRoutingSettingsApi extends ApiManager {
  SaveMyRoutingSettingsApi(BuildContext context) : super(context: context);

  @override
  String apiUrl() {
    return SettingsApp.SaveMyRoutingSettingsUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return MyTransferRoutingDto.fromJson(data);
  }
}
