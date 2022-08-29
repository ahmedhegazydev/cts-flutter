import 'package:cts/services/abstract_json_resource.dart';
import 'package:cts/services/api_manager.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utility/settings_app.dart';
import '../json_model/dashboard_stats_result_model.dart';

class DashboardStatsResultApi extends ApiManager{
  String data="";

  DashboardStatsResultApi({BuildContext? context}) : super(context: context);
  @override
  String apiUrl() {
    return SettingsApp.DashboardHomeUrl+data;
  }

  @override
  AbstractJsonResource fromJson(data) {
 return DashboardStatsResultModel.fromJson(data);
  }

}