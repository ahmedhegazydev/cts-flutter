import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/inopendocModel/attachment_Info_model.dart';

class UploadAttachmentApi extends ApiManager{
  UploadAttachmentApi(BuildContext context) : super(context);




  @override
  String apiUrl() {
    return SettingsApp. PostUploadAttachmentUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
return AttachmentInfoModel.fromMap(data);
  }}