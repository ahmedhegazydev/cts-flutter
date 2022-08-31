
final String tableNotes = 'cts_settings';

class SettingsFields {
  static final List<String> values = [
    /// Add all fields
    id,
    // isImportant,
    // number,
    baseUrl,
    // description,
    // time
  ];

  static final String id = '_id';
  // static final String isImportant = 'isImportant';
  // static final String number = 'number';
  static final String baseUrl = 'baseUrl';
  // static final String description = 'description';
  // static final String time = 'time';
}

class SettingItem {
  final int? id;
  // final bool isImportant;
  // final int number;
  final String baseUrl;
  // final String description;
  // final DateTime createdTime;

  const SettingItem({
    this.id,
    // required this.isImportant,
    // required this.number,
    required this.baseUrl,
    // required this.description,
    // required this.createdTime,
  });

  SettingItem copy({
    int? id,
    // bool? isImportant,
    // int? number,
    String? baseUrl,
    // String? description,
    // DateTime? createdTime,
  }) =>
      SettingItem(
        id: id ?? this.id,
        // isImportant: isImportant ?? this.isImportant,
        // number: number ?? this.number,
        baseUrl: baseUrl ?? this.baseUrl,
        // description: description ?? this.description,
        // createdTime: createdTime ?? this.createdTime,
      );

  static SettingItem fromJson(Map<String, Object?> json) => SettingItem(
        id: json[SettingsFields.id] as int?,
        // isImportant: json[NoteFields.isImportant] == 1,
        // number: json[NoteFields.number] as int,
    baseUrl: json[SettingsFields.baseUrl] as String,
        // description: json[NoteFields.description] as String,
        // createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        SettingsFields.id: id,
        SettingsFields.baseUrl: baseUrl,
        // NoteFields.isImportant: isImportant ? 1 : 0,
        // NoteFields.number: number,
        // NoteFields.description: description,
        // NoteFields.time: createdTime.toIso8601String(),
      };
}