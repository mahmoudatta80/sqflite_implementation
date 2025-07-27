import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/todo/data/models/todo_model.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;

  static const String tableName = 'todos';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    log('init database');
    log('==========================');
    _database = await initDatabase();
    return _database!;
  }

  Future initDatabase() async {
    final databasePath = await getDatabasesPath();
    final myDatabasseName = 'todo.db';
    final path = join(databasePath, myDatabasseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
    );
  }

  Future addTodo(TodoModel todo) async {
    Database db = await database;
    await db.insert(tableName, todo.toMap());
  }

  Future<List<TodoModel>> readTodos() async {
    Database db = await database;
    List todos = await db.query(tableName);
    return todos.map((item) => TodoModel.fromMap(item)).toList();
  }

  Future updataTodo(TodoModel todo) async {
    Database db = await database;
    await db.update(
      tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future deleteTodo(int id) async {
    Database db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
