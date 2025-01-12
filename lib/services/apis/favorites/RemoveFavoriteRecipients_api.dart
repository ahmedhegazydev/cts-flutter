import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/favorites/list_all/ListFavoriteRecipients_response.dart';

class RemoveFavoriteRecipientsApi extends ApiManager {
  String data = "";

  RemoveFavoriteRecipientsApi(BuildContext context) : super();

  @override
  String apiUrl() {
    return SettingsApp.RemoveFavoriteRecipientsUrl + data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return ListFavoriteRecipientsResponse.fromJson(data);
  }
}
