

import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/can_open_document_model.dart';

class CanOpenDocumentApi  extends ApiManager{
  String data="";

  CanOpenDocumentApi(BuildContext context) : super(context);

  @override
  String apiUrl() {

    return SettingsApp.CanOpenDocumentUrl+data;

  }

  @override
  AbstractJsonResource fromJson(data) {
    //print("i get AbstractJsonResource");
    return CanOpenDocumentModel.fromJson(data);
  }
  
}