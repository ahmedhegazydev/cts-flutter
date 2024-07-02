import 'package:cts/services/abstract_json_resource.dart';

import '../../../models/CorrespondencesModel.dart';
import '../can_open_document_model.dart';

class GetBasketInboxModel extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  List<Correspondence>? correspondences;

  GetBasketInboxModel({this.errorMessage, this.status, this.correspondences});

  GetBasketInboxModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Correspondences'] != null) {
      correspondences = <Correspondence>[];
      json['Correspondences'].forEach((v) {
        correspondences!.add(new Correspondence.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.correspondences != null) {
      data['Correspondences'] =
          this.correspondences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ToolbarItems {
  Children? children;
  bool? display;
  String? label;
  String? name;
  bool? quickAction;

  ToolbarItems(
      {this.children, this.display, this.label, this.name, this.quickAction});

  ToolbarItems.fromJson(Map<String, dynamic> json) {
    children = json['Children'] != null
        ? new Children.fromJson(json['Children'])
        : null;
    display = json['Display'];
    label = json['Label'];
    name = json['Name'];
    quickAction = json['QuickAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['Children'] = this.children!.toJson();
    }
    data['Display'] = this.display;
    data['Label'] = this.label;
    data['Name'] = this.name;
    data['QuickAction'] = this.quickAction;
    return data;
  }
}

class Children {
  Null? customToolbarItems;
  List<ToolbarItems>? toolbarItems;

  Children({this.customToolbarItems, this.toolbarItems});

  Children.fromJson(Map<String, dynamic> json) {
    customToolbarItems = json['CustomToolbarItems'];
    if (json['ToolbarItems'] != null) {
      toolbarItems = <ToolbarItems>[];
      json['ToolbarItems'].forEach((v) {
        toolbarItems!.add(new ToolbarItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomToolbarItems'] = this.customToolbarItems;
    if (this.toolbarItems != null) {
      data['ToolbarItems'] = this.toolbarItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
