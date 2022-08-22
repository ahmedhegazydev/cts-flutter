import 'package:cts/services/abstract_json_resource.dart';

class RemoveBasketRequest extends AbstractJsonResource {
  String? token;
  int? basketId;
  String? language;

  RemoveBasketRequest(
      {required this.token, required this.basketId, required this.language});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['basketId'] = this.basketId;
    data['language'] = this.language;
    return data;
  }

  factory RemoveBasketRequest.fromMap(Map<String, dynamic> map) {
    return RemoveBasketRequest(
      token: map['token'] as String,
      basketId: map['basketId'] as int,
      language: map['language'] as String,
    );
  }
}
