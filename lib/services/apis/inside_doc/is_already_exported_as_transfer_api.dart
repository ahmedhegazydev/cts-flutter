import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../json_model/inopendocModel/is_already_exported_as_transfer_model.dart';

class IsAlreadyExportedAsTransferAPI extends ApiManager{
  String data="";

  IsAlreadyExportedAsTransferAPI(BuildContext context) : super(context);
  @override
  String apiUrl() {
return SettingsApp.GetIsAlreadyExportedAsTransferUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
return IsAlreadyExportedAsTransferModel.fromJson(data);
  }

}