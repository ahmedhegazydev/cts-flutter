
  import 'package:cts/services/abstract_json_resource.dart';

class MultipleTransfersModel extends AbstractJsonResource
  {
   String token ;
    String correspondenceId ;
      String transferId ;
      List<TransferNode> transfers ;

   MultipleTransfersModel(
       {required this.token,required this.correspondenceId,required this.transferId,required this.transfers});

   Map<String, dynamic> toMap() {
     Map<String, dynamic>data={};
    data['token']  = this.token;
    data['correspondenceId']  = this.correspondenceId;
    data['transferId']  = this.transferId;

     if (this.transfers != null) {

       data[ 'documentAnnotationsString']  = this.transfers!.map((v) => v.toMap()).toList();
     }
return data;
  }

  factory MultipleTransfersModel.fromMap(Map<String, dynamic> map) {
    return MultipleTransfersModel(
      token: map['token'] as String,
      correspondenceId: map['correspondenceId'] as String,
      transferId: map['transferId'] as String,
      transfers: map['transfers'] as List<TransferNode>,
    );
  }
}

   class TransferNode
  {
     String destinationId ;
     String purposeId;
     String dueDate ;
     String note;
     String voiceNote;//=> base64 string
     String voiceNoteExt ;// =>m4a
       bool voiceNotePrivate ;

     TransferNode({required this.destinationId,required this.purposeId,required this.dueDate,
       this.note="",
       this.voiceNote="", this.voiceNoteExt="", this.voiceNotePrivate=false});

     Map<String, dynamic> toMap() {
       Map<String, dynamic>data={};
      data['destinationId']  = this.destinationId;
      data['purposeId']  = this.purposeId;
      data['dueDate']  = this.dueDate;
      data['note']  = this.note;
      data['voiceNote']  =this.voiceNote;
      data['voiceNoteExt']=   this.voiceNoteExt;
      data['voiceNotePrivate']  = this.voiceNotePrivate;
return data;
     }

     factory TransferNode.fromMap(Map<String, dynamic> map) {
       return TransferNode(
         destinationId: map['destinationId'] as String,
         purposeId: map['purposeId'] as String,
         dueDate: map['dueDate'] as String,
         note: map['note'] as String,
         voiceNote: map['voiceNote'] as String,
         voiceNoteExt: map['voiceNoteExt'] as String,
         voiceNotePrivate: map['voiceNotePrivate'] as bool,
       );
     }

  }