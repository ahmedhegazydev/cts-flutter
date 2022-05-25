

import '../abstract_json_resource.dart';
import '../models/LoginModel.dart';

class LoginModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<CustomActions>? customActions;
  String? departmentName;
  String? firstName;
  Inbox? inbox;
  String? lastName;
  String? logoOffline;
  String? logoOnline;
  List<MultiSignatures>? multiSignatures;
  String? pincode;
  String? reportUrl;
  String? serviceType;
  String? signature;
  String? signatureId;
  String? token;
  TransferData? transferData;
  String? userDetails;
  String? userGuideUrl;
  int? userId;
  String? viewerURL;
  String? visualTrackingUrl;
  String? watermark;
  FeedbackText? feedbackText;
  String? termsAndConditions;
  bool? usePinCode;

  LoginModel(
      {this.errorMessage,
        this.status,
        this.customActions,
        this.departmentName,
        this.firstName,
        this.inbox,
        this.lastName,
        this.logoOffline,
        this.logoOnline,
        this.multiSignatures,
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
        this.usePinCode});

  LoginModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['CustomActions'] != null) {
      customActions = <CustomActions>[];
      json['CustomActions'].forEach((v) {
        customActions!.add(new CustomActions.fromJson(v));
      });
    }
    departmentName = json['DepartmentName'];
    firstName = json['FirstName'];
    inbox = json['Inbox'] != null ? new Inbox.fromJson(json['Inbox']) : null;
    lastName = json['LastName'];
    logoOffline = json['LogoOffline'];
    logoOnline = json['LogoOnline'];
    if (json['MultiSignatures'] != null) {
      multiSignatures = <MultiSignatures>[];
      json['MultiSignatures'].forEach((v) {
        multiSignatures!.add(new MultiSignatures.fromJson(v));
      });
    }
    pincode = json['Pincode'];
    reportUrl = json['ReportUrl'];
    serviceType = json['ServiceType'];
    signature = json['Signature'];
    signatureId = json['SignatureId'];
    token = json['Token'];
    transferData = json['TransferData'] != null
        ? new TransferData.fromJson(json['TransferData'])
        : null;
    userDetails = json['UserDetails'];
    userGuideUrl = json['UserGuideUrl'];
    userId = json['UserId'];
    viewerURL = json['ViewerURL'];
    visualTrackingUrl = json['VisualTrackingUrl'];
    watermark = json['Watermark'];
    feedbackText = json['feedbackText'] != null
        ? new FeedbackText.fromJson(json['feedbackText'])
        : null;
    termsAndConditions = json['termsAndConditions'];
    usePinCode = json['usePinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.customActions != null) {
      data['CustomActions'] =
          this.customActions!.map((v) => v.toJson()).toList();
    }
    data['DepartmentName'] = this.departmentName;
    data['FirstName'] = this.firstName;
    if (this.inbox != null) {
      data['Inbox'] = this.inbox!.toJson();
    }
    data['LastName'] = this.lastName;
    data['LogoOffline'] = this.logoOffline;
    data['LogoOnline'] = this.logoOnline;
    if (this.multiSignatures != null) {
      data['MultiSignatures'] =
          this.multiSignatures!.map((v) => v.toJson()).toList();
    }
    data['Pincode'] = this.pincode;
    data['ReportUrl'] = this.reportUrl;
    data['ServiceType'] = this.serviceType;
    data['Signature'] = this.signature;
    data['SignatureId'] = this.signatureId;
    data['Token'] = this.token;
    if (this.transferData != null) {
      data['TransferData'] = this.transferData!.toJson();
    }
    data['UserDetails'] = this.userDetails;
    data['UserGuideUrl'] = this.userGuideUrl;
    data['UserId'] = this.userId;
    data['ViewerURL'] = this.viewerURL;
    data['VisualTrackingUrl'] = this.visualTrackingUrl;
    data['Watermark'] = this.watermark;
    if (this.feedbackText != null) {
      data['feedbackText'] = this.feedbackText!.toJson();
    }
    data['termsAndConditions'] = this.termsAndConditions;
    data['usePinCode'] = this.usePinCode;
    return data;
  }
}

class CustomActions {
  String? icon;
  String? name;

  CustomActions({this.icon, this.name});

  CustomActions.fromJson(Map<String, dynamic> json) {
    icon = json['Icon'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Icon'] = this.icon;
    data['Name'] = this.name;
    return data;
  }
}

class Inbox {
  List<InboxItems>? inboxItems;

  Inbox({this.inboxItems});

  Inbox.fromJson(Map<String, dynamic> json) {
    if (json['InboxItems'] != null) {
      inboxItems = <InboxItems>[];
      json['InboxItems'].forEach((v) {
        inboxItems!.add(new InboxItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inboxItems != null) {
      data['InboxItems'] = this.inboxItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InboxItems {
  String? clickedIcon;
  String? icon;
  int? inboxId;
  String? name;
  int? total;

  InboxItems(
      {this.clickedIcon, this.icon, this.inboxId, this.name, this.total});

  InboxItems.fromJson(Map<String, dynamic> json) {
    clickedIcon = json['ClickedIcon'];
    icon = json['Icon'];
    inboxId = json['InboxId'];
    name = json['Name'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClickedIcon'] = this.clickedIcon;
    data['Icon'] = this.icon;
    data['InboxId'] = this.inboxId;
    data['Name'] = this.name;
    data['Total'] = this.total;
    return data;
  }
}

class MultiSignatures {
  int? cNTGctId;
  String? cONTENTTYPE;
  int? eSCOUNT;
  String? nAME;
  String? signature;
  String? tag;

  MultiSignatures(
      {this.cNTGctId,
        this.cONTENTTYPE,
        this.eSCOUNT,
        this.nAME,
        this.signature,
        this.tag});

  MultiSignatures.fromJson(Map<String, dynamic> json) {
    cNTGctId = json['CNTGctId'];
    cONTENTTYPE = json['CONTENT_TYPE'];
    eSCOUNT = json['ESCOUNT'];
    nAME = json['NAME'];
    signature = json['Signature'];
    tag = json['Tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CNTGctId'] = this.cNTGctId;
    data['CONTENT_TYPE'] = this.cONTENTTYPE;
    data['ESCOUNT'] = this.eSCOUNT;
    data['NAME'] = this.nAME;
    data['Signature'] = this.signature;
    data['Tag'] = this.tag;
    return data;
  }
}

class TransferData {
  List<Priorities>? priorities;
  List<Privacies>? privacies;
  List<Purposes>? purposes;
  List<Sections>? sections;
  List<Statuses>? statuses;

  TransferData(
      {this.priorities,
        this.privacies,
        this.purposes,
        this.sections,
        this.statuses});

  TransferData.fromJson(Map<String, dynamic> json) {
    if (json['Priorities'] != null) {
      priorities = <Priorities>[];
      json['Priorities'].forEach((v) {
        priorities!.add(new Priorities.fromJson(v));
      });
    }
    if (json['Privacies'] != null) {
      privacies = <Privacies>[];
      json['Privacies'].forEach((v) {
        privacies!.add(new Privacies.fromJson(v));
      });
    }
    if (json['Purposes'] != null) {
      purposes = <Purposes>[];
      json['Purposes'].forEach((v) {
        purposes!.add(new Purposes.fromJson(v));
      });
    }
    if (json['Sections'] != null) {
      sections = <Sections>[];
      json['Sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    if (json['Statuses'] != null) {
      statuses = <Statuses>[];
      json['Statuses'].forEach((v) {
        statuses!.add(new Statuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.priorities != null) {
      data['Priorities'] = this.priorities!.map((v) => v.toJson()).toList();
    }
    if (this.privacies != null) {
      data['Privacies'] = this.privacies!.map((v) => v.toJson()).toList();
    }
    if (this.purposes != null) {
      data['Purposes'] = this.purposes!.map((v) => v.toJson()).toList();
    }
    if (this.sections != null) {
      data['Sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.statuses != null) {
      data['Statuses'] = this.statuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Priorities {
  String? id;
  String? value;

  Priorities({this.id, this.value});

  Priorities.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Value'] = this.value;
    return data;
  }
}

class Sections {
  List<Sections>? destination;
  String? id;
  String? value;

  Sections({this.destination, this.id, this.value});

  Sections.fromJson(Map<String, dynamic> json) {
    if (json['Destination'] != null) {
      destination = <Sections>[];
      json['Destination'].forEach((v) {
        destination!.add(new Sections.fromJson(v));
      });
    }
    id = json['Id'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.destination != null) {
      data['Destination'] = this.destination!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Value'] = this.value;
    return data;
  }
}

class FeedbackText {
  String? app;
  String? details;
  String? id;
  String? keyword;
  String? notes;
  String? title;

  FeedbackText(
      {this.app, this.details, this.id, this.keyword, this.notes, this.title});

  FeedbackText.fromJson(Map<String, dynamic> json) {
    app = json['app'];
    details = json['details'];
    id = json['id'];
    keyword = json['keyword'];
    notes = json['notes'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app'] = this.app;
    data['details'] = this.details;
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    data['notes'] = this.notes;
    data['title'] = this.title;
    return data;
  }
}
