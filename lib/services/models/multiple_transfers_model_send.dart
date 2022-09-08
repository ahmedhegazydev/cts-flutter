
  class MultipleTransfers
{
    String token ;
  String correspondenceId ;
  String transferId ;
  List<TransferNode> transfers ;

    MultipleTransfers({required this.token,required this.correspondenceId,required this.transferId,
      required this.transfers});

    Map<String, dynamic> toMap() {
  Map<String,dynamic>data={};
      data['Token']  = this.token;
      data['CorrespondenceId']=this.correspondenceId;
      data['TransferId'] =this.transferId;
      //data['Transfers'] = this.transfers;

    data['Transfers'] = this.transfers.map((v) => v.toMap()).toList();

      return data;
    }

    factory MultipleTransfers.fromMap(Map<String, dynamic> map) {
      return MultipleTransfers(
        token: map['token'] as String,
        correspondenceId: map['correspondenceId'] as String,
        transferId: map['transferId'] as String,
        transfers: map['transfers'] as List<TransferNode>,
      );
    }

}





  class TransferNode
{
    String? destinationId ;
  String? purposeId ;
  String? dueDate;
  String? note ;
  String? voiceNote;
  String? voiceNoteExt ;
  bool? voiceNotePrivate ;

    Map<String, dynamic> toMap() {
Map<String,dynamic>data={};

    data['destinationId']  = this.destinationId;
    data[  'purposeId']= this.purposeId;
    data[ 'dueDate'] = this.dueDate;
    data[ 'note'] = this.note;
    data['voiceNote']  = this.voiceNote;
    data[ 'voiceNoteExt'] = this.voiceNoteExt;
    data[ 'voiceNotePrivate'] = this.voiceNotePrivate;
    return data;
  }

    TransferNode(
      {this.destinationId,
      this.purposeId,
      this.dueDate,
      this.note,
      this.voiceNote,
      this.voiceNoteExt,
      this.voiceNotePrivate});

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