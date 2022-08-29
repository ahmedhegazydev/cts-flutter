import 'package:cts/services/abstract_json_resource.dart';

class DashboardStatsResultModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  int? forActionCount;
  List<InboxCategories>? inboxCategories;
  String? mostTransfersWentTo;
  int? transferredFromMeCount;
  int? unreadCount;

  DashboardStatsResultModel(
      {this.errorMessage,
        this.status,
        this.forActionCount,
        this.inboxCategories,
        this.mostTransfersWentTo,
        this.transferredFromMeCount,
        this.unreadCount});

  DashboardStatsResultModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    forActionCount = json['ForActionCount'];
    if (json['InboxCategories'] != null) {
      inboxCategories = <InboxCategories>[];
      json['InboxCategories'].forEach((v) {
        inboxCategories!.add(new InboxCategories.fromJson(v));
      });
    }
    mostTransfersWentTo = json['MostTransfersWentTo'];
    transferredFromMeCount = json['TransferredFromMeCount'];
    unreadCount = json['UnreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['ForActionCount'] = this.forActionCount;
    if (this.inboxCategories != null) {
      data['InboxCategories'] =
          this.inboxCategories!.map((v) => v.toJson()).toList();
    }
    data['MostTransfersWentTo'] = this.mostTransfersWentTo;
    data['TransferredFromMeCount'] = this.transferredFromMeCount;
    data['UnreadCount'] = this.unreadCount;
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
