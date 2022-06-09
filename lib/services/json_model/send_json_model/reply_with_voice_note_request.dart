import 'package:cts/services/abstract_json_resource.dart';

class ReplyWithVoiceNoteRequestModel extends AbstractJsonResource{
  String?  token ;
 String? userId ;
 String? language;
 String? correspondencesId ;
 String? transferId ;
 String? notes ;
 String? voiceNote ;
 String? voiceNoteExt ;
 bool? voiceNotePrivate;

  ReplyWithVoiceNoteRequestModel(
      {required this.token,
      required this.userId,
        required this.language,
        required  this.correspondencesId,
        required   this.transferId,
      this.notes,
      this.voiceNote,
      this.voiceNoteExt,
      this.voiceNotePrivate});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = this.token;
    data[ 'userId'] = this.userId;
    data['language']= this.language;
    data['correspondencesId']   = this.correspondencesId;
    data['transferId']   = this.transferId;
    data['notes']   = this.notes;
    data['voiceNote']   = this.voiceNote;
    data['voiceNoteExt']   = this.voiceNoteExt;
    data[ 'voiceNotePrivate']  = this.voiceNotePrivate;
     return data;
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