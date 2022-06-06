import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import '../../../utility/settings_app.dart';
import '../../json_model/get_document_links_model.dart';

class GetDocumentLinksApi extends ApiManager{
  String data="";//?Token={Token}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}"
  @override
  String apiUrl() {
    return SettingsApp.GetDocumentLinksUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return GetDocumentLinksModel.fromJson(data);
  }

}