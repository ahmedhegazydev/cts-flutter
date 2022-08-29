


import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/settings_app.dart';
import '../../abstract_json_resource.dart';
import '../../api_manager.dart';
import '../../json_model/basket/fetch_basket_list_model.dart';

class GetFetchBasketListApi  extends ApiManager{
  GetFetchBasketListApi(BuildContext context) : super(context: context);


  @override
  String apiUrl() {
    return SettingsApp.PostRemoveItemsFromBasketUrl;
  }

  @override
  AbstractJsonResource fromJson(data) {
    return FetchBasketListModel.fromJson(data);
  }

}