import '../abstract_json_resource.dart';

class DefaultOnSuccessResult extends AbstractJsonResource {
  String? errorMessage;
  int? status;

  DefaultOnSuccessResult({this.errorMessage, this.status});

  DefaultOnSuccessResult.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    return data;
  }
}
