import 'package:flutter/material.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';

import 'todo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper objectOne = DatabaseHelper();
  await objectOne.database;
  DatabaseHelper objectTwo = DatabaseHelper();
  await objectTwo.database;
  runApp(const TodoApp());
}
