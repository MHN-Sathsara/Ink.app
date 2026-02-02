import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './models/note_model.dart';

class DbHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return db.execute('''
        CREATE TABLE notes(
          id TEXT PRIMARY KEY,
          title TEXT,
          content TEXT,
          isSynced INTEGER
        )
      ''');
      },
    );
  }

  Future<void> insertNote(Note note) async {
    final dbClient = await db;
    await dbClient.insert('notes', note.toMap());
  }

  Future<List<Note>> getLocalNotes() async {
    final dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('notes');
    return maps.map((e) => Note.fromMap(e)).toList();
  }
}
