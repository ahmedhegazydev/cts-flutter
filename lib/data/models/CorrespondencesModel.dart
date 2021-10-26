class CorrespondencesModel {
  CorrespondencesModel({
    this.errorMessage,
    this.status,
    this.inbox,
  });
  late final String? errorMessage;
  late final int? status;
  late final Inbox? inbox;

  CorrespondencesModel.fromJson(Map<String, dynamic> json) {
    errorMessage = null;
    status = json['Status'];
    inbox = Inbox.fromJson(json['Inbox']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ErrorMessage'] = errorMessage;
    _data['Status'] = status;
    _data['Inbox'] = inbox?.toJson();
    return _data;
  }
}

class Inbox {
  Inbox({
    this.correspondences,
    this.id,
    this.total,
  });
  late final List<Correspondences>? correspondences;
  late final String? id;
  late final int? total;

  Inbox.fromJson(Map<String, dynamic> json) {
    correspondences = List.from(json['Correspondences'])
        .map((e) => Correspondences.fromJson(e))
        .toList();
    id = json['Id'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Correspondences'] = correspondences?.map((e) => e.toJson()).toList();
    _data['Id'] = id;
    _data['Total'] = total;
    return _data;
  }
}

class Correspondences {
  late final bool? canRequestDueDate;
  late final String? categoryId;
  late final bool? clickableLock;
  late final String? comments;
  late final ControlList? controlList;
  late final String? correspondenceId;
  late final String? docDueDate;
  late final int? docDueDays;
  late final String? fromStructure;
  late final String? fromUser;
  late final int? fromUserId;
  late final List<GridInfo>? gridInfo;
  late final bool? hasAttachments;
  late final bool? hasAttachmentsToBeDelivered;
  late final bool? hasSummaries;
  late final String? inboxId;
  late final bool? isCC;
  late final bool? isForGuideline;
  late final bool? isHighPriority;
  late final bool? isLocked;
  late final bool? isNew;
  late final List<Metadata>? metadata;
  late final String? priorityId;
  late final String? privacyId;
  late final String? purposeId;
  late final bool? showLock;
  late final int? status;
  late final String? thumbnailUrl;
  late final String? transferId;
  late final String? tsfDueDate;
  late final String? type;
  late final String? visualTrackingUrl;
  late final bool? isTransferedToContact;
  Correspondences({
    this.canRequestDueDate,
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
    this.isTransferedToContact,
  });

  Correspondences.fromJson(Map<String, dynamic> json) {
    canRequestDueDate = json['CanRequestDueDate'];
    categoryId = json['CategoryId'];
    clickableLock = json['ClickableLock'];
    comments = json['Comments'];
    controlList = ControlList.fromJson(json['ControlList']);
    correspondenceId = json['CorrespondenceId'];
    docDueDate = null;
    docDueDays = json['DocDueDays'];
    fromStructure = json['FromStructure'];
    fromUser = json['FromUser'];
    fromUserId = json['FromUserId'];
    gridInfo =
        List.from(json['GridInfo']).map((e) => GridInfo.fromJson(e)).toList();
    hasAttachments = json['HasAttachments'];
    hasAttachmentsToBeDelivered = json['HasAttachmentsToBeDelivered'];
    hasSummaries = json['HasSummaries'];
    inboxId = json['InboxId'];
    isCC = json['IsCC'];
    isForGuideline = json['IsForGuideline'];
    isHighPriority = json['IsHighPriority'];
    isLocked = json['IsLocked'];
    isNew = json['IsNew'];
    metadata =
        List.from(json['Metadata']).map((e) => Metadata.fromJson(e)).toList();
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
    final _data = <String, dynamic>{};
    _data['CanRequestDueDate'] = canRequestDueDate;
    _data['CategoryId'] = categoryId;
    _data['ClickableLock'] = clickableLock;
    _data['Comments'] = comments;
    _data['ControlList'] = controlList?.toJson();
    _data['CorrespondenceId'] = correspondenceId;
    _data['DocDueDate'] = docDueDate;
    _data['DocDueDays'] = docDueDays;
    _data['FromStructure'] = fromStructure;
    _data['FromUser'] = fromUser;
    _data['FromUserId'] = fromUserId;
    _data['GridInfo'] = gridInfo?.map((e) => e.toJson()).toList();
    _data['HasAttachments'] = hasAttachments;
    _data['HasAttachmentsToBeDelivered'] = hasAttachmentsToBeDelivered;
    _data['HasSummaries'] = hasSummaries;
    _data['InboxId'] = inboxId;
    _data['IsCC'] = isCC;
    _data['IsForGuideline'] = isForGuideline;
    _data['IsHighPriority'] = isHighPriority;
    _data['IsLocked'] = isLocked;
    _data['IsNew'] = isNew;
    _data['Metadata'] = metadata?.map((e) => e.toJson()).toList();
    _data['PriorityId'] = priorityId;
    _data['PrivacyId'] = privacyId;
    _data['PurposeId'] = purposeId;
    _data['ShowLock'] = showLock;
    _data['Status'] = status;
    _data['ThumbnailUrl'] = thumbnailUrl;
    _data['TransferId'] = transferId;
    _data['TsfDueDate'] = tsfDueDate;
    _data['Type'] = type;
    _data['VisualTrackingUrl'] = visualTrackingUrl;
    _data['isTransferedToContact'] = isTransferedToContact;
    return _data;
  }
}

class ControlList {
  ControlList(
    this.customToolbarItems,
    this.toolbarItems,
  );
  late final Null customToolbarItems;
  late final List<ToolbarItems?> toolbarItems;

  ControlList.fromJson(Map<String, dynamic> json) {
    customToolbarItems = null;
    // List.castFrom<dynamic, dynamic>(json['CustomToolbarItems']);
    toolbarItems = List.from(json['ToolbarItems'])
        .map((e) => ToolbarItems.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CustomToolbarItems'] = customToolbarItems;
    _data['ToolbarItems'] = toolbarItems.map((e) => e?.toJson()).toList();
    return _data;
  }
}

class ToolbarItems {
  ToolbarItems({
    this.children,
    this.display,
    this.label,
    this.name,
    this.quickAction,
  });
  late final Children? children;
  late final bool? display;
  late final String? label;
  late final String? name;
  late final bool? quickAction;

  ToolbarItems.fromJson(Map<String, dynamic> json) {
    children = null;
    display = json['Display'];
    label = null;
    name = json['Name'];
    quickAction = json['QuickAction'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Children'] = children;
    _data['Display'] = display;
    _data['Label'] = label;
    _data['Name'] = name;
    _data['QuickAction'] = quickAction;
    return _data;
  }
}

class Children {
  Children({
    this.customToolbarItems,
    this.toolbarItems,
  });
  late final String? customToolbarItems;
  late final List<ToolbarItems>? toolbarItems;

  Children.fromJson(Map<String, dynamic> json) {
    customToolbarItems = null;
    toolbarItems = List.from(json['ToolbarItems'])
        .map((e) => ToolbarItems.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CustomToolbarItems'] = customToolbarItems;
    _data['ToolbarItems'] = toolbarItems?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class GridInfo {
  late final String? label;
  late final String? value;
  GridInfo(
    this.label,
    this.value,
  );

  GridInfo.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Label'] = label;
    _data['Value'] = value;
    return _data;
  }
}

class Metadata {
  late final String? label;
  late final String? value;
  Metadata(
    this.label,
    this.value,
  );

  Metadata.fromJson(Map<String, dynamic> json) {
    label = json['Label'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Label'] = label;
    _data['Value'] = value;
    return _data;
  }
}