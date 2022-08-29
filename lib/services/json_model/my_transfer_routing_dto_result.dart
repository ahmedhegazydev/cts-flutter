import 'package:cts/services/abstract_json_resource.dart';

class MyTransferRoutingDto extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  Routing? routing;

  MyTransferRoutingDto({this.errorMessage, this.status, this.routing});

  MyTransferRoutingDto.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    routing =
    json['Routing'] != null ? new Routing.fromJson(json['Routing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.routing != null) {
      data['Routing'] = this.routing!.toJson();
    }
    return data;
  }
}

class Routing {
  String? crtComments;
  String? crtFromDate;
  int? crtId;
  String? crtToDate;
  int? crtToGctid;
  bool? doRouting;
  int? gctId;
  String? name;
  String? nameAr;

  Routing(
      {this.crtComments,
        this.crtFromDate,
        this.crtId,
        this.crtToDate,
        this.crtToGctid,
        this.doRouting,
        this.gctId,
        this.name,
        this.nameAr});

  Routing.fromJson(Map<String, dynamic> json) {
    crtComments = json['CrtComments'];
    crtFromDate = json['CrtFromDate'];
    crtId = json['CrtId'];
    crtToDate = json['CrtToDate'];
    crtToGctid = json['CrtToGctid'];
    doRouting = json['DoRouting'];
    gctId = json['GctId'];
    name = json['Name'];
    nameAr = json['NameAr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CrtComments'] = this.crtComments;
    data['CrtFromDate'] = this.crtFromDate;
    data['CrtId'] = this.crtId;
    data['CrtToDate'] = this.crtToDate;
    data['CrtToGctid'] = this.crtToGctid;
    data['DoRouting'] = this.doRouting;
    data['GctId'] = this.gctId;
    data['Name'] = this.name;
    data['NameAr'] = this.nameAr;
    return data;
  }
}
