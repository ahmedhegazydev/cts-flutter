

import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/inopendocModel/multiple_transfers_model.dart';

class MultipleTransfersAPI extends ApiManager{
  MultipleTransfersAPI(BuildContext context) : super(context: context);

  @override
  String apiUrl() {
return SettingsApp.MultipleTransfersUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return MultipleTransfersModel.fromMap(data);
  }
  
}