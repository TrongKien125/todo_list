import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/model/Todo.dart';

class TodoRepository {
  Database? _database;

  // init database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task TEXT,
        isCompleted INTEGER
      )
    ''');
  }
}