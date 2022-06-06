import 'package:cts/services/abstract_json_resource.dart';

class GetDocumentLinksModel extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  List<Links>? links;

  GetDocumentLinksModel({this.errorMessage, this.status, this.links});

  GetDocumentLinksModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Links'] != null) {
      links = <Links>[];
      json['Links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.links != null) {
      data['Links'] = this.links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String? docDate;
  int? docId;
  String? docReference;
  String? docStatus;
  String? docSubject;
  String? linkDate;
  int? linkId;
  String? linkedBy;
  String? privacy;
  int? tsfId;

  Links(
      {this.docDate,
        this.docId,
        this.docReference,
        this.docStatus,
        this.docSubject,
        this.linkDate,
        this.linkId,
        this.linkedBy,
        this.privacy,
        this.tsfId});

  Links.fromJson(Map<String, dynamic> json) {
    docDate = json['docDate'];
    docId = json['docId'];
    docReference = json['doc_reference'];
    docStatus = json['doc_status'];
    docSubject = json['doc_subject'];
    linkDate = json['linkDate'];
    linkId = json['linkId'];
    linkedBy = json['linkedBy'];
    privacy = json['privacy'];
    tsfId = json['tsfId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docDate'] = this.docDate;
    data['docId'] = this.docId;
    data['doc_reference'] = this.docReference;
    data['doc_status'] = this.docStatus;
    data['doc_subject'] = this.docSubject;
    data['linkDate'] = this.linkDate;
    data['linkId'] = this.linkId;
    data['linkedBy'] = this.linkedBy;
    data['privacy'] = this.privacy;
    data['tsfId'] = this.tsfId;
    return data;
  }
}
