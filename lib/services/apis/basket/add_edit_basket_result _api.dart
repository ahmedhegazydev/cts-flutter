


import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';

class AddEditBasketFlagApi  extends ApiManager{
  AddEditBasketFlagApi(BuildContext context) : super(context);

  // String data="";
  @override
  String apiUrl() {
    // return SettingsApp.PostAddEditBasketFlagUrl+data;
    return SettingsApp.PostAddEditBasketFlagUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return Baskets.fromJson(data);
  }

}