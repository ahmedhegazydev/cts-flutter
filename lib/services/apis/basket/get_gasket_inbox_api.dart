


import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/get_basket_inbox_model.dart';

class GetBasketInboxApi  extends ApiManager{
  String data="";

  GetBasketInboxApi(BuildContext context) : super(context);
  @override
  String apiUrl() {
    return SettingsApp.GetBasketInboxUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    ///ToDo تغير الجسون
    return GetBasketInboxModel.fromJson(data);
  }

}