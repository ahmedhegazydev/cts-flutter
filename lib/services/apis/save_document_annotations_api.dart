import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/can_open_document_model.dart';
import '../json_model/inopendocModel/getatt_achments_model.dart';

class SaveDocumentAnnotationsAPI extends ApiManager {
  SaveDocumentAnnotationsAPI(BuildContext context) : super(context: context);

  @override
  String apiUrl() {
    return SettingsApp.SaveDocumentAnnotationsUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return Attachments.fromJson(data);
  }
}
