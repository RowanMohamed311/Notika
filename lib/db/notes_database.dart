import 'package:daily_tasks/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  // global field (our instance) ==> calling our constructer
  // Static variables and methods are called with class names directly
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  // private constructer
  NotesDatabase._init();

  // to open a connection to our database and get it object.
  // are the class methods used to manipulate the data of the class fields. Getter is used to read or get the data of the class field.
  Future<Database> get database async {
    // return the database if it exists
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('notes.db');
    return _database!;
  }

  // initialize our database
  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    // create a path object.
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // define our schema.(our database table)
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
  CREATE TABLE $tableNotes(
    ${NoteFields.id} $idType, 
    ${NoteFields.isImportant} $boolType,
    ${NoteFields.title} $textType,
    ${NoteFields.ctime} $textType,
    ${NoteFields.mtime} $textType,
    ${NoteFields.description} $textType,
    ${NoteFields.isPrivate} $boolType,
    ${NoteFields.isArchived} $boolType,
    ${NoteFields.number} $integerType
  )
''');
  }

// First function of the CRUD "Create".
  Future<Note?> create(Note note) async {
    // create a reference from our database
    final db = await instance.database;
    // the database will generate a unique id for this new record(note) and return it.
    final id = await db.insert(
        tableNotes,
        /*define the data we want to put inside the database, converting a note object to a jason object*/
        note.toJson());
    return note.copy(id: id);
  }

  // Second Function of the CRUD "Read".
  Future<Note> readNote(int id) async {
    // create a reference from our database.
    final db = await instance.database;
    // 'query' return a list of maps "notes(json objects)" .
    final maps = await db.query(
      tableNotes,
      // column needs a list of strings, so in the model we created a field that contains all the columns' names which were already created in the model.
      columns: NoteFields.values,
      where: '${NoteFields.id} = ? ',
      // where arguments and by this the query will be more secure
      whereArgs: [id],
    );
    /* -check if our query was successful.
       -convert our json maps into notes once again. 
       -we return the first element from our list because we read only our first note.   
     */
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id NOT FOUND');
    }
  }

  // Read all notes
  Future<List<Note>?> readAllNotes() async {
    final db = await instance.database;
    // to retrieve all the notes in ascending order.
    const orderBy = '${NoteFields.ctime} ASC';
    // query with the table name only as we need all the notes
    final result = await db.query(tableNotes,
        where: '${NoteFields.isPrivate} = ?  AND ${NoteFields.isArchived} = ?',
        // where arguments and by this the query will be more secure
        whereArgs: [0, 0],
        orderBy: orderBy);
    //each map object is passed as a json object to return a Note objects in a LIST
    return result != null
        ? result.map((json) => Note.fromJson(json)).toList()
        : null;
  }

  Future<List<Note>?> readImportantNotes() async {
    final db = await instance.database;
    // to retrieve all the notes in ascending order.
    const orderBy = '${NoteFields.ctime} ASC';
    // query with the table name only as we need all the notes
    final result = await db.query(
      tableNotes,
      where: '${NoteFields.isImportant} = ? AND ${NoteFields.isPrivate} = ?',
      // where arguments and by this the query will be more secure
      whereArgs: [1, 0],
      orderBy: orderBy,
    );
    //each map object is passed as a json object to return a Note objects in a LIST
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>?> readArchivedNotes() async {
    final db = await instance.database;
    // to retrieve all the notes in ascending order.
    const orderBy = '${NoteFields.ctime} ASC';
    // query with the table name only as we need all the notes
    final result = await db.query(
      tableNotes,
      where: '${NoteFields.isArchived} = ? AND ${NoteFields.isPrivate} = ?',
      // where arguments and by this the query will be more secure
      whereArgs: [1, 0],
      orderBy: orderBy,
    );
    //each map object is passed as a json object to return a Note objects in a LIST
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>?> readPrivateNotes() async {
    final db = await instance.database;
    // to retrieve all the notes in ascending order.
    const orderBy = '${NoteFields.ctime} ASC';
    // query with the table name only as we need all the notes
    final result = await db.query(
      tableNotes,
      where: '${NoteFields.isPrivate} = ? ',
      // where arguments and by this the query will be more secure
      whereArgs: [1],
      orderBy: orderBy,
    );
    //each map object is passed as a json object to return a Note objects in a LIST
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<List<Note>?> SearchNotes(String sugg) async {
    final db = await instance.database;
    // to retrieve all the notes in ascending order.
    const orderBy = '${NoteFields.ctime} ASC';
    // query with the table name only as we need all the notes
    final result = await db.query(
      tableNotes,
      where: '${NoteFields.title} LIKE "r%"',
      // where arguments and by this the query will be more secure
      // whereArgs: [sugg],
      orderBy: orderBy,
    );
    //each map object is passed as a json object to return a Note objects in a LIST
    return result.map((json) => Note.fromJson(json)).toList();
  }

  // Third Function of CRUD "Update".
  Future<int?> update(Note note) async {
    final db = await instance.database;
    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  // Fourth Function of CRUD "Delete"
  Future<int?> delete(int? id) async {
    final db = await instance.database;
    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  // method to close our database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
