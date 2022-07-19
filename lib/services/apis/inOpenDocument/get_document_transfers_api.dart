import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/get_document_transfers_model.dart';

class GetDocumentTransfersApi extends ApiManager{
  String data="";//"GetDocumentTransfers?Token={Token}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}"
  @override
  String apiUrl() {
    return SettingsApp.GetDocumentTransfersUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
  return GetDocumentTransfersModel.fromJson(data);
  }
  
}