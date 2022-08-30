import 'package:cts/services/abstract_json_resource.dart';

class ListFavoriteRecipientsResponse extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  List<FavoriteRecipientsDto>? Recipients;

  ListFavoriteRecipientsResponse(
      {this.errorMessage, this.status, this.Recipients});

  ListFavoriteRecipientsResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Recipients'] != null) {
      Recipients = <FavoriteRecipientsDto>[];
      json['Recipients'].forEach((v) {
        Recipients!.add(new FavoriteRecipientsDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.Recipients != null) {
      data['Recipients'] = this.Recipients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteRecipientsDto extends AbstractJsonResource {
  bool? UfrId;

  // public DateTime? UfrDate { get; set; }
  int? UfrAddedBy;
  String? AddedByName;
  String? TargetType;
  int? TargetGctid;
  String? TargetName;

  FavoriteRecipientsDto({
    this.UfrId,
    // this.color,
    this.UfrAddedBy,
    this.AddedByName,
    this.TargetType,
    this.TargetGctid,
    this.TargetName,
  });

  FavoriteRecipientsDto.fromJson(Map<String, dynamic> json) {
    UfrId = json['UfrId'];
    // color = json['Color'];
    UfrAddedBy = json['UfrAddedBy'];
    AddedByName = json['AddedByName'];
    TargetType = json['TargetType'];
    TargetGctid = json['TargetGctid'];
    TargetName = json['TargetName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UfrId'] = this.UfrId;
    // data['Color'] = this.color;
    data['UfrAddedBy'] = this.UfrAddedBy;
    data['AddedByName'] = this.AddedByName;
    data['TargetType'] = this.TargetType;
    data['TargetGctid'] = this.TargetGctid;
    data['TargetName'] = this.TargetName;
    return data;
  }
}
