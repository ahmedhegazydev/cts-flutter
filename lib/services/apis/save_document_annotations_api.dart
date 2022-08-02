

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';

class SaveDocumentAnnotationsAPI extends ApiManager{
  String data="";//"GetDocumentTransfers?Token={Token}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}"
  @override
  String apiUrl() {
    return SettingsApp.SaveDocumentAnnotationsUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
  
}