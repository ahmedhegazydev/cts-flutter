

import '../abstract_json_resource.dart';

class FindRecipientModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<Sections>? sections;

  FindRecipientModel({this.errorMessage, this.status, this.sections});

  FindRecipientModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['Sections'] != null) {
      sections = <Sections>[];
      json['Sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.sections != null) {
      data['Sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  List<Destination>? destination;
  String? id;
  String? value;

  Sections({this.destination, this.id, this.value});

  Sections.fromJson(Map<String, dynamic> json) {
    if (json['Destination'] != null) {
      destination = <Destination>[];
      json['Destination'].forEach((v) {
        destination!.add(new Destination.fromJson(v));
      });
    }
    id = json['Id'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.destination != null) {
      data['Destination'] = this.destination!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Value'] = this.value;
    return data;
  }
}

class Destination {
  int? id;
  String? value;

  Destination({this.id, this.value});

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Value'] = this.value;
    return data;
  }
}
