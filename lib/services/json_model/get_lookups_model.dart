import '../abstract_json_resource.dart';

class GetLookupsModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<Classifications>? classifications;
  List<DocCountries>? docCountries;
  List<PrimaryClassifications>? primaryClassifications;

  GetLookupsModel(
      {this.errorMessage,
        this.status,
        this.classifications,
        this.docCountries,
        this.primaryClassifications});

  GetLookupsModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Classifications'] != null) {
      classifications = <Classifications>[];
      json['Classifications'].forEach((v) {
        classifications!.add(new Classifications.fromJson(v));
      });
    }
    if (json['DocCountries'] != null) {
      docCountries = <DocCountries>[];
      json['DocCountries'].forEach((v) {
        docCountries!.add(new DocCountries.fromJson(v));
      });
    }
    if (json['PrimaryClassifications'] != null) {
      primaryClassifications = <PrimaryClassifications>[];
      json['PrimaryClassifications'].forEach((v) {
        primaryClassifications!.add(new PrimaryClassifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.classifications != null) {
      data['Classifications'] =
          this.classifications!.map((v) => v.toJson()).toList();
    }
    if (this.docCountries != null) {
      data['DocCountries'] = this.docCountries!.map((v) => v.toJson()).toList();
    }
    if (this.primaryClassifications != null) {
      data['PrimaryClassifications'] =
          this.primaryClassifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classifications {
  String? cLASCODE;
  int? cLASCREATEDBYCNT;
  int? cLASCREATEDBYSTC;
  String? cLASNAME;
  String? cLASNAMEDISPLAY;
  int? id;
  int? parentId;

  Classifications(
      {this.cLASCODE,
        this.cLASCREATEDBYCNT,
        this.cLASCREATEDBYSTC,
        this.cLASNAME,
        this.cLASNAMEDISPLAY,
        this.id,
        this.parentId});

  Classifications.fromJson(Map<String, dynamic> json) {
    cLASCODE = json['CLAS_CODE'];
    cLASCREATEDBYCNT = json['CLAS_CREATEDBY_CNT'];
    cLASCREATEDBYSTC = json['CLAS_CREATEDBY_STC'];
    cLASNAME = json['CLAS_NAME'];
    cLASNAMEDISPLAY = json['CLAS_NAME_DISPLAY'];
    id = json['Id'];
    parentId = json['ParentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CLAS_CODE'] = this.cLASCODE;
    data['CLAS_CREATEDBY_CNT'] = this.cLASCREATEDBYCNT;
    data['CLAS_CREATEDBY_STC'] = this.cLASCREATEDBYSTC;
    data['CLAS_NAME'] = this.cLASNAME;
    data['CLAS_NAME_DISPLAY'] = this.cLASNAMEDISPLAY;
    data['Id'] = this.id;
    data['ParentId'] = this.parentId;
    return data;
  }
}

class DocCountries {
  String? capitalName;
  String? code;
  int? id;
  String? name;
  String? nameDISPLAY;
  String? originalName;
  int? parentId;

  DocCountries(
      {this.capitalName,
        this.code,
        this.id,
        this.name,
        this.nameDISPLAY,
        this.originalName,
        this.parentId});

  DocCountries.fromJson(Map<String, dynamic> json) {
    capitalName = json['CapitalName'];
    code = json['Code'];
    id = json['Id'];
    name = json['Name'];
    nameDISPLAY = json['Name_DISPLAY'];
    originalName = json['OriginalName'];
    parentId = json['ParentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CapitalName'] = this.capitalName;
    data['Code'] = this.code;
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Name_DISPLAY'] = this.nameDISPLAY;
    data['OriginalName'] = this.originalName;
    data['ParentId'] = this.parentId;
    return data;
  }
}

class PrimaryClassifications {
  int? iD;
  String? pCLASCODE;
  int? pCLASID;
  String? pCLASNAME;

  PrimaryClassifications(
      {this.iD, this.pCLASCODE, this.pCLASID, this.pCLASNAME});

  PrimaryClassifications.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pCLASCODE = json['P_CLAS_CODE'];
    pCLASID = json['P_CLAS_ID'];
    pCLASNAME = json['P_CLAS_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['P_CLAS_CODE'] = this.pCLASCODE;
    data['P_CLAS_ID'] = this.pCLASID;
    data['P_CLAS_NAME'] = this.pCLASNAME;
    return data;
  }
}
