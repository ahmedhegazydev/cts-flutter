

import 'CorrespondencesModel.dart';

class DocumentModel {
  DocumentModel({
    this.errorMessage,
    this.status,
    this.allow,
    this.attachments,
    this.correspondence,
  });
  late final String? errorMessage;
  late final int? status;
  late final bool? allow;
  late final Attachments? attachments;
  late final Correspondences? correspondence;

  DocumentModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    allow = json['Allow'];
    attachments = Attachments.fromJson(json['attachments']);
    correspondence = Correspondences.fromJson(json['correspondence']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ErrorMessage'] = errorMessage;
    _data['Status'] = status;
    _data['Allow'] = allow;
    _data['attachments'] = attachments?.toJson();
    _data['correspondence'] = correspondence?.toJson();
    return _data;
  }
}

class Attachments {
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
  late final Null fileId;
  late final bool? isEditable;
  late final Null localUrl;
  late final Null name;
  late final Null siteId;
  late final Null spFrameUrl;
  late final Null spLocation;
  late final Null spUrl;
  late final Null webId;

  EditOfficeDetails.fromJson(Map<String, dynamic> json) {
    fileId = null;
    isEditable = json['isEditable'];
    localUrl = null;
    name = null;
    siteId = null;
    spFrameUrl = null;
    spLocation = null;
    spUrl = null;
    webId = null;
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
