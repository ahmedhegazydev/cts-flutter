import 'package:shared_preferences/shared_preferences.dart';
import '../data/SettingsFields.dart';

class CtsSettingsDatabase {
  static final CtsSettingsDatabase instance = CtsSettingsDatabase._init();

  // static Database? _database;

  CtsSettingsDatabase._init();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> saveString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
    return value;
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.getString(key);
  }

  Future<SettingItem> create(SettingItem setting) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString("note.baseUrl", setting.baseUrl);
    prefs.setString("note.color", setting.color);
    prefs.setString("note.language", setting.language);
    return setting; //.copy(id: id);
  }

  Future<SettingItem> readNote(int id) async {
    SettingItem m = SettingItem(baseUrl: "", language: "", color: "");
    return m;
  }

  Future<List<SettingItem>> readAllNotes() async {
    final SharedPreferences prefs = await _prefs;

    final String? baseUrl = prefs.getString("note.baseUrl");
    final String? color = prefs.getString("note.color");
    final String? language = prefs.getString("note.language");
    if (baseUrl == null || color == null || language == null) {
      return [];
    }
    SettingItem m =
        SettingItem(baseUrl: baseUrl, language: language, color: color);

    return [m];
  }

  Future<int> update(SettingItem setting) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString("note.baseUrl", setting.baseUrl);
    prefs.setString("note.color", setting.color);
    prefs.setString("note.language", setting.language);

    return 1;
  }

  Future close() async {}
}
