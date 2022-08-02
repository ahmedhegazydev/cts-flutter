import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/inopendocModel/get_attachment_item_model.dart';

class GetAttachmentItemAPI extends ApiManager{
  String data="";
  @override
  String apiUrl() {
    return SettingsApp. GetAttachmentItemUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
  return GetAttAchmentItem.fromJson(data);
  }

}