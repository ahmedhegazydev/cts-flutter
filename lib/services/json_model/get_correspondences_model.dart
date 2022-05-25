

import '../../models/CorrespondencesModel.dart';
import '../abstract_json_resource.dart';

class GetCorrespondencesModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  Inbox? inbox;

  GetCorrespondencesModel({this.errorMessage, this.status, this.inbox});

  GetCorrespondencesModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    inbox = json['Inbox'] != null ? new Inbox.fromJson(json['Inbox']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.inbox != null) {
      data['Inbox'] = this.inbox!.toJson();
    }
    return data;
  }
}

class Inbox {
  List<Correspondences>? correspondences;
  String? id;
  int? total;

  Inbox({this.correspondences, this.id, this.total});

  Inbox.fromJson(Map<String, dynamic> json) {
    if (json['Correspondences'] != null) {
      correspondences = <Correspondences>[];
      json['Correspondences'].forEach((v) {
        correspondences!.add(new Correspondences.fromJson(v));
      });
    }
    id = json['Id'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.correspondences != null) {
      data['Correspondences'] =
          this.correspondences!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Total'] = this.total;
    return data;
  }
}

class Correspondences {
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
  Null? tsfDueDate;
  String? type;
  String? visualTrackingUrl;
  bool? isTransferedToContact;

  Correspondences(
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

  Correspondences.fromJson(Map<String, dynamic> json) {
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
      data['GridInfo'] = gridInfo!.map((v) => v.toJson()).toList();
    }
    data['HasAttachments'] = hasAttachments;
    data['HasAttachmentsToBeDelivered'] = hasAttachmentsToBeDelivered;
    data['HasSummaries'] = hasSummaries;
    data['InboxId'] = inboxId;
    data['IsCC'] = isCC;
    data['IsForGuideline'] = isForGuideline;
    data['IsHighPriority'] = isHighPriority;
    data['IsLocked'] = isLocked;
    data['IsNew'] = isNew;
    data['IsShareable'] = isShareable;
    if (metadata != null) {
      data['Metadata'] = metadata!.map((v) => v.toJson()).toList();
    }
    data['PriorityId'] = priorityId;
    data['PrivacyId'] = privacyId;
    data['PurposeId'] = purposeId;
    data['ShowLock'] = showLock;
    data['Status'] = status;
    data['ThumbnailUrl'] = thumbnailUrl;
    data['TransferId'] = transferId;
    data['TsfDueDate'] = tsfDueDate;
    data['Type'] = type;
    data['VisualTrackingUrl'] = visualTrackingUrl;
    data['isTransferedToContact'] = isTransferedToContact;
    return data;
  }
}

class ControlList {
  List<CustomToolbarItems>? customToolbarItems;
  List<ToolbarItems>? toolbarItems;

  ControlList({this.customToolbarItems, this.toolbarItems});

  ControlList.fromJson(Map<String, dynamic> json) {
    if (json['CustomToolbarItems'] != null) {
      customToolbarItems = <CustomToolbarItems>[];
      json['CustomToolbarItems'].forEach((v) {
        customToolbarItems!.add(new CustomToolbarItems.fromJson(v));
      });
    }
    if (json['ToolbarItems'] != null) {
      toolbarItems = <ToolbarItems>[];
      json['ToolbarItems'].forEach((v) {
        toolbarItems!.add(new ToolbarItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customToolbarItems != null) {
      data['CustomToolbarItems'] =
          this.customToolbarItems!.map((v) => v.toJson()).toList();
    }
    if (this.toolbarItems != null) {
      data['ToolbarItems'] = this.toolbarItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomToolbarItems {
  String? children;
  bool? display;
  String? label;
  String? name;
  bool? quickAction;

  CustomToolbarItems(
      {this.children, this.display, this.label, this.name, this.quickAction});

  CustomToolbarItems.fromJson(Map<String, dynamic> json) {
    children = json['Children'];
    display = json['Display'];
    label = json['Label'];
    name = json['Name'];
    quickAction = json['QuickAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Children'] = this.children;
    data['Display'] = this.display;
    data['Label'] = this.label;
    data['Name'] = this.name;
    data['QuickAction'] = this.quickAction;
    return data;
  }
}

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
