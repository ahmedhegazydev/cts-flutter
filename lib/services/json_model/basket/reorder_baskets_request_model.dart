import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/json_model/basket/fetch_basket_list_model.dart';

class ReorderBasketsRequest extends AbstractJsonResource {
  String token;
  List<Baskets?> baskets;
  String language;

  ReorderBasketsRequest(
      {required this.token, required this.baskets, required this.language});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = this.token;
    data['baskets'] = this.baskets;
    data['language'] = this.language;
    return data;
  }

  factory ReorderBasketsRequest.fromMap(Map<String, dynamic> map) {
    return ReorderBasketsRequest(
      token: map['token'] as String,
      baskets: map['baskets'] as List<Baskets>,
      language: map['language'] as String,
    );
  }
}
