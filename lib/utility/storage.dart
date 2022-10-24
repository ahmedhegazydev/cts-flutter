import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'all_string_const.dart';

class SecureStorage extends GetxController {
  static SecureStorage get to => Get.find<SecureStorage>();

  //String  user_id = 'user_id';
  final box = GetStorage();

  /**
   * read
   */
  int? readAppColor() {
    return box.read(AllStringConst.AppColor);
  }

  bool readBoolData(String key) {
    var readData = box.read(key);
    if (readData == null) return false;
    if (readData is bool) return readData as bool;
    return false;
  }

  String? readSecureData(String key) {
    var readData = box.read(key);
    return readData;
  }

  Future<String> readSecureDataAsync(String key) async {
    var readData = await box.read(key);
    return readData;
  }

  int? readIntSecureData(String key) {
    var readData = box.read(key);
    return readData;
  }

  Map<String, dynamic>? readSecureJsonData(String key) {
    var readData = box.read(key);
    return readData;
  }

  /**
   * write
   */
  Future writeSecureJsonData(String key, value) async {
    print("i save the $value");
    print("i save the $key");
    var writeData = await box.write(key, value);
    return writeData;
  }

  Future writeSecureData(String key, value) async {
    print("i save the $value");
    print("i save the $key");
    var writeData = await box.write(key, value);
    return writeData;
  }

  Future writeBoolData(String key, bool value) async {
    print("i save the $value");
    print("i save the $key");
    var writeData = await box.write(key, value);
    return writeData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await box.remove(key);
    return deleteData;
  }

  String? token() {
    var readData = box.read(AllStringConst.Token);
    return readData;
  }

  Future saveTokenWithTimeStamp(
      String key1, String value1, String key2, String value2) async {
    print("i save the $value1");
    print("i save the $key1");
    print("i save the $value2");
    print("i save the $key2");
    var token = await box.write(key1, value1);
    var time = await box.write(key2, value2);
    return [token, time];
  }

  List? getTokenWithTimeStamp(String key1, String key2) {
    var token = box.read(key1);
    var time = box.read(key2);
    return [token, time];
  }
}
