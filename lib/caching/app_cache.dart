import 'package:cts/caching/prefs_helper.dart';

class AppCache {
  static Future<dynamic> saveUserSignature(String userSignature) {
    var saveSignature = PreferencesHelper.setString("signature", userSignature);
    return saveSignature;
  }

  static Future<dynamic> saveUserToken(String userToken) {
    var saveToken = PreferencesHelper.setString("Token", userToken);
    return saveToken;
  }

  static Future<String> getSavedUserToken() async {
    var saveToken = await PreferencesHelper.getString("Token");
    return saveToken;
  }
}
