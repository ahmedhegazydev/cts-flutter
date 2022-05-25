

import '../abstract_json_resource.dart';

class ReplyWithVoiceNoteModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;

  ReplyWithVoiceNoteModel({this.errorMessage, this.status});

  ReplyWithVoiceNoteModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrorMessage'] = errorMessage;
    data['Status'] = status;
    return data;
  }
}
