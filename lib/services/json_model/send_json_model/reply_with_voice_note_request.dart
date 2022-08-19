
class ReplyWithVoiceNoteRequestModel  {
  String?  token ;
 String? userId ;
 String? language;
 String? correspondencesId ;
 String? transferId ;
 String? notes ;
 String? voiceNote ;
 String? voiceNoteExt ;
 bool? voiceNotePrivate;
  String? actionType;
  ReplyWithVoiceNoteRequestModel(
      {  this.token,
        this.userId,
          this.language,
           this.correspondencesId,
            this.transferId,this.actionType,
      this.notes,
      this.voiceNote,
      this.voiceNoteExt="m4a",
      this.voiceNotePrivate});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['Token'] = this.token;
    data[ 'UserId'] = this.userId;
    data['Language']= this.language;
    data['CorrespondencesId']   = this.correspondencesId;
    data['TransferId']   = this.transferId;
    data['Notes']   = this.notes;
    data['VoiceNote']   = this.voiceNote;
    data['VoiceNoteExt']   = this.voiceNoteExt;
    data[ 'VoiceNotePrivate']  = this.voiceNotePrivate;
    data[ 'actionType']  = this.actionType;
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