

import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
 import '../abstract_json_resource.dart';
import '../api_manager.dart';
import '../json_model/reply_with_voicenote_model.dart';
import '../json_model/send_json_model/reply_with_voice_note_request.dart';

class ReplyWithVoiceNoteApi extends ApiManager{
  ReplyWithVoiceNoteApi(BuildContext context) : super(context);

  @override
  String apiUrl() {
    return SettingsApp.ReplyWithVoiceNoteUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    print("tjis data from postttt    ${data}");
   return ReplyWithVoiceNoteModel.fromJson(data);
  }
  
}