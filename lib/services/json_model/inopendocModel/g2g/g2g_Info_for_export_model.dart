import 'package:cts/services/abstract_json_resource.dart';

import '../../../../models/DocumentModel.dart';

class G2GInfoForExportModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<Attachments>? attachments;
  List<DepartmentList>? departmentList;
  List<Parents>? parents;

  G2GInfoForExportModel(
      {this.errorMessage,
        this.status,
        this.attachments,
        this.departmentList,
        this.parents});

  G2GInfoForExportModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    if (json['departmentList'] != null) {
      departmentList = <DepartmentList>[];
      json['departmentList'].forEach((v) {
        departmentList!.add(new DepartmentList.fromJson(v));
      });
    }
    if (json['parents'] != null) {
      parents = <Parents>[];
      json['parents'].forEach((v) {
        parents!.add(new Parents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.departmentList != null) {
      data['departmentList'] =
          this.departmentList!.map((v) => v.toJson()).toList();
    }
    if (this.parents != null) {
      data['parents'] = this.parents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepartmentList {
  int? iD;
  int? childG2GID;
  int? childG2GParent;
  int? childGCTID;
  int? childGeid;
  int? childMapTo;
  String? childName;
  int? childRedirectTo;
  int? childRedirectToGCTIDonReceive;
  bool? isCC;
  int? parentG2GID;
  int? parentGCTID;
  int? parentGeid;
  String? parentMapTo;
  String? parentName;
  int? parentParent;
  int? parentRedirectTo;
  int? parentRedirectToGCTIDonReceive;

  DepartmentList(
      {this.iD,
        this.childG2GID,
        this.childG2GParent,
        this.childGCTID,
        this.childGeid,
        this.childMapTo,
        this.childName,
        this.childRedirectTo,
        this.childRedirectToGCTIDonReceive,
        this.isCC,
        this.parentG2GID,
        this.parentGCTID,
        this.parentGeid,
        this.parentMapTo,
        this.parentName,
        this.parentParent,
        this.parentRedirectTo,
        this.parentRedirectToGCTIDonReceive});

  DepartmentList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    childG2GID = json['child_G2G_ID'];
    childG2GParent = json['child_G2G_Parent'];
    childGCTID = json['child_GCT_ID'];
    childGeid = json['child_Geid'];
    childMapTo = json['child_MapTo'];
    childName = json['child_Name'];
    childRedirectTo = json['child_RedirectTo'];
    childRedirectToGCTIDonReceive = json['child_RedirectToGCT_IDonReceive'];
    isCC = json['isCC'];
    parentG2GID = json['parent_G2G_ID'];
    parentGCTID = json['parent_GCT_ID'];
    parentGeid = json['parent_Geid'];
    parentMapTo = json['parent_MapTo'];
    parentName = json['parent_Name'];
    parentParent = json['parent_Parent'];
    parentRedirectTo = json['parent_RedirectTo'];
    parentRedirectToGCTIDonReceive = json['parent_RedirectToGCT_IDonReceive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['child_G2G_ID'] = this.childG2GID;
    data['child_G2G_Parent'] = this.childG2GParent;
    data['child_GCT_ID'] = this.childGCTID;
    data['child_Geid'] = this.childGeid;
    data['child_MapTo'] = this.childMapTo;
    data['child_Name'] = this.childName;
    data['child_RedirectTo'] = this.childRedirectTo;
    data['child_RedirectToGCT_IDonReceive'] =
        this.childRedirectToGCTIDonReceive;
    data['isCC'] = this.isCC;
    data['parent_G2G_ID'] = this.parentG2GID;
    data['parent_GCT_ID'] = this.parentGCTID;
    data['parent_Geid'] = this.parentGeid;
    data['parent_MapTo'] = this.parentMapTo;
    data['parent_Name'] = this.parentName;
    data['parent_Parent'] = this.parentParent;
    data['parent_RedirectTo'] = this.parentRedirectTo;
    data['parent_RedirectToGCT_IDonReceive'] =
        this.parentRedirectToGCTIDonReceive;
    return data;
  }
}

class Parents {
  int? iD;
  int? childG2GID;
  int? childG2GParent;
  int? childGCTID;
  int? childGeid;
  String? childMapTo;
  String? childName;
  Null? childRedirectTo;
  Null? childRedirectToGCTIDonReceive;
  bool? isCC;
  int? parentG2GID;
  Null? parentGCTID;
  int? parentGeid;
  String? parentMapTo;
  String? parentName;
  int? parentParent;
  Null? parentRedirectTo;
  Null? parentRedirectToGCTIDonReceive;

  Parents(
      {this.iD,
        this.childG2GID,
        this.childG2GParent,
        this.childGCTID,
        this.childGeid,
        this.childMapTo,
        this.childName,
        this.childRedirectTo,
        this.childRedirectToGCTIDonReceive,
        this.isCC,
        this.parentG2GID,
        this.parentGCTID,
        this.parentGeid,
        this.parentMapTo,
        this.parentName,
        this.parentParent,
        this.parentRedirectTo,
        this.parentRedirectToGCTIDonReceive});

  Parents.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    childG2GID = json['child_G2G_ID'];
    childG2GParent = json['child_G2G_Parent'];
    childGCTID = json['child_GCT_ID'];
    childGeid = json['child_Geid'];
    childMapTo = json['child_MapTo'];
    childName = json['child_Name'];
    childRedirectTo = json['child_RedirectTo'];
    childRedirectToGCTIDonReceive = json['child_RedirectToGCT_IDonReceive'];
    isCC = json['isCC'];
    parentG2GID = json['parent_G2G_ID'];
    parentGCTID = json['parent_GCT_ID'];
    parentGeid = json['parent_Geid'];
    parentMapTo = json['parent_MapTo'];
    parentName = json['parent_Name'];
    parentParent = json['parent_Parent'];
    parentRedirectTo = json['parent_RedirectTo'];
    parentRedirectToGCTIDonReceive = json['parent_RedirectToGCT_IDonReceive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['child_G2G_ID'] = this.childG2GID;
    data['child_G2G_Parent'] = this.childG2GParent;
    data['child_GCT_ID'] = this.childGCTID;
    data['child_Geid'] = this.childGeid;
    data['child_MapTo'] = this.childMapTo;
    data['child_Name'] = this.childName;
    data['child_RedirectTo'] = this.childRedirectTo;
    data['child_RedirectToGCT_IDonReceive'] =
        this.childRedirectToGCTIDonReceive;
    data['isCC'] = this.isCC;
    data['parent_G2G_ID'] = this.parentG2GID;
    data['parent_GCT_ID'] = this.parentGCTID;
    data['parent_Geid'] = this.parentGeid;
    data['parent_MapTo'] = this.parentMapTo;
    data['parent_Name'] = this.parentName;
    data['parent_Parent'] = this.parentParent;
    data['parent_RedirectTo'] = this.parentRedirectTo;
    data['parent_RedirectToGCT_IDonReceive'] =
        this.parentRedirectToGCTIDonReceive;
    return data;
  }
}
