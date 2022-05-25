class LoginModel {
  late final String? errorMessage;
  late final int? status;
  late final List<CustomActions>? customActions;
  late final String? departmentName;
  late final String? firstName;
  late final Inbox? inbox;
  late final String? lastName;
  late final String? logoOffline;
  late final String? logoOnline;
  late final String? pincode;
  late final String? reportUrl;
  late final String? serviceType;
  late final String? signature;
  late final String? signatureId;
  late final String? token;
  late final TransferData? transferData;
  late final String? userDetails;
  late final String? userGuideUrl;
  late final int? userId;
  late final String? viewerURL;
  late final String? visualTrackingUrl;
  late final String? watermark;
  late final FeedbackText? feedbackText;
  late final String? termsAndConditions;
  late final bool? usePinCode;
  LoginModel({
    this.errorMessage,
    this.status,
    this.customActions,
    this.departmentName,
    this.firstName,
    this.inbox,
    this.lastName,
    this.logoOffline,
    this.logoOnline,
    this.pincode,
    this.reportUrl,
    this.serviceType,
    this.signature,
    this.signatureId,
    this.token,
    this.transferData,
    this.userDetails,
    this.userGuideUrl,
    this.userId,
    this.viewerURL,
    this.visualTrackingUrl,
    this.watermark,
    this.feedbackText,
    this.termsAndConditions,
    this.usePinCode,
  });

  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    customActions = List.from(json['CustomActions'])
        .map((e) => CustomActions.fromJson(e))
        .toList();
    departmentName = json['DepartmentName'];
    firstName = json['FirstName'];
    inbox = Inbox.fromJson(json['Inbox']);
    lastName = json['LastName'];
    logoOffline = json['LogoOffline'];
    logoOnline = json['LogoOnline'];
    pincode = json['Pincode'];
    reportUrl = json['ReportUrl'];
    serviceType = json['ServiceType'];
    signature = json['Signature'];
    signatureId = json['SignatureId'];
    token = json['Token'];
    transferData = TransferData.fromJson(json['TransferData']);
    userDetails = json['UserDetails'];
    userGuideUrl = json['UserGuideUrl'];
    userId = json['UserId'];
    viewerURL = json['ViewerURL'];
    visualTrackingUrl = json['VisualTrackingUrl'];
    watermark = json['Watermark'];
    feedbackText = FeedbackText.fromJson(json['feedbackText']);
    termsAndConditions = json['termsAndConditions'];
    usePinCode = json['usePinCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ErrorMessage'] = errorMessage;
    _data['Status'] = status;
    _data['CustomActions'] = customActions?.map((e) => e.toJson()).toList();
    _data['DepartmentName'] = departmentName;
    _data['FirstName'] = firstName;
    _data['Inbox'] = inbox?.toJson();
    _data['LastName'] = lastName;
    _data['LogoOffline'] = logoOffline;
    _data['LogoOnline'] = logoOnline;
    _data['Pincode'] = pincode;
    _data['ReportUrl'] = reportUrl;
    _data['ServiceType'] = serviceType;
    _data['Signature'] = signature;
    _data['SignatureId'] = signatureId;
    _data['Token'] = token;
    _data['TransferData'] = transferData?.toJson();
    _data['UserDetails'] = userDetails;
    _data['UserGuideUrl'] = userGuideUrl;
    _data['UserId'] = userId;
    _data['ViewerURL'] = viewerURL;
    _data['VisualTrackingUrl'] = visualTrackingUrl;
    _data['Watermark'] = watermark;
    _data['feedbackText'] = feedbackText?.toJson();
    _data['termsAndConditions'] = termsAndConditions;
    _data['usePinCode'] = usePinCode;
    return _data;
  }
}

class CustomActions {
  late final String? icon;
  late final String? name;
  CustomActions(
    this.icon,
    this.name,
  );

  CustomActions.fromJson(Map<dynamic, dynamic> json) {
    icon = json['Icon'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Icon'] = icon;
    _data['Name'] = name;
    return _data;
  }
}

class Inbox {
  late final List<InboxItems?> inboxItems;
  Inbox(
    this.inboxItems,
  );

  Inbox.fromJson(Map<dynamic, dynamic> json) {
    inboxItems = List.from(json['InboxItems'])
        .map((e) => InboxItems.fromJson(e))
        .toList();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['InboxItems'] = inboxItems.map((e) => e?.toJson()).toList();
    return _data;
  }
}

class InboxItems {
  late final String? clickedIcon;
  late final String? icon;
  late final int? inboxId;
  late final String? name;
  late final int? total;
  InboxItems(
    this.clickedIcon,
    this.icon,
    this.inboxId,
    this.name,
    this.total,
  );

  InboxItems.fromJson(Map<dynamic, dynamic> json) {
    clickedIcon = json['ClickedIcon'];
    icon = json['Icon'];
    inboxId = json['InboxId'];
    name = json['Name'];
    total = json['Total'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['ClickedIcon'] = clickedIcon;
    _data['Icon'] = icon;
    _data['InboxId'] = inboxId;
    _data['Name'] = name;
    _data['Total'] = total;
    return _data;
  }
}

class TransferData {
  late final List<Priorities?> priorities;
  late final List<Privacies?> privacies;
  late final List<Purposes?> purposes;
  late final List<Sections?> sections;
  late final List<Statuses?> statuses;
  TransferData(
    this.priorities,
    this.privacies,
    this.purposes,
    this.sections,
    this.statuses,
  );

  TransferData.fromJson(Map<dynamic, dynamic> json) {
    priorities = List.from(json['Priorities'])
        .map((e) => Priorities.fromJson(e))
        .toList();
    privacies =
        List.from(json['Privacies']).map((e) => Privacies.fromJson(e)).toList();
    purposes =
        List.from(json['Purposes']).map((e) => Purposes.fromJson(e)).toList();
    sections =
        List.from(json['Sections']).map((e) => Sections.fromJson(e)).toList();
    statuses =
        List.from(json['Statuses']).map((e) => Statuses.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['Priorities'] = priorities.map((e) => e?.toJson()).toList();
    _data['Privacies'] = privacies.map((e) => e?.toJson()).toList();
    _data['Purposes'] = purposes.map((e) => e?.toJson()).toList();
    _data['Sections'] = sections.map((e) => e?.toJson()).toList();
    _data['Statuses'] = statuses.map((e) => e?.toJson()).toList();
    return _data;
  }
}

class Priorities {
  late final String? id;
  late final String? value;
  Priorities(
    this.id,
    this.value,
  );

  Priorities.fromJson(Map<dynamic, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['Id'] = id;
    _data['Value'] = value;
    return _data;
  }
}

class Privacies {
  late final String? id;
  late final String? value;
  Privacies(
    this.id,
    this.value,
  );

  Privacies.fromJson(Map<dynamic, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['Id'] = id;
    _data['Value'] = value;
    return _data;
  }
}

class Purposes {
  late final String? id;
  late final String? value;
  Purposes(
    this.id,
    this.value,
  );

  Purposes.fromJson(Map<dynamic, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['Id'] = id;
    _data['Value'] = value;
    return _data;
  }
}

class Sections {
  late final List<dynamic> destination;
  late final String? id;
  late final String? value;
  Sections(
    this.destination,
    this.id,
    this.value,
  );

  Sections.fromJson(Map<dynamic, dynamic> json) {
    destination = List.castFrom<dynamic, dynamic>(json['Destination']);
    id = json['Id'];
    value = json['Value'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['Destination'] = destination;
    _data['Id'] = id;
    _data['Value'] = value;
    return _data;
  }
}

class Statuses {
  late final String? id;
  late final String? value;
  Statuses(
    this.id,
    this.value,
  );

  Statuses.fromJson(Map<dynamic, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['Id'] = id;
    _data['Value'] = value;
    return _data;
  }
}

class FeedbackText {
  FeedbackText({
    this.app,
    this.details,
    this.id,
    this.keyword,
    this.notes,
    this.title,
  });
  late final String? app;
  late final String? details;
  late final String? id;
  late final String? keyword;
  late final String? notes;
  late final String? title;

  FeedbackText.fromJson(Map<dynamic, dynamic> json) {
    app = json['app'];
    details = json['details'];
    id = json['id'];
    keyword = json['keyword'];
    notes = json['notes'];
    title = json['title'];
  }

  Map<dynamic, dynamic> toJson() {
    final _data = <dynamic, dynamic>{};
    _data['app'] = app;
    _data['details'] = details;
    _data['id'] = id;
    _data['keyword'] = keyword;
    _data['notes'] = notes;
    _data['title'] = title;
    return _data;
  }
}
