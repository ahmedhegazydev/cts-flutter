import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';
import '../../json_model/favorites/list_all/ListFavoriteRecipients_request.dart';
import '../../json_model/favorites/list_all/ListFavoriteRecipients_response.dart';

class ListFavoriteRecipientsApi  extends ApiManager{
  String data="";

  ListFavoriteRecipientsApi(BuildContext context) : super();
  @override
  String apiUrl() {
    return SettingsApp.ListFavoriteRecipientsUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return ListFavoriteRecipientsResponse.fromJson(data);
  }

}