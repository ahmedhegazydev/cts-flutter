

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/inopendocModel/save_document_annotation_model.dart';

class SaveDocumentAnnotationsAPI extends ApiManager{

  @override
  String apiUrl() {
    return SettingsApp.SaveDocumentAnnotationsUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return SaveDocumentAnnotationModel.fromJson(data);
  }
  
}