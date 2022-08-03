import 'package:cts/services/abstract_json_resource.dart';

class GetDocumentTransfersModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<DocumentReceivers>? documentReceivers;
  List<DocumentReceivers>? documentTransfers;

  GetDocumentTransfersModel(
      {this.errorMessage,
        this.status,
        this.documentReceivers,
        this.documentTransfers});

  GetDocumentTransfersModel.fromJson(Map<String, dynamic> json) {
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
  String? baseDocument;
  String? closureDate;
  int? inboxId;
  bool? isLocked;
  bool? isRead;
  bool? isTransferClosed;
  String? parentTransferDate;
  String? parentTransferId;
  Purpose? purpose;
  String? readDate;
  String? transferDate;
  String? transferDescription;
  String? transferDueDate;
  int? transferId;
  TransferReceivedByStructure? transferReceivedByStructure;
  TransferReceivedByStructure? transferReceivedByUser;
  TransferReceivedByStructure? transferSentByStructure;
  TransferSentByUser? transferSentByUser;
  int? transferStatusId;
  bool? transferredToContact;
  String? strClosureDate;
  String? strParentTransferDate;
  String? strReadDate;
  String? strTransferDate;
  String? strTransferDueDate;

  DocumentReceivers(
      {this.baseDocument,
        this.closureDate,
        this.inboxId,
        this.isLocked,
        this.isRead,
        this.isTransferClosed,
        this.parentTransferDate,
        this.parentTransferId,
        this.purpose,
        this.readDate,
        this.transferDate,
        this.transferDescription,
        this.transferDueDate,
        this.transferId,
        this.transferReceivedByStructure,
        this.transferReceivedByUser,
        this.transferSentByStructure,
        this.transferSentByUser,
        this.transferStatusId,
        this.transferredToContact,
        this.strClosureDate,
        this.strParentTransferDate,
        this.strReadDate,
        this.strTransferDate,
        this.strTransferDueDate});

  DocumentReceivers.fromJson(Map<String, dynamic> json) {
    baseDocument = json['BaseDocument'];
    closureDate = json['ClosureDate'];
    inboxId = json['InboxId'];
    isLocked = json['IsLocked'];
    isRead = json['IsRead'];
    isTransferClosed = json['IsTransferClosed'];
    parentTransferDate = json['ParentTransferDate'];
    parentTransferId = json['ParentTransferId'];
    purpose =
    json['Purpose'] != null ? new Purpose.fromJson(json['Purpose']) : null;
    readDate = json['ReadDate'];
    transferDate = json['TransferDate'];
    transferDescription = json['TransferDescription'];
    transferDueDate = json['TransferDueDate'];
    transferId = json['TransferId'];
    transferReceivedByStructure = json['TransferReceivedByStructure'] != null
        ? new TransferReceivedByStructure.fromJson(
        json['TransferReceivedByStructure'])
        : null;
    transferReceivedByUser = json['TransferReceivedByUser'] != null
        ? new TransferReceivedByStructure.fromJson(
        json['TransferReceivedByUser'])
        : null;
    transferSentByStructure = json['TransferSentByStructure'] != null
        ? new TransferReceivedByStructure.fromJson(
        json['TransferSentByStructure'])
        : null;
    transferSentByUser = json['TransferSentByUser'] != null
        ? new TransferSentByUser.fromJson(json['TransferSentByUser'])
        : null;
    transferStatusId = json['TransferStatusId'];
    transferredToContact = json['TransferredToContact'];
    strClosureDate = json['strClosureDate'];
    strParentTransferDate = json['strParentTransferDate'];
    strReadDate = json['strReadDate'];
    strTransferDate = json['strTransferDate'];
    strTransferDueDate = json['strTransferDueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BaseDocument'] = this.baseDocument;
    data['ClosureDate'] = this.closureDate;
    data['InboxId'] = this.inboxId;
    data['IsLocked'] = this.isLocked;
    data['IsRead'] = this.isRead;
    data['IsTransferClosed'] = this.isTransferClosed;
    data['ParentTransferDate'] = this.parentTransferDate;
    data['ParentTransferId'] = this.parentTransferId;
    if (this.purpose != null) {
      data['Purpose'] = this.purpose!.toJson();
    }
    data['ReadDate'] = this.readDate;
    data['TransferDate'] = this.transferDate;
    data['TransferDescription'] = this.transferDescription;
    data['TransferDueDate'] = this.transferDueDate;
    data['TransferId'] = this.transferId;
    if (this.transferReceivedByStructure != null) {
      data['TransferReceivedByStructure'] =
          this.transferReceivedByStructure!.toJson();
    }
    if (this.transferReceivedByUser != null) {
      data['TransferReceivedByUser'] = this.transferReceivedByUser!.toJson();
    }
    if (this.transferSentByStructure != null) {
      data['TransferSentByStructure'] = this.transferSentByStructure!.toJson();
    }
    if (this.transferSentByUser != null) {
      data['TransferSentByUser'] = this.transferSentByUser!.toJson();
    }
    data['TransferStatusId'] = this.transferStatusId;
    data['TransferredToContact'] = this.transferredToContact;
    data['strClosureDate'] = this.strClosureDate;
    data['strParentTransferDate'] = this.strParentTransferDate;
    data['strReadDate'] = this.strReadDate;
    data['strTransferDate'] = this.strTransferDate;
    data['strTransferDueDate'] = this.strTransferDueDate;
    return data;
  }
}

class Purpose {
  String? text;
  String? textAr;
  int? value;

  Purpose({this.text, this.textAr, this.value});

  Purpose.fromJson(Map<String, dynamic> json) {
    text = json['Text'];
    textAr = json['TextAr'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Text'] = this.text;
    data['TextAr'] = this.textAr;
    data['Value'] = this.value;
    return data;
  }
}

class TransferReceivedByStructure {
  String? fullName;
  String? fullNameAr;
  int? gctId;
  bool? isContact;
  int? stcId;

  TransferReceivedByStructure(
      {this.fullName, this.fullNameAr, this.gctId, this.isContact, this.stcId});

  TransferReceivedByStructure.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    fullNameAr = json['FullNameAr'];
    gctId = json['GctId'];
    isContact = json['IsContact'];
    stcId = json['StcId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['FullNameAr'] = this.fullNameAr;
    data['GctId'] = this.gctId;
    data['IsContact'] = this.isContact;
    data['StcId'] = this.stcId;
    return data;
  }
}

class TransferSentByUser {
  String? fullName;
  String? fullNameAr;
  int? gctId;
  Null? isContact;
  int? stcId;

  TransferSentByUser(
      {this.fullName, this.fullNameAr, this.gctId, this.isContact, this.stcId});

  TransferSentByUser.fromJson(Map<String, dynamic> json) {
    fullName = json['FullName'];
    fullNameAr = json['FullNameAr'];
    gctId = json['GctId'];
    isContact = json['IsContact'];
    stcId = json['StcId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FullName'] = this.fullName;
    data['FullNameAr'] = this.fullNameAr;
    data['GctId'] = this.gctId;
    data['IsContact'] = this.isContact;
    data['StcId'] = this.stcId;
    return data;
  }
}
