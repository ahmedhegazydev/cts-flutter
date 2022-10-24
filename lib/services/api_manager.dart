import 'dart:convert';
import 'dart:developer';

import 'package:cts/db/cts_database.dart';
import 'package:cts/utility/utilitie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as a;
import 'package:get/get_core/src/get_main.dart';

import '../data/SettingsFields.dart';
import '../screens/Login_page.dart';
import '../utility/all_string_const.dart';
import '../utility/storage.dart';
import 'abstract_json_resource.dart';
import 'dio_singleton.dart';

abstract class ApiManager {
  late BuildContext? context;

  late String storageBaseUrl =
      "http://ecm-mob.mofa.gov.qa:9091/Eversuite.CTS.Mobile2/CMS.svc";
  late List<SettingItem> settingItems;

  ApiManager({BuildContext? context}) {
    this.context = context;
  }

  final DioSingleton dioSingleton = DioSingleton();
  static SecureStorage secureStorage = new SecureStorage();

  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);

  Future<AbstractJsonResource?> getData(
      {
      // context,
      data}) async {
    AbstractJsonResource? json;
    var data;
    // print("checkIfSavedSettingsBasUrl = $checkIfSavedSettingsBasUrl");

    if (context != null) {
      // showLoaderDialog(context!);
    }

    this.settingItems = await CtsSettingsDatabase.instance.readAllNotes();
    if (settingItems.isNotEmpty) {
      storageBaseUrl = settingItems[0].baseUrl;
      print("storageBaseUrl = " + storageBaseUrl);
    }

    await dioSingleton.dio
        .get(checkIfSavedSettingsBasUrl(storageBaseUrl), queryParameters: data)
        .then((value) {
      if (context != null) {
        // Navigator.pop(context!);
      }
      // Get.back();
      if (value.data["Status"] == 0) {
        a.Get.snackbar("Error".tr, "${value.data["ErrorMessage"]}");
        // a.Get.snackbar("Error".tr, "tryAgain".tr);
      } else if (value.data["Status"] == 2) {
        a.Get.snackbar("Error".tr, "SessionExpired".tr);
        secureStorage.deleteSecureData(AllStringConst.Token);
        Get.offAll(LoginPage());
      } else if (value.data["Status"] == 1) {
        print(value);
        data = value.data;
        json = fromJson(data);
      }
    }).catchError((err) {
      a.Get.snackbar("", "$err");
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

    this.settingItems = await CtsSettingsDatabase.instance.readAllNotes();
    if (settingItems.isNotEmpty) {
      storageBaseUrl = settingItems[0].baseUrl;
      print("storageBaseUrl = " + storageBaseUrl);
    }
    log(jsonEncode(dataToPost));
    //showLoaderDialog(context!);
    await dioSingleton.dio
        .post(checkIfSavedSettingsBasUrl(storageBaseUrl),
            data: jsonEncode(dataToPost), options: options
            // Options(
            //     followRedirects: false,
            //     validateStatus: (status) {
            //       return status < 500;
            //     }),
            )
        .then((value) {
      if (context != null) {
        // Navigator.pop(context!);
      } // Get.back();
      if (value.data["Status"] == 0) {
        print(value);
        log("${value.data["ErrorMessage"]}");
        a.Get.snackbar("Error".tr, "${value.data["ErrorMessage"]}");
        // a.Get.snackbar("Error".tr, "tryAgain".tr);
      } else {
        if (value.data["Status"] == 2) {
          a.Get.snackbar("Error".tr, "SessionExpired".tr);
          Get.offAll(LoginPage());
        } else {
          data = value.data;
          jsonList = fromJson(data);
        }
      }
    });
    return jsonList;
  }

  String checkIfSavedSettingsBasUrl(String storageBaseUrl) {
    print("apiUrl = " + apiUrl());
    print("storageBaseUrl = " + storageBaseUrl);
    var fullPath = apiUrl();
    const start = "CMS.svc";
    var pos = fullPath.indexOf(start);
    String endPoint = (pos != -1)
        ? fullPath.substring(pos + start.length, fullPath.length)
        : fullPath;
    if (storageBaseUrl.isNotEmpty) {
      print("fullPath__ = " + storageBaseUrl + endPoint);
      return storageBaseUrl + endPoint;
    } else {
      return apiUrl();
    }
  }
}
