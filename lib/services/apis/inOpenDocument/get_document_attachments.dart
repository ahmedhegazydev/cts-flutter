import 'package:cts/services/api_manager.dart';
import 'package:cts/services/json_model/can_open_document_model.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';

class GetDocumentAttachmentsAPI extends ApiManager {
  String data = "";

  GetDocumentAttachmentsAPI(BuildContext context) : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.GetAttachmentsUrl + data;
  }

  @override
  Attachments fromJson(data) {
    return Attachments.fromJson(data);
  }
}
