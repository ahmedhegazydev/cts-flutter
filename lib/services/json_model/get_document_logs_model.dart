import '../abstract_json_resource.dart';

class GetDocumentLogsModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<DocumentLogs>? documentLogs;

  GetDocumentLogsModel({this.errorMessage, this.status, this.documentLogs});

  GetDocumentLogsModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['documentLogs'] != null) {
      documentLogs = <DocumentLogs>[];
      json['documentLogs'].forEach((v) {
        documentLogs!.add(new DocumentLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.documentLogs != null) {
      data['documentLogs'] = this.documentLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentLogs {
  String? actionDate;
  String? actionUser;
  int? dLACTION;
  String? dLACTIONNAME;
  String? dLDATE;
  String? dLDETAILS;
  int? dLDOCID;
  String? dLDOCREFERENCE;
  int? dLGCTID;
  int? dLID;
  int? dLTO;
  int? dLTSFID;
  int? dLTSFPURPOSE;
  String? purpose;
  String? toEntity;
  String? voiceNote;
  String? voiceNoteExt;
  bool? voiceNotePrivate;

  DocumentLogs(
      {this.actionDate,
        this.actionUser,
        this.dLACTION,
        this.dLACTIONNAME,
        this.dLDATE,
        this.dLDETAILS,
        this.dLDOCID,
        this.dLDOCREFERENCE,
        this.dLGCTID,
        this.dLID,
        this.dLTO,
        this.dLTSFID,
        this.dLTSFPURPOSE,
        this.purpose,
        this.toEntity,
        this.voiceNote,
        this.voiceNoteExt,
        this.voiceNotePrivate});

  DocumentLogs.fromJson(Map<String, dynamic> json) {
    actionDate = json['ActionDate'];
    actionUser = json['ActionUser'];
    dLACTION = json['DL_ACTION'];
    dLACTIONNAME = json['DL_ACTION_NAME'];
    dLDATE = json['DL_DATE'];
    dLDETAILS = json['DL_DETAILS'];
    dLDOCID = json['DL_DOC_ID'];
    dLDOCREFERENCE = json['DL_DOC_REFERENCE'];
    dLGCTID = json['DL_GCT_ID'];
    dLID = json['DL_ID'];
    dLTO = json['DL_TO'];
    dLTSFID = json['DL_TSF_ID'];
    dLTSFPURPOSE = json['DL_TSF_PURPOSE'];
    purpose = json['Purpose'];
    toEntity = json['ToEntity'];
    voiceNote = json['VoiceNote'];
    voiceNoteExt = json['VoiceNoteExt'];
    voiceNotePrivate = json['VoiceNotePrivate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActionDate'] = this.actionDate;
    data['ActionUser'] = this.actionUser;
    data['DL_ACTION'] = this.dLACTION;
    data['DL_ACTION_NAME'] = this.dLACTIONNAME;
    data['DL_DATE'] = this.dLDATE;
    data['DL_DETAILS'] = this.dLDETAILS;
    data['DL_DOC_ID'] = this.dLDOCID;
    data['DL_DOC_REFERENCE'] = this.dLDOCREFERENCE;
    data['DL_GCT_ID'] = this.dLGCTID;
    data['DL_ID'] = this.dLID;
    data['DL_TO'] = this.dLTO;
    data['DL_TSF_ID'] = this.dLTSFID;
    data['DL_TSF_PURPOSE'] = this.dLTSFPURPOSE;
    data['Purpose'] = this.purpose;
    data['ToEntity'] = this.toEntity;
    data['VoiceNote'] = this.voiceNote;
    data['VoiceNoteExt'] = this.voiceNoteExt;
    data['VoiceNotePrivate'] = this.voiceNotePrivate;
    return data;
  }
}
