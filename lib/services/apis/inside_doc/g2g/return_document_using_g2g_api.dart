import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../../utility/settings_app.dart';
import '../../../json_model/inopendocModel/g2g/g2g_receive_or_reject_dto.dart';

class ReturnDocumentUsingG2GAPI extends ApiManager{
  @override
  String apiUrl() {
    return SettingsApp.PostReturnDocumentUsingG2GUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
   return G2GReceiveOrRejectDto.fromMap(data);
  }

}