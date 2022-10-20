import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/inopendocModel/get_attachment_item_model.dart';
import '../../json_model/inopendocModel/getatt_achments_model.dart';

class GetDocumentAttachmentsAPI extends ApiManager {
  String data = "";

  GetDocumentAttachmentsAPI(BuildContext context) : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.GetAttachmentsUrl + data;
  }

  @override
  GetAttachmentsModel fromJson(data) {
    return GetAttachmentsModel.fromJson(data);
  }
}
