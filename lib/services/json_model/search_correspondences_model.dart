

import '../abstract_json_resource.dart';
import 'get_correspondences_model.dart';

class SearchCorrespondencesModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<Correspondences>? correspondences;
  int? total;

  SearchCorrespondencesModel(
      {this.errorMessage, this.status, this.correspondences, this.total});

  SearchCorrespondencesModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Correspondences'] != null) {
      correspondences = <Correspondences>[];
      json['Correspondences'].forEach((v) {
        correspondences!.add(new Correspondences.fromJson(v));
      });
    }
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ErrorMessage'] = errorMessage;
    data['Status'] = status;
    if (correspondences != null) {
      data['Correspondences'] =
          correspondences!.map((v) => v.toJson()).toList();
    }
    data['Total'] = total;
    return data;
  }
}
