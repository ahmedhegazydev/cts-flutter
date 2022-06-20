


import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';

class GetBasketInboxApi  extends ApiManager{
  String data="";
  @override
  String apiUrl() {
    return SettingsApp.GetBasketInboxUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    ///ToDo تغير الجسون
    return FetchBasketListModel.fromJson(data);
  }

}