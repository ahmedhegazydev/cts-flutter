import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';
import '../../json_model/favorites/add/AddFavoriteRecipients_response.dart';
import '../../json_model/favorites/list_all/ListFavoriteRecipients_response.dart';

class AddFavoriteRecipientsApi  extends ApiManager{
  String data="";

  AddFavoriteRecipientsApi(BuildContext context) : super();
  @override
  String apiUrl() {
    return SettingsApp.AddFavoriteRecipientsUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return AddFavoriteRecipientsResponse.fromJson(data);
  }

}