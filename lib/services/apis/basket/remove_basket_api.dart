


import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';

import '../../json_model/basket/remove_basket_request_model.dart';

class PostRemoveBasketApi  extends ApiManager{
  String data="";
  @override
  String apiUrl() {
    return SettingsApp.PostRemoveBasketUrl ;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return RemoveBasketRequest.fromMap(data);
  }

}