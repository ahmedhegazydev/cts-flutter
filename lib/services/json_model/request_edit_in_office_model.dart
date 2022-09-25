import '../abstract_json_resource.dart';

class RequestEditInOfficeModel extends AbstractJsonResource {
  String? token;
  String? language;
  int? documentId;
  int? attachmentId;
  String? siteId;
  String? webId;
  String? fileId;

  RequestEditInOfficeModel(
      {this.token,
      this.language,
      this.documentId,
      this.attachmentId,
      this.siteId,
      this.webId,
      this.fileId});

  RequestEditInOfficeModel.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    language = json['Language'];
    documentId = json['DocumentId'];
    attachmentId = json['AttachmentId'];
    siteId = json['SiteId'];
    webId = json['WebId'];
    fileId = json['FileId'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['Language'] = this.language;
    data['DocumentId'] = this.documentId;
    data['AttachmentId'] = this.attachmentId;
    data['SiteId'] = this.siteId;
    data['WebId'] = this.webId;
    data['FileId'] = this.fileId;
    return data;
  }
}
