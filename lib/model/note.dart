const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    isImportant,
    number,
    title,
    description,
    ctime,
    mtime,
    isPrivate,
    isArchived,
  ];
  // define all of our columns' name of our table
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String ctime = 'ctime';
  static const String mtime = 'mtime';
  static const String isPrivate = 'isPrivate';
  static const String isArchived = 'isArchived';
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  final DateTime modifiedTime;
  final bool isPrivate;
  final bool isArchived;
  // the fields that we want to store in our database
  Note(
      {this.id,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.createdTime,
      required this.modifiedTime,
      required this.isPrivate,
      required this.isArchived});

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    DateTime? modifiedTime,
    bool? isPrivate,
    bool? isArchived,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        modifiedTime: modifiedTime ?? this.modifiedTime,
        isPrivate: isPrivate ?? this.isPrivate,
        isArchived: isArchived ?? this.isArchived,
      );
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        isImportant: json[NoteFields.isImportant] == 1,
        createdTime: DateTime.parse(json[NoteFields.ctime] as String),
        modifiedTime: DateTime.parse(json[NoteFields.mtime] as String),
        isPrivate: json[NoteFields.isPrivate] == 1,
        isArchived: json[NoteFields.isArchived] == 1,
      );
  Map<String, Object?> toJson() => {
        //the keys(the name of the column in the database tables) : the values(the values of that column in the database tables)
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.number: number,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.ctime: createdTime.toIso8601String(),
        NoteFields.mtime: modifiedTime.toIso8601String(),
        NoteFields.isPrivate: isPrivate ? 1 : 0,
        NoteFields.isArchived: isArchived ? 1 : 0,
      };
}
