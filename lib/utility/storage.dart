
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'all_string_const.dart';


class SecureStorage  {

  //String  user_id = 'user_id';
  final box = GetStorage();
  String? token( )   {

    var readData =   box.read( AllStringConst.Token);
    return readData;
  }
  Future writeSecureData(String key,   value)  async {


    var writeData = await box.write( key,value);
    return writeData;
  }
  Future writeBoolData(String key, bool value)  async {


    var writeData = await box.write( key,value);
    return writeData;
  }
  bool readBoolData(String key)   {

    var readData =   box.read( key);
    if(readData==null)return false;
    return readData;
  }
  String? readSecureData(String key)   {

    var readData =   box.read( key);
    return readData;
  }
  Map<String,dynamic>? readSecureJsonData(String key)   {

    var readData =   box.read( key);
    return readData;
  }
  Future writeSecureJsonData(String key,   value)  async {


    var writeData = await box.write( key,value);
    return writeData;
  }
  Future deleteSecureData(String key) async{

    var deleteData = await box.remove( key);
    return deleteData;
  }
  int? readAppColor( )   {


    return box.read( AllStringConst.AppColor);
  }
}