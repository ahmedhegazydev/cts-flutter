import 'package:cts/services/abstract_json_resource.dart';

import '../can_open_document_model.dart';

class GetAttAchmentItem extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  AttachmentsList? attachment;

  GetAttAchmentItem({this.errorMessage, this.status, this.attachment});

  GetAttAchmentItem.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    attachment = json['attachment'] != null
        ? new AttachmentsList.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    return data;
  }
}

// class Attachment {
//   String? annotations;
//   int? attachmentId;
//   bool? canEditPDF;
//   int? docId;
//   String? fileName;
//   int? folderId;
//   String? folderName;
//   bool? isOriginalMail;
//   bool? isPrivate;
//   String? serverFileInfo;
//   int? status;
//   int? transferId;
//   String? uRL;
//   EditOfficeDetails? editOfficeDetails;

//   Attachment(
//       {this.annotations,
//         this.attachmentId,
//         this.canEditPDF,
//         this.docId,
//         this.fileName,
//         this.folderId,
//         this.folderName,
//         this.isOriginalMail,
//         this.isPrivate,
//         this.serverFileInfo,
//         this.status,
//         this.transferId,
//         this.uRL,
//         this.editOfficeDetails});

//   Attachment.fromJson(Map<String, dynamic> json) {
//     annotations = json['Annotations'];
//     attachmentId = json['AttachmentId'];
//     canEditPDF = json['CanEditPDF'];
//     docId = json['DocId'];
//     fileName = json['FileName'];
//     folderId = json['FolderId'];
//     folderName = json['FolderName'];
//     isOriginalMail = json['IsOriginalMail'];
//     isPrivate = json['IsPrivate'];
//     serverFileInfo = json['ServerFileInfo'];
//     status = json['Status'];
//     transferId = json['TransferId'];
//     uRL = json['URL'];
//     editOfficeDetails = json['editOfficeDetails'] != null
//         ? new EditOfficeDetails.fromJson(json['editOfficeDetails'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Annotations'] = this.annotations;
//     data['AttachmentId'] = this.attachmentId;
//     data['CanEditPDF'] = this.canEditPDF;
//     data['DocId'] = this.docId;
//     data['FileName'] = this.fileName;
//     data['FolderId'] = this.folderId;
//     data['FolderName'] = this.folderName;
//     data['IsOriginalMail'] = this.isOriginalMail;
//     data['IsPrivate'] = this.isPrivate;
//     data['ServerFileInfo'] = this.serverFileInfo;
//     data['Status'] = this.status;
//     data['TransferId'] = this.transferId;
//     data['URL'] = this.uRL;
//     if (this.editOfficeDetails != null) {
//       data['editOfficeDetails'] = this.editOfficeDetails!.toJson();
//     }
//     return data;
//   }
// }

class EditOfficeDetails {
  String? fileId;
  bool? isEditable;
  String? localUrl;
  String? name;
  String? siteId;
  String? spFrameUrl;
  String? spLocation;
  String? spUrl;
  String? webId;

  EditOfficeDetails(
      {this.fileId,
      this.isEditable,
      this.localUrl,
      this.name,
      this.siteId,
      this.spFrameUrl,
      this.spLocation,
      this.spUrl,
      this.webId});

  EditOfficeDetails.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    isEditable = json['isEditable'];
    localUrl = json['localUrl'];
    name = json['name'];
    siteId = json['siteId'];
    spFrameUrl = json['spFrameUrl'];
    spLocation = json['spLocation'];
    spUrl = json['spUrl'];
    webId = json['webId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['isEditable'] = this.isEditable;
    data['localUrl'] = this.localUrl;
    data['name'] = this.name;
    data['siteId'] = this.siteId;
    data['spFrameUrl'] = this.spFrameUrl;
    data['spLocation'] = this.spLocation;
    data['spUrl'] = this.spUrl;
    data['webId'] = this.webId;
    return data;
  }
}
