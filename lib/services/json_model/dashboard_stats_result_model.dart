import 'package:cts/services/abstract_json_resource.dart';

class DashboardStatsResultModel extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  dashboardNode? forActionNode;

  List<InboxCategories>? inboxCategories;
  String? mostTransfersWentTo;
  int? transferredFromMeCount;
  dashboardNode? unreadNode;

  DashboardStatsResultModel(
      {this.errorMessage,
      this.status,
      this.forActionNode,
      this.inboxCategories,
      this.mostTransfersWentTo,
      this.transferredFromMeCount,
      this.unreadNode});

  DashboardStatsResultModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    forActionNode = json['ForActionNode'] != null
        ? new dashboardNode.fromJson(json['ForActionNode'])
        : null;
    if (json['InboxCategories'] != null) {
      inboxCategories = <InboxCategories>[];
      json['InboxCategories'].forEach((v) {
        inboxCategories!.add(new InboxCategories.fromJson(v));
      });
    }
    mostTransfersWentTo = json['MostTransfersWentTo'];
    transferredFromMeCount = json['TransferredFromMeCount'];
    unreadNode = json['UnreadNode'] != null
        ? new dashboardNode.fromJson(json['UnreadNode'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.forActionNode != null) {
      data['ForActionNode'] = this.forActionNode!.toJson();
    }
    if (this.inboxCategories != null) {
      data['InboxCategories'] =
          this.inboxCategories!.map((v) => v.toJson()).toList();
    }
    data['MostTransfersWentTo'] = this.mostTransfersWentTo;
    data['TransferredFromMeCount'] = this.transferredFromMeCount;
    if (this.unreadNode != null) {
      data['UnreadNode'] = this.unreadNode!.toJson();
    }
    return data;
  }
}

class InboxCategories {
  String? key;
  Value? value;

  InboxCategories({this.key, this.value});

  InboxCategories.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    value = json['Value'] != null ? new Value.fromJson(json['Value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    if (this.value != null) {
      data['Value'] = this.value!.toJson();
    }
    return data;
  }
}

class Value {
  int? count;
  String? name;
  int? nodeId;

  Value({this.count, this.name, this.nodeId});

  Value.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
    name = json['Name'];
    nodeId = json['NodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Count'] = this.count;
    data['Name'] = this.name;
    data['NodeId'] = this.nodeId;
    return data;
  }
}

class dashboardNode {
  int? count;
  String? name;
  int? nodeId;
  String? title;
  String? titleAr;

  dashboardNode({this.count, this.name, this.nodeId, this.title, this.titleAr});

  dashboardNode.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
    name = json['Name'];
    nodeId = json['NodeId'];
    title = json['Title'];
    titleAr = json['TitleAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Count'] = this.count;
    data['Name'] = this.name;
    data['NodeId'] = this.nodeId;
    data['Title'] = this.title;
    data['TitleAr'] = this.titleAr;
    return data;
  }
}
