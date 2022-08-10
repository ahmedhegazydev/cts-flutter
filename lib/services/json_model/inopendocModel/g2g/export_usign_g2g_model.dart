import 'package:cts/services/abstract_json_resource.dart';

import '../../../../models/DocumentModel.dart';

class ExportUsingG2gModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;

  ExportUsingG2gModel(
      {this.errorMessage,
        this.status,
      });

  ExportUsingG2gModel.fromJson(Map<String, dynamic> json) {
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

