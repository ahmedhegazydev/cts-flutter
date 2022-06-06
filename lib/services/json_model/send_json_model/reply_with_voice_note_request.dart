import 'package:cts/services/abstract_json_resource.dart';

class ReplyWithVoiceNoteRequestModel extends AbstractJsonResource{
  String?   token ;
 String? userId ;
 String? language;
 String? correspondencesId ;
 String? transferId ;
 String? notes ;
 String? voiceNote ;
 String? voiceNoteExt ;
 bool? voiceNotePrivate;

  ReplyWithVoiceNoteRequestModel(
      {this.token,
      this.userId,
      this.language,
      this.correspondencesId,
      this.transferId,
      this.notes,
      this.voiceNote,
      this.voiceNoteExt,
      this.voiceNotePrivate});

  Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'userId': this.userId,
      'language': this.language,
      'correspondencesId': this.correspondencesId,
      'transferId': this.transferId,
      'notes': this.notes,
      'voiceNote': this.voiceNote,
      'voiceNoteExt': this.voiceNoteExt,
      'voiceNotePrivate': this.voiceNotePrivate,
    };
  }

  factory ReplyWithVoiceNoteRequestModel.fromMap(Map<String, dynamic> map) {
    return ReplyWithVoiceNoteRequestModel(
      token: map['token'] ,
      userId: map['userId']  ,
      language: map['language'] ,
      correspondencesId: map['correspondencesId']  ,
      transferId: map['transferId']  ,
      notes: map['notes']  ,
      voiceNote: map['voiceNote'] ,
      voiceNoteExt: map['voiceNoteExt']  ,
      voiceNotePrivate: map['voiceNotePrivate']  ,
    );
  }
 }