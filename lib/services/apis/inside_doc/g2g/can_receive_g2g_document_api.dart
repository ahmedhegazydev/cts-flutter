import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:cts/utility/settings_app.dart';

import '../../../json_model/inopendocModel/g2g/g2g_receive_or_reject_dto.dart';

class CanReceiveG2GDocumentAPI extends ApiManager{
  @override
  String apiUrl() {
  return SettingsApp.PostCanReceiveG2GDocumentUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
return G2GReceiveOrRejectDto.fromMap(data);
  }

}