import 'package:cts/services/abstract_json_resource.dart';

class RemoveFavoriteRecipientsRequest extends AbstractJsonResource {
  String? token;
  List<int?> ids;
  String? language;

  RemoveFavoriteRecipientsRequest(
      {required this.token,
        required this.ids,
        required this.language});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['ids'] = this.ids;
    data['Language'] = this.language;
    return data;
  }

  factory RemoveFavoriteRecipientsRequest.fromMap(Map<String, dynamic> map) {
    return RemoveFavoriteRecipientsRequest(
      token: map['Token'] as String,
      ids: map['ids'] as List<int>,
      language: map['Language'] as String,
    );
  }
}
