import 'package:cts/services/abstract_json_resource.dart';

class GetDocumentReceiversModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<DocumentReceivers>? documentReceivers;
  List<DocumentReceivers>? documentTransfers;

  GetDocumentReceiversModel(
      {this.errorMessage,
        this.status,
        this.documentReceivers,
        this.documentTransfers});

  GetDocumentReceiversModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['DocumentReceivers'] != null) {
      documentReceivers = <DocumentReceivers>[];
      json['DocumentReceivers'].forEach((v) {
        documentReceivers!.add(new DocumentReceivers.fromJson(v));
      });
    }
    if (json['DocumentTransfers'] != null) {
      documentTransfers = <DocumentReceivers>[];
      json['DocumentTransfers'].forEach((v) {
        documentTransfers!.add(new DocumentReceivers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.documentReceivers != null) {
      data['DocumentReceivers'] =
          this.documentReceivers!.map((v) => v.toJson()).toList();
    }
    if (this.documentTransfers != null) {
      data['DocumentTransfers'] =
          this.documentTransfers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentReceivers {
  bool? rARCHIVE;
  String? rAction;
  int? rCNTID;
  String? rCNTNAME;
  String? rDATE;
  Null? rDELEGATED;
  int? rDOCID;
  bool? rEXPORTED;
  int? rID;
  bool? rOPEN;
  bool? rPRINTCOVERPAGE;
  bool? rPRINTDOCUMENT;
  bool? rREPLY;
  bool? rSIGNEDMANUALLY;
  int? rSTCID;
  String? rSTCNAME;
  bool? rTRANSFER;
  String? strRDate;

  DocumentReceivers(
      {this.rARCHIVE,
        this.rAction,
        this.rCNTID,
        this.rCNTNAME,
        this.rDATE,
        this.rDELEGATED,
        this.rDOCID,
        this.rEXPORTED,
        this.rID,
        this.rOPEN,
        this.rPRINTCOVERPAGE,
        this.rPRINTDOCUMENT,
        this.rREPLY,
        this.rSIGNEDMANUALLY,
        this.rSTCID,
        this.rSTCNAME,
        this.rTRANSFER,
        this.strRDate});

  DocumentReceivers.fromJson(Map<String, dynamic> json) {
    rARCHIVE = json['R_ARCHIVE'];
    rAction = json['R_Action'];
    rCNTID = json['R_CNT_ID'];
    rCNTNAME = json['R_CNT_NAME'];
    rDATE = json['R_DATE'];
    rDELEGATED = json['R_DELEGATED'];
    rDOCID = json['R_DOC_ID'];
    rEXPORTED = json['R_EXPORTED'];
    rID = json['R_ID'];
    rOPEN = json['R_OPEN'];
    rPRINTCOVERPAGE = json['R_PRINT_COVERPAGE'];
    rPRINTDOCUMENT = json['R_PRINT_DOCUMENT'];
    rREPLY = json['R_REPLY'];
    rSIGNEDMANUALLY = json['R_SIGNED_MANUALLY'];
    rSTCID = json['R_STC_ID'];
    rSTCNAME = json['R_STC_NAME'];
    rTRANSFER = json['R_TRANSFER'];
    strRDate = json['strR_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['R_ARCHIVE'] = this.rARCHIVE;
    data['R_Action'] = this.rAction;
    data['R_CNT_ID'] = this.rCNTID;
    data['R_CNT_NAME'] = this.rCNTNAME;
    data['R_DATE'] = this.rDATE;
    data['R_DELEGATED'] = this.rDELEGATED;
    data['R_DOC_ID'] = this.rDOCID;
    data['R_EXPORTED'] = this.rEXPORTED;
    data['R_ID'] = this.rID;
    data['R_OPEN'] = this.rOPEN;
    data['R_PRINT_COVERPAGE'] = this.rPRINTCOVERPAGE;
    data['R_PRINT_DOCUMENT'] = this.rPRINTDOCUMENT;
    data['R_REPLY'] = this.rREPLY;
    data['R_SIGNED_MANUALLY'] = this.rSIGNEDMANUALLY;
    data['R_STC_ID'] = this.rSTCID;
    data['R_STC_NAME'] = this.rSTCNAME;
    data['R_TRANSFER'] = this.rTRANSFER;
    data['strR_Date'] = this.strRDate;
    return data;
  }
}
