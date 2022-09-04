import '../../../abstract_json_resource.dart';

class ListFavoriteRecipientsResponse extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<Recipients>? recipients;

  ListFavoriteRecipientsResponse(
      {this.errorMessage, this.status, this.recipients});

  ListFavoriteRecipientsResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Recipients'] != null) {
      recipients = <Recipients>[];
      json['Recipients'].forEach((v) {
        recipients!.add(new Recipients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.recipients != null) {
      data['Recipients'] = this.recipients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipients {
  String? addedByName;
  int? targetGctid;
  String? targetName;
  String? targetPhotoBs64;
  String? targetType;
  int? ufrAddedBy;
  String? ufrDate;
  int? ufrId;

  Recipients(
      {this.addedByName,
        this.targetGctid,
        this.targetName,
        this.targetPhotoBs64,
        this.targetType,
        this.ufrAddedBy,
        this.ufrDate,
        this.ufrId});

  Recipients.fromJson(Map<String, dynamic> json) {
    addedByName = json['AddedByName'];
    targetGctid = json['TargetGctid'];
    targetName = json['TargetName'];
    targetPhotoBs64 = json['TargetPhotoBs64'];
    targetType = json['TargetType'];
    ufrAddedBy = json['UfrAddedBy'];
    ufrDate = json['UfrDate'];
    ufrId = json['UfrId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddedByName'] = this.addedByName;
    data['TargetGctid'] = this.targetGctid;
    data['TargetName'] = this.targetName;
    data['TargetPhotoBs64'] = this.targetPhotoBs64;
    data['TargetType'] = this.targetType;
    data['UfrAddedBy'] = this.ufrAddedBy;
    data['UfrDate'] = this.ufrDate;
    data['UfrId'] = this.ufrId;
    return data;
  }
}
