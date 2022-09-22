import 'package:shared_preferences/shared_preferences.dart';
import '../data/SettingsFields.dart';

class CtsSettingsDatabase {
  static final CtsSettingsDatabase instance = CtsSettingsDatabase._init();

  // static Database? _database;

  CtsSettingsDatabase._init();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future<Database> get database async {
  //   if (_database != null) return _database!;

  //   _database = await _initDB('notes.db');
  //   return _database!;
  // }

  // Future<Database> _initDB(String filePath) async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, filePath);

  //   return await openDatabase(path, version: 1, onCreate: _createDB);
  // }

//   Future _createDB(Database db, int version) async {
//     final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     final textType = 'TEXT NOT NULL';
//     final boolType = 'BOOLEAN NOT NULL';
//     final integerType = 'INTEGER NOT NULL';

//     await db.execute('''
// CREATE TABLE $tableNotes (
//   ${SettingsFields.id} $idType,
//   ${SettingsFields.baseUrl} $textType,
//   ${SettingsFields.language} $textType,
//   ${SettingsFields.color} $textType
//   )
// ''');
//   }

  Future<SettingItem> create(SettingItem setting) async {
    final SharedPreferences prefs = await _prefs;

    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    // final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    prefs.setString("note.baseUrl", setting.baseUrl);
    prefs.setString("note.color", setting.color);
    prefs.setString("note.language", setting.language);
    //final id = await db.insert(tableNotes, note.toJson());
    return setting; //.copy(id: id);
  }

  Future<SettingItem> readNote(int id) async {
    final SharedPreferences prefs = await _prefs;

    // prefs.setString("note.baseUrl", setting.baseUrl);
    // prefs.setString("note.color", setting.color);
    // prefs.setString("note.language", setting.language);

    final String? baseUrl = prefs.getString("note.baseUrl");
    final String? color = prefs.getString("note.color");
    final String? language = prefs.getString("note.language");

    // final db = await instance.database;

    // final maps = await db.query(
    //   tableNotes,
    //   columns: SettingsFields.values,
    //   where: '${SettingsFields.id} = ?',
    //   whereArgs: [id],
    // );

    // if (maps.isNotEmpty) {
    //   return SettingItem.fromJson(maps.first);
    // } else {
    //   throw Exception('ID $id not found');
    // }

    SettingItem m = SettingItem(baseUrl: "", language: "", color: "");
    return m;
  }

  Future<List<SettingItem>> readAllNotes() async {
    // final db = await instance.database;

    // final result = await db.query(tableNotes);

    // return result.map((json) => SettingItem.fromJson(json)).toList();

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

  Future close() async {
    // final db = await instance.database;
    // db.close();
  }
}
