import 'package:cts/services/abstract_json_resource.dart';

import '../../models/CorrespondencesModel.dart';

class DocumentModel extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  bool? allow;
  Attachments? attachments;
  Correspondence? correspondence;

  DocumentModel(
      {this.errorMessage,
      this.status,
      this.allow,
      this.attachments,
      this.correspondence});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    allow = json['Allow'];
    attachments = json['attachments'] != null
        ? new Attachments.fromJson(json['attachments'])
        : null;
    correspondence = json['correspondence'] != null
        ? new Correspondence.fromJson(json['correspondence'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['Allow'] = this.allow;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.toJson();
    }
    if (this.correspondence != null) {
      data['correspondence'] = this.correspondence!.toJson();
    }
    return data;
  }
}

class Attachments extends AbstractJsonResource {
  Attachments({
    this.errorMessage,
    this.status,
    this.attachments,
    this.isLocked,
    this.lockedBy,
    this.hasVoice,
    this.isDocSigned,
    this.voiceNote,
  });
  late final String? errorMessage;
  late final int? status;
  late final List<AttachmentsList>? attachments;
  late final bool? isLocked;
  late final String? lockedBy;
  late final bool? hasVoice;
  late final bool? isDocSigned;
  late final String? voiceNote;

  Attachments.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    attachments = List.from(json['Attachments'])
        .map((e) => AttachmentsList.fromJson(e))
        .toList();
    isLocked = json['IsLocked'];
    lockedBy = json['LockedBy'];
    hasVoice = json['hasVoice'];
    isDocSigned = json['isDocSigned'];
    voiceNote = json['voiceNote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ErrorMessage'] = errorMessage;
    _data['Status'] = status;
    _data['Attachments'] = attachments?.map((e) => e.toJson()).toList();
    _data['IsLocked'] = isLocked;
    _data['LockedBy'] = lockedBy;
    _data['hasVoice'] = hasVoice;
    _data['isDocSigned'] = isDocSigned;
    _data['voiceNote'] = voiceNote;
    return _data;
  }
}

class AttachmentsList {
  String? annotations;
  int? attachmentId;
  bool? canEditPDF;
  int? docId;
  String? fileName;
  int? folderId;
  String? folderName;
  bool? isOriginalMail;
  bool? isPrivate;
  String? serverFileInfo;
  int? status;
  int? transferId;
  String? uRL;
  EditOfficeDetails? editOfficeDetails;

  AttachmentsList({
    this.annotations,
    this.attachmentId,
    this.canEditPDF,
    this.docId,
    this.fileName,
    this.folderId,
    this.folderName,
    this.isOriginalMail,
    this.isPrivate,
    this.serverFileInfo,
    this.status,
    this.transferId,
    this.uRL,
    this.editOfficeDetails,
  });

  AttachmentsList.fromJson(Map<String, dynamic> json) {
    annotations = json['Annotations'];
    attachmentId = json['AttachmentId'];
    canEditPDF = json['CanEditPDF'];
    docId = json['DocId'];
    fileName = json['FileName'];
    folderId = json['FolderId'];
    folderName = json['FolderName'];
    isOriginalMail = json['IsOriginalMail'];
    isPrivate = json['IsPrivate'];
    serverFileInfo = json['ServerFileInfo'];
    status = json['Status'];
    transferId = json['TransferId'];
    uRL = json['URL'];
    editOfficeDetails = json['editOfficeDetails'] != null
        ? EditOfficeDetails.fromJson(json['editOfficeDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Annotations'] = annotations;
    data['AttachmentId'] = attachmentId;
    data['CanEditPDF'] = canEditPDF;
    data['DocId'] = docId;
    data['FileName'] = fileName;
    data['FolderId'] = folderId;
    data['FolderName'] = folderName;
    data['IsOriginalMail'] = isOriginalMail;
    data['IsPrivate'] = isPrivate;
    data['ServerFileInfo'] = serverFileInfo;
    data['Status'] = status;
    data['TransferId'] = transferId;
    data['URL'] = uRL;
    if (editOfficeDetails != null) {
      data['editOfficeDetails'] = this.editOfficeDetails?.toJson();
    }
    return data;
  }
}

class EditOfficeDetails {
  EditOfficeDetails({
    this.fileId,
    this.isEditable,
    this.localUrl,
    this.name,
    this.siteId,
    this.spFrameUrl,
    this.spLocation,
    this.spUrl,
    this.webId,
  });
  late final String? fileId;
  late final bool? isEditable;
  late final String? localUrl;
  late final String? name;
  late final String? siteId;
  late final String? spFrameUrl;
  late final String? spLocation;
  late final String? spUrl;
  late final String? webId;

  EditOfficeDetails.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    isEditable = json['isEditable'];
    localUrl = json['localUrl'];
    name = json['name'];
    siteId = json['siteId'];
    spFrameUrl = json['spFrameUrl'];
    spLocation = json['spLocation'];
    spUrl = json['spUrl'];
    webId = json['webId '];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fileId'] = fileId;
    _data['isEditable'] = isEditable;
    _data['localUrl'] = localUrl;
    _data['name'] = name;
    _data['siteId'] = siteId;
    _data['spFrameUrl'] = spFrameUrl;
    _data['spLocation'] = spLocation;
    _data['spUrl'] = spUrl;
    _data['webId'] = webId;
    return _data;
  }
}
