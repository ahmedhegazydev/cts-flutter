import 'package:cts/services/abstract_json_resource.dart';

import '../../models/CorrespondencesModel.dart';
import '../../models/DocumentModel.dart';

class CanOpenDocumentModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  bool? allow;
  Attachments? attachments;
  Correspondence? correspondence;

  CanOpenDocumentModel(
      {this.errorMessage,
        this.status,
        this.allow,
        this.attachments,
        this.correspondence});

  CanOpenDocumentModel.fromJson(Map<String, dynamic> json) {
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
//
// class Attachments {
//   String? errorMessage;
//   int? status;
//   List<Null>? attachments;
//   bool? isLocked;
//   String? lockedBy;
//   bool? hasVoice;
//   bool? isDocSigned;
//   String? voiceNote;
//
//   Attachments(
//       {this.errorMessage,
//         this.status,
//         this.attachments,
//         this.isLocked,
//         this.lockedBy,
//         this.hasVoice,
//         this.isDocSigned,
//         this.voiceNote});
//
//   Attachments.fromJson(Map<String, dynamic> json) {
//     errorMessage = json['ErrorMessage'];
//     status = json['Status'];
//     if (json['Attachments'] != null) {
//       attachments = <Null>[];
//       json['Attachments'].forEach((v) {
//         attachments!.add(new Null.fromJson(v));
//       });
//     }
//     isLocked = json['IsLocked'];
//     lockedBy = json['LockedBy'];
//     hasVoice = json['hasVoice'];
//     isDocSigned = json['isDocSigned'];
//     voiceNote = json['voiceNote'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ErrorMessage'] = this.errorMessage;
//     data['Status'] = this.status;
//     if (this.attachments != null) {
//       data['Attachments'] = this.attachments!.map((v) => v.toJson()).toList();
//     }
//     data['IsLocked'] = this.isLocked;
//     data['LockedBy'] = this.lockedBy;
//     data['hasVoice'] = this.hasVoice;
//     data['isDocSigned'] = this.isDocSigned;
//     data['voiceNote'] = this.voiceNote;
//     return data;
//   }
// }

class Correspondence {
  bool? canRequestDueDate;
  String? categoryId;
  bool? clickableLock;
  String? comments;
  ControlList? controlList;
  String? correspondenceId;
  String? docDueDate;
  int? docDueDays;
  String? fromStructure;
  String? fromUser;
  int? fromUserId;
  List<GridInfo>? gridInfo;
  bool? hasAttachments;
  bool? hasAttachmentsToBeDelivered;
  bool? hasSummaries;
  String? inboxId;
  bool? isCC;
  bool? isForGuideline;
  bool? isHighPriority;
  bool? isLocked;
  bool? isNew;
  bool? isShareable;
  List<Metadata>? metadata;
  String? priorityId;
  String? privacyId;
  String? purposeId;
  bool? showLock;
  int? status;
  String? thumbnailUrl;
  String? transferId;
  String? tsfDueDate;
  String? type;
  String? visualTrackingUrl;
  bool? isTransferedToContact;

  Correspondence(
      {this.canRequestDueDate,
        this.categoryId,
        this.clickableLock,
        this.comments,
        this.controlList,
        this.correspondenceId,
        this.docDueDate,
        this.docDueDays,
        this.fromStructure,
        this.fromUser,
        this.fromUserId,
        this.gridInfo,
        this.hasAttachments,
        this.hasAttachmentsToBeDelivered,
        this.hasSummaries,
        this.inboxId,
        this.isCC,
        this.isForGuideline,
        this.isHighPriority,
        this.isLocked,
        this.isNew,
        this.isShareable,
        this.metadata,
        this.priorityId,
        this.privacyId,
        this.purposeId,
        this.showLock,
        this.status,
        this.thumbnailUrl,
        this.transferId,
        this.tsfDueDate,
        this.type,
        this.visualTrackingUrl,
        this.isTransferedToContact});

  Correspondence.fromJson(Map<String, dynamic> json) {
    canRequestDueDate = json['CanRequestDueDate'];
    categoryId = json['CategoryId'];
    clickableLock = json['ClickableLock'];
    comments = json['Comments'];
    controlList = json['ControlList'] != null
        ? new ControlList.fromJson(json['ControlList'])
        : null;
    correspondenceId = json['CorrespondenceId'];
    docDueDate = json['DocDueDate'];
    docDueDays = json['DocDueDays'];
    fromStructure = json['FromStructure'];
    fromUser = json['FromUser'];
    fromUserId = json['FromUserId'];
    if (json['GridInfo'] != null) {
      gridInfo = <GridInfo>[];
      json['GridInfo'].forEach((v) {
        gridInfo!.add(new GridInfo.fromJson(v));
      });
    }
    hasAttachments = json['HasAttachments'];
    hasAttachmentsToBeDelivered = json['HasAttachmentsToBeDelivered'];
    hasSummaries = json['HasSummaries'];
    inboxId = json['InboxId'];
    isCC = json['IsCC'];
    isForGuideline = json['IsForGuideline'];
    isHighPriority = json['IsHighPriority'];
    isLocked = json['IsLocked'];
    isNew = json['IsNew'];
    isShareable = json['IsShareable'];
    if (json['Metadata'] != null) {
      metadata = <Metadata>[];
      json['Metadata'].forEach((v) {
        metadata!.add(new Metadata.fromJson(v));
      });
    }
    priorityId = json['PriorityId'];
    privacyId = json['PrivacyId'];
    purposeId = json['PurposeId'];
    showLock = json['ShowLock'];
    status = json['Status'];
    thumbnailUrl = json['ThumbnailUrl'];
    transferId = json['TransferId'];
    tsfDueDate = json['TsfDueDate'];
    type = json['Type'];
    visualTrackingUrl = json['VisualTrackingUrl'];
    isTransferedToContact = json['isTransferedToContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CanRequestDueDate'] = this.canRequestDueDate;
    data['CategoryId'] = this.categoryId;
    data['ClickableLock'] = this.clickableLock;
    data['Comments'] = this.comments;
    if (this.controlList != null) {
      data['ControlList'] = this.controlList!.toJson();
    }
    data['CorrespondenceId'] = this.correspondenceId;
    data['DocDueDate'] = this.docDueDate;
    data['DocDueDays'] = this.docDueDays;
    data['FromStructure'] = this.fromStructure;
    data['FromUser'] = this.fromUser;
    data['FromUserId'] = this.fromUserId;
    if (this.gridInfo != null) {
      data['GridInfo'] = this.gridInfo!.map((v) => v.toJson()).toList();
    }
    data['HasAttachments'] = this.hasAttachments;
    data['HasAttachmentsToBeDelivered'] = this.hasAttachmentsToBeDelivered;
    data['HasSummaries'] = this.hasSummaries;
    data['InboxId'] = this.inboxId;
    data['IsCC'] = this.isCC;
    data['IsForGuideline'] = this.isForGuideline;
    data['IsHighPriority'] = this.isHighPriority;
    data['IsLocked'] = this.isLocked;
    data['IsNew'] = this.isNew;
    data['IsShareable'] = this.isShareable;
    if (this.metadata != null) {
      data['Metadata'] = this.metadata!.map((v) => v.toJson()).toList();
    }
    data['PriorityId'] = this.priorityId;
    data['PrivacyId'] = this.privacyId;
    data['PurposeId'] = this.purposeId;
    data['ShowLock'] = this.showLock;
    data['Status'] = this.status;
    data['ThumbnailUrl'] = this.thumbnailUrl;
    data['TransferId'] = this.transferId;
    data['TsfDueDate'] = this.tsfDueDate;
    data['Type'] = this.type;
    data['VisualTrackingUrl'] = this.visualTrackingUrl;
    data['isTransferedToContact'] = this.isTransferedToContact;
    return data;
  }
}

class ControlList {
  Null? customToolbarItems;
  List<ToolbarItems>? toolbarItems;

  ControlList({this.customToolbarItems, this.toolbarItems});

  ControlList.fromJson(Map<String, dynamic> json) {
    customToolbarItems = json['CustomToolbarItems'];
    if (json['ToolbarItems'] != null) {
      toolbarItems = <ToolbarItems>[];
      json['ToolbarItems'].forEach((v) {
        toolbarItems!.add(new ToolbarItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomToolbarItems'] = this.customToolbarItems;
    if (this.toolbarItems != null) {
      data['ToolbarItems'] = this.toolbarItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ToolbarItems {
  ControlList? children;
  bool? display;
  String? label;
  String? name;
  bool? quickAction;

  ToolbarItems(
      {this.children, this.display, this.label, this.name, this.quickAction});

  ToolbarItems.fromJson(Map<String, dynamic> json) {
    children = json['Children'] != null
        ? new ControlList.fromJson(json['Children'])
        : null;
    display = json['Display'];
    label = json['Label'];
    name = json['Name'];
    quickAction = json['QuickAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['Children'] = this.children!.toJson();
    }
    data['Display'] = this.display;
    data['Label'] = this.label;
    data['Name'] = this.name;
    data['QuickAction'] = this.quickAction;
    return data;
  }
}
//
// class ToolbarItems {
//   Null? children;
//   bool? display;
//   String? label;
//   String? name;
//   bool? quickAction;
//
//   ToolbarItems(
//       {this.children, this.display, this.label, this.name, this.quickAction});
//
//   ToolbarItems.fromJson(Map<String, dynamic> json) {
//     children = json['Children'];
//     display = json['Display'];
//     label = json['Label'];
//     name = json['Name'];
//     quickAction = json['QuickAction'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Children'] = this.children;
//     data['Display'] = this.display;
//     data['Label'] = this.label;
//     data['Name'] = this.name;
//     data['QuickAction'] = this.quickAction;
//     return data;
//   }
// }

class GridInfo {
  String? label;
  String? value;

  GridInfo({this.label, this.value});

  GridInfo.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Label'] = this.label;
    data['Value'] = this.value;
    return data;
  }
}
