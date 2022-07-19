import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/get_document_logs_model.dart';

class GetDocumentAuditLogsApi extends ApiManager{
  String data="";//Token={Token}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}"
  @override
  String apiUrl() {
    return SettingsApp.GetDocumentLogsUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return GetDocumentLogsModel.fromJson(data);
  }

}