import '../../models/CorrespondencesModel.dart';
import '../abstract_json_resource.dart';

class GetCorrespondencesAllModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  Inbox? inbox;

  GetCorrespondencesAllModel({this.errorMessage, this.status, this.inbox});

  GetCorrespondencesAllModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    inbox = json['Inbox'] != null ? new Inbox.fromJson(json['Inbox']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.inbox != null) {
      data['Inbox'] = this.inbox!.toJson();
    }
    return data;
  }
}

class Inbox {
  List<Correspondences>? correspondences;
  String? id;
  int? total;

  Inbox({this.correspondences, this.id, this.total});

  Inbox.fromJson(Map<String, dynamic> json) {
    if (json['Correspondences'] != null) {
      correspondences = <Correspondences>[];
      json['Correspondences'].forEach((v) {
        correspondences!.add(Correspondences.fromJson(v));
      });
    }
    id = json['Id'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.correspondences != null) {
      data['Correspondences'] =
          this.correspondences!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Total'] = this.total;
    return data;
  }
}
