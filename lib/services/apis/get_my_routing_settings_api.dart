import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../json_model/get_my_routing_settings_model.dart';
import '../json_model/my_transfer_routing_dto_model.dart';
import '../json_model/my_transfer_routing_dto_result.dart';

class GetMyRoutingsettingsApi extends ApiManager {
  String data="";

  GetMyRoutingsettingsApi(BuildContext context) : super(context);

  @override
  String apiUrl() {
    return SettingsApp.GetMyRoutingSettingsUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
return MyTransferRoutingDto.fromJson(data);
  }
}
