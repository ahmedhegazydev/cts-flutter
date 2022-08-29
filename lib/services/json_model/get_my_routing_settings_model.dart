import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';

import 'my_transfer_routing_dto_model.dart';

class GetMyRoutingSettingsModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  MyTransferRoutingDtoSend? routing;

  GetMyRoutingSettingsModel({this.errorMessage, this.status, this.routing});

  GetMyRoutingSettingsModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    routing = json['Routing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['Routing'] = this.routing;
    return data;
  }
}
