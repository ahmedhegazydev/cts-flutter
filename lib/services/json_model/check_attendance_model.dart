import 'package:cts/services/abstract_json_resource.dart';

class CheckAttendanceRequestModel extends AbstractJsonResource {
  String? Token;

  int? UserId;

  String? Language;

  CheckAttendanceRequestModel({this.Token, this.UserId, this.Language});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['Token'] = this.Token;
    data['UserId'] = this.UserId;
    data['Language'] = this.Language;
    return data;
  }

  factory CheckAttendanceRequestModel.fromMap(Map<String, dynamic> map) {
    return CheckAttendanceRequestModel(
      Token: map['Token'],
      UserId: map['UserId'],
      Language: map['Language'],
    );
  }
}

class CheckAttendanceResponseModel extends AbstractJsonResource {
  bool? IsAvailable;

  CheckAttendanceResponseModel({this.IsAvailable});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['IsAvailable'] = this.IsAvailable;

    return data;
  }

  factory CheckAttendanceResponseModel.fromMap(Map<String, dynamic> map) {
    return CheckAttendanceResponseModel(
      IsAvailable: map['IsAvailable'],
    );
  }
}
