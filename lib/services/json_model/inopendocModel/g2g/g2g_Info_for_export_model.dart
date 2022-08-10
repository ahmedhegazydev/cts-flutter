import 'package:cts/services/abstract_json_resource.dart';

import '../../../../models/DocumentModel.dart';

class G2GInfoForExportModel extends AbstractJsonResource{



  String? errorMessage;
  int? status;
  // List<Attachments>? attachments;
  List<AttachmentsG2gInfoExport>? attachments;
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
    // if (json['attachments'] != null) {
    //   attachments = <Attachments>[];
    //   json['attachments'].forEach((v) {
    //     attachments!.add(new Attachments.fromJson(v));
    //   });
    // }
    if (json['attachments'] != null) {
      attachments = <AttachmentsG2gInfoExport>[];
      json['attachments'].forEach((v) {
        attachments!.add(new AttachmentsG2gInfoExport.fromJson(v));
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


class AttachmentsG2gInfoExport {
  AttachmentsG2gInfoExport({
    this.CopiedFrom_DOCID,
    this.CreateDate,
    this.CREATESTC,
    this.DOCCODE,
    this.DocumentKey,
    this.FileExtension,
    this.FileKey,
    this.FileName,
    this.FileOwner,
    this.FileStoragePath,
    this.Is_Signed,
    this.isBarcodeAdded,
    this.IsCurrentVersion,
    this.IsDMS,
    this.isPrivate,
    this.ISTEMPLATE,
    this.MajorVersion,
    this.MinorVersion,
    this.ModificationVersion,
    this.OrderBy,
    this.SPFILE_ID,
    this.SPSITE_ID,
    this.SPWEB_ID,
    this.StoragePath,
    this.StorageSpace,
    this.StructureGCTID,
  });
  late final String? CopiedFrom_DOCID;
  late final int? CreateDate;
  late final int? CREATESTC;
  late final String? DOCCODE;
  late final int? DocumentKey;
  late final String? FileExtension;
  late final int? FileKey;
  late final String? FileName;
  late final int? FileOwner;
  late final String? FileStoragePath;
  late final bool? Is_Signed;
  late final String? isBarcodeAdded;
  late final String? IsCurrentVersion;
  late final bool? IsDMS;
  late final bool? isPrivate;
  late final bool? ISTEMPLATE;
  late final int? MajorVersion;
  late final int? MinorVersion;
  late final int? ModificationVersion;
  late final int? OrderBy;
  late final String? SPFILE_ID;
  late final String? SPSITE_ID;
  late final String? SPWEB_ID;
  late final String? StoragePath;
  late final String? StorageSpace;
  late final int? StructureGCTID;

  AttachmentsG2gInfoExport.fromJson(Map<String, dynamic> json) {
    CopiedFrom_DOCID = json['CopiedFrom_DOCID'];
    CreateDate = json['CreateDate'];
    CREATESTC = json['CREATESTC'];
    DOCCODE = json['DOCCODE'];
    DocumentKey = json['DocumentKey'];
    FileExtension = json['FileExtension'];
    FileKey = json['FileKey'];
    FileName = json['FileName'];
    FileOwner = json['FileOwner'];
    FileStoragePath = json['FileStoragePath'];
    Is_Signed = json['Is_Signed'];
    isBarcodeAdded = json['isBarcodeAdded'];
    IsCurrentVersion = json['IsCurrentVersion'];
    IsDMS = json['IsDMS'];
    isPrivate = json['isPrivate'];
    ISTEMPLATE = json['ISTEMPLATE'];
    MajorVersion = json['MajorVersion'];
    MinorVersion = json['MinorVersion'];
    ModificationVersion = json['ModificationVersion'];
    OrderBy = json['OrderBy'];
    SPFILE_ID = json['SPFILE_ID'];
    SPSITE_ID = json['SPSITE_ID'];
    SPWEB_ID = json['SPWEB_ID'];
    StoragePath = json['StoragePath'];
    StorageSpace = json['StorageSpace'];
    StructureGCTID = json['StructureGCTID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CopiedFrom_DOCID'] = CopiedFrom_DOCID;
    _data['CreateDate'] = CreateDate;
    _data['CREATESTC'] = CREATESTC;
    _data['DOCCODE'] = DOCCODE;
    _data['DocumentKey'] = DocumentKey;
    _data['FileExtension'] = FileExtension;
    _data['FileKey'] = FileKey;
    _data['FileName'] = FileName;
    _data['FileOwner'] = FileOwner;
    _data['FileStoragePath'] = FileStoragePath;
    _data['Is_Signed'] = Is_Signed;
    _data['isBarcodeAdded'] = isBarcodeAdded;
    _data['IsCurrentVersion'] = IsCurrentVersion;
    _data['IsDMS'] = IsDMS;
    _data['isPrivate'] = isPrivate;
    _data['ISTEMPLATE'] = ISTEMPLATE;
    _data['MajorVersion'] = MajorVersion;
    _data['MinorVersion'] = MinorVersion;
    _data['ModificationVersion'] = ModificationVersion;
    _data['OrderBy'] = OrderBy;
    _data['SPFILE_ID'] = SPFILE_ID;
    _data['SPSITE_ID'] = SPSITE_ID;
    _data['SPWEB_ID'] = SPWEB_ID;
    _data['StoragePath'] = StoragePath;
    _data['StorageSpace'] = StorageSpace;
    _data['StructureGCTID'] = StructureGCTID;
    return _data;
  }
}

class DepartmentList {
  int? iD;
  int? childG2GID;
  int? childG2GParent;
  int? childGCTID;
  int? childGeid;
  String? childMapTo;
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
  String? childRedirectTo;
  String? childRedirectToGCTIDonReceive;
  bool? isCC;
  int? parentG2GID;
  int? parentGCTID;
  int? parentGeid;
  String? parentMapTo;
  String? parentName;
  int? parentParent;
  String? parentRedirectTo;
  String? parentRedirectToGCTIDonReceive;

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
