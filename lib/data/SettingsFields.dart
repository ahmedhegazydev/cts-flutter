class SettingsFields {
  static final List<String> values = [
    /// Add all fields
    id,
    // isImportant,
    // number,
    baseUrl,
    language,
    color
  ];

  static final String id = '_id';
  // static final String isImportant = 'isImportant';
  // static final String number = 'number';
  static final String baseUrl = 'baseUrl';
  static final String language = 'ar';
  static final String color = 'color';
}

class SettingItem {
  final int? id;
  // final bool isImportant;
  // final int number;
  final String baseUrl;
  final String color;
  final String language;
  // final DateTime createdTime;

  const SettingItem({
    this.id,
    // required this.number,
    required this.baseUrl,
    required this.language,
    required this.color,
    // required this.createdTime,
  });

  SettingItem copy({
    int? id,
    // bool? isImportant,
    // int? number,
    String? baseUrl,
    String? language,
    String? color,
    // DateTime? createdTime,
  }) =>
      SettingItem(
        id: id ?? this.id,
        // isImportant: isImportant ?? this.isImportant,
        // number: number ?? this.number,
        baseUrl: baseUrl ?? this.baseUrl,
        language: language ?? this.language,
        color: color ?? this.color,
        // createdTime: createdTime ?? this.createdTime,
      );

  static SettingItem fromJson(Map<String, Object?> json) => SettingItem(
        id: json[SettingsFields.id] as int?,
        // isImportant: json[NoteFields.isImportant] == 1,
        // number: json[NoteFields.number] as int,
        baseUrl: json[SettingsFields.baseUrl] as String,
        language: json[SettingsFields.language] as String,
        color: json[SettingsFields.color] as String,
        // createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        SettingsFields.id: id,
        SettingsFields.baseUrl: baseUrl,
        // NoteFields.isImportant: isImportant ? 1 : 0,
        // NoteFields.number: number,
        SettingsFields.language: language,
        SettingsFields.color: color,
        // NoteFields.time: createdTime.toIso8601String(),
      };
}
