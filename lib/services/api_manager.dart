import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as a;
import 'package:get/get_core/src/get_main.dart';

import '../screens/Login_page.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'abstract_json_resource.dart';
import 'dio_singleton.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  static SecureStorage secureStorage = new SecureStorage();

  //final _storge= a.Get.find<SecureStorage>();
  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);

  Future<AbstractJsonResource?> getData({data}) async {
    AbstractJsonResource? json;
    var data;
    print("checkIfSavedSettingsBasUrl = $checkIfSavedSettingsBasUrl");

    await dioSingleton.dio.get(checkIfSavedSettingsBasUrl(), queryParameters: data).then((value) {
      if (value.data["Status"] == 0) {
        a.Get.snackbar("Error".tr, "${value.data["ErrorMessage"]}");
      } else {
        if (value.data["Status"] == 2) {
          Get.to(LoginPage());
        }else {
          print(value);
          data = value.data;
          json = fromJson(data);
        }
      }
    });

    return json;
  }

  /// POST DATA TO SERVER
  Future<AbstractJsonResource?> post(dataToPost) async {
    AbstractJsonResource? jsonList;
    var data;

    Options options = Options(
      headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json',
      },
    );
    await dioSingleton.dio
        .post(apiUrl(), data: jsonEncode(dataToPost), options: options
            // Options(
            //     followRedirects: false,
            //     validateStatus: (status) {
            //       return status < 500;
            //     }),
            )
        .then((value) {
      if (value.data["Status"] == 0) {
        a.Get.snackbar("Error".tr, "${value.data["ErrorMessage"]}");
      } else {
        data = value.data;
        jsonList = fromJson(data);
      }
    });
    return jsonList;
  }

  String checkIfSavedSettingsBasUrl() {
    var storageBaseUrl = secureStorage.readSecureData(AllStringConst.BaseUrl) ?? "";
    if(storageBaseUrl.isNotEmpty){
      return storageBaseUrl;
    }
    return apiUrl();
  }

}
