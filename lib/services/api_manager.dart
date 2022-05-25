import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart'  as a ;


import 'abstract_json_resource.dart';
import 'dio_singleton.dart';




abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();
  //final _storge= a.Get.find<SecureStorage>();
  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);

  Future<AbstractJsonResource?> getData({data}) async {

    AbstractJsonResource? json;
    var data;
    await dioSingleton.dio
        .get( apiUrl()  ,queryParameters: data )
        .then((value) {
        if(value.data["Status"]==0){
          a.Get.snackbar("Error".tr, "${value.data["ErrorMessage"]}");
        }else{


          print(value.data);
          data = value.data;
          json = fromJson(data);
        }


    });


    return json;
  }
/// POST DATA TO SERVER
  Future<AbstractJsonResource?> post(dataToPost) async {
    AbstractJsonResource? jsonList;
    var data;
    print("99"*10);
    print(jsonEncode(dataToPost));
    Options options = Options(headers: { "Accept": "application/json",

      'Content-Type': 'application/json',

    },);
    await dioSingleton.dio
        .post(
      apiUrl(),
      data: jsonEncode(dataToPost),
      options: options

      // Options(
      //     followRedirects: false,
      //     validateStatus: (status) {
      //       return status < 500;
      //     }),
    )
        .then((value) {
      if(value.data["Status"]==0){
        a.Get.snackbar("Error".tr, "${value.data["ErrorMessage"]}");
      }else{
        data = value.data;
        jsonList = fromJson(data);
      }
    });
  }
  //

}