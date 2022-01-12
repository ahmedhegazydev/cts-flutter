import 'dart:convert';


import 'package:cts/services/json_models/abstract_json_resource.dart';
import 'package:dio/dio.dart';


import '../dio_singleton.dart';


abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();

  /// Returns the API URL of current API ressource
  String apiUrl();

  AbstractJsonResource fromJson(data);

  Future<dynamic> getData({data}) async {

    AbstractJsonResource jsonList;
    var data;
    await dioSingleton.dio
        .get( apiUrl()  ,
            queryParameters:  data)
        .then((value) {
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }
/// POST DATA TO SERVER
  Future<Response<dynamic>> postData(dataToPost) async {
    print(jsonEncode(dataToPost));
    Options options = Options(headers: { "Accept": "application/json",

      'Content-Type': 'application/json',

    },);
    return dioSingleton.dio
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
          return value;
    });
  }


}
