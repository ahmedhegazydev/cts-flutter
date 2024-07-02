import 'package:cts/services/abstract_json_resource.dart';

class AddFavoriteRecipientsRequest extends AbstractJsonResource {
  String? token;
  int? TargetGctId;
  String? language;

  AddFavoriteRecipientsRequest(
      {required this.token,
        required this.TargetGctId,
        required this.language});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['TargetGctId'] = this.TargetGctId;
    data['Language'] = this.language;
    return data;
  }

  factory AddFavoriteRecipientsRequest.fromMap(Map<String, dynamic> map) {
    return AddFavoriteRecipientsRequest(
      token: map['Token'] as String,
      TargetGctId: map['TargetGctId'] as int,
      language: map['Language'] as String,
    );
  }
}
