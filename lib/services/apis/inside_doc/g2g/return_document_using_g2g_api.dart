import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../utility/settings_app.dart';
import '../../../json_model/inopendocModel/g2g/g2g_receive_or_reject_dto.dart';

class ReturnDocumentUsingG2GAPI extends ApiManager{
  ReturnDocumentUsingG2GAPI(BuildContext context) : super(context);

  @override
  String apiUrl() {
    return SettingsApp.PostReturnDocumentUsingG2GUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return G2GReceiveOrRejectDto.fromMap(data);
  }

}