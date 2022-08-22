import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';

class ReOrderBasketsApi  extends ApiManager{
  ReOrderBasketsApi(BuildContext context) : super(context);

  // String data="";
  @override
  String apiUrl() {
    // return SettingsApp.PostAddEditBasketFlagUrl+data;
    return SettingsApp.PostReorderBasketsUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    // return Baskets.fromJson(data);
    return FetchBasketListModel.fromJson(data);
  }

}