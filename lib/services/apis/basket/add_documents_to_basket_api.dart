


import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';

class AddEDocumentsToBasketApi  extends ApiManager{
  String data="";

  AddEDocumentsToBasketApi(BuildContext context) : super(context);
  @override
  String apiUrl() {
    return SettingsApp.PostAddDocumentsToBasketUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
    print(data);
    return Baskets.fromJson(data);
  }

}