import 'package:cts/services/abstract_json_resource.dart';

class GetUserRoutingModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  bool? doRouting;
  String? fromDate;
  String? toComments;
  String? toDate;
  String? toGctId;
  String? toName;

  GetUserRoutingModel(
      {this.errorMessage,
        this.status,
        this.doRouting,
        this.fromDate,
        this.toComments,
        this.toDate,
        this.toGctId,
        this.toName});

  GetUserRoutingModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    doRouting = json['DoRouting'];
    fromDate = json['FromDate'];
    toComments = json['ToComments'];
    toDate = json['ToDate'];
    toGctId = json['ToGctId'];
    toName = json['ToName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['DoRouting'] = this.doRouting;
    data['FromDate'] = this.fromDate;
    data['ToComments'] = this.toComments;
    data['ToDate'] = this.toDate;
    data['ToGctId'] = this.toGctId;
    data['ToName'] = this.toName;
    return data;
  }
}
