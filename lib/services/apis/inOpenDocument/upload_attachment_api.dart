import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/inopendocModel/attachment_Info_model.dart';

class UploadAttachmentApi extends ApiManager{



  @override
  String apiUrl() {
    return SettingsApp. PostUploadAttachmentUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
return AttachmentInfoModel.fromMap(data);
  }}