import '../abstract_json_resource.dart';

class CompleteInCorrespondenceModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;

  CompleteInCorrespondenceModel({this.errorMessage, this.status});

  CompleteInCorrespondenceModel.fromJson(Map<String, dynamic> json) {
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
