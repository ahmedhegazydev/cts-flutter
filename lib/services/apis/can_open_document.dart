

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/can_open_document_model.dart';
import '../json_model/find_recipient_model.dart';

class CanOpenDocumentApi  extends ApiManager{
  String data="";
  @override
  String apiUrl() {
    return SettingsApp.CanOpenDocumentUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return CanOpenDocumentModel.fromJson(data);
  }
  
}