import '../../abstract_json_resource.dart';

class IsAlreadyExportedAsPaperworkModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  String? cceds;
  String? ccedsTitle;
  String? confirmMessage2;
  bool? isConfirm;
  String? message;
  String? noMethod;
  String? noMethod2;
  String? recipients;
  String? recipientsTitle;
  String? request;
  String? structures;
  String? structuresTitle;
  TransferTo? transferTo;
  String? yesMethod;
  String? yesMethod2;

  IsAlreadyExportedAsPaperworkModel(
      {this.errorMessage,
        this.status,
        this.cceds,
        this.ccedsTitle,
        this.confirmMessage2,
        this.isConfirm,
        this.message,
        this.noMethod,
        this.noMethod2,
        this.recipients,
        this.recipientsTitle,
        this.request,
        this.structures,
        this.structuresTitle,
        this.transferTo,
        this.yesMethod,
        this.yesMethod2});

  IsAlreadyExportedAsPaperworkModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    cceds = json['cceds'];
    ccedsTitle = json['ccedsTitle'];
    confirmMessage2 = json['confirmMessage2'];
    isConfirm = json['isConfirm'];
    message = json['message'];
    noMethod = json['noMethod'];
    noMethod2 = json['noMethod2'];
    recipients = json['recipients'];
    recipientsTitle = json['recipientsTitle'];
    request = json['request'];
    structures = json['structures'];
    structuresTitle = json['structuresTitle'];
    transferTo = json['transferTo'] != null
        ? new TransferTo.fromJson(json['transferTo'])
        : null;
    yesMethod = json['yesMethod'];
    yesMethod2 = json['yesMethod2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['cceds'] = this.cceds;
    data['ccedsTitle'] = this.ccedsTitle;
    data['confirmMessage2'] = this.confirmMessage2;
    data['isConfirm'] = this.isConfirm;
    data['message'] = this.message;
    data['noMethod'] = this.noMethod;
    data['noMethod2'] = this.noMethod2;
    data['recipients'] = this.recipients;
    data['recipientsTitle'] = this.recipientsTitle;
    data['request'] = this.request;
    data['structures'] = this.structures;
    data['structuresTitle'] = this.structuresTitle;
    data['transferTo'] = this.transferTo;
    data['yesMethod'] = this.yesMethod;
    data['yesMethod2'] = this.yesMethod2;
    return data;
  }
}
class TransferTo {
  int? id;
  String? structureName;

  TransferTo({this.id, this.structureName});

  TransferTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    structureName = json['structureName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['structureName'] = this.structureName;
    return data;
  }
}