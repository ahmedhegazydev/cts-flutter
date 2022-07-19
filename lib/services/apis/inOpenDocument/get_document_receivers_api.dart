import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/get_document_receivers_model.dart';

class GetDocumentReceiversApi extends ApiManager{
  String data="";//"GetDocumentReceivers?Token={Token}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}"
  @override
  String apiUrl() {
    return SettingsApp.GetDocumentReceiversUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return GetDocumentReceiversModel.fromJson(data);
  }

}