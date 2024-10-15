import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,   
        content TEXT,
        isDone INTEGER
      )
    ''');
  }

  // Thêm todo
  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert(''
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Lấy tất cả todos
  Future<List<Todo>> getTodos() async {
    final db = await database;
    final List<Map<String, Object?>> todos = await db.query('todos');
    return [
      for (final {
        'id': id as int,
        'title': title as String,
        'content': content as String,
        'isDone': isDone as bool,
      } in todos)
        Todo(id, title, content, isDone),
    ];
  }

  // Cập nhật todo
  Future<int> updateTodo(Map<String, dynamic> todo) async {
    final db = await database;
    return await db.update(
      'todos',
      todo,
      where: 'id = ?',
      whereArgs: [todo['id']],
    );
  }

  // Xóa todo
  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}