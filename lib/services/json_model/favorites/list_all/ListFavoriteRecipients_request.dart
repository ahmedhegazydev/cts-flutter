import 'package:cts/services/abstract_json_resource.dart';

class ListFavoriteRecipientsRequest extends AbstractJsonResource {
  String? token;
  String? language;

  ListFavoriteRecipientsRequest(
      {required this.token,
        required this.language});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['Language'] = this.language;
    return data;
  }

  factory ListFavoriteRecipientsRequest.fromMap(Map<String, dynamic> map) {
    return ListFavoriteRecipientsRequest(
      token: map['Token'] as String,
      language: map['Language'] as String,
    );
  }
}
