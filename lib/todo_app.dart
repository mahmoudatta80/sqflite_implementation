import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';
import 'package:sqflite_app/features/todo/logic/fetch_todos_cubit/fetch_todos_cubit.dart';

import 'features/todo/ui/todo_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: BlocProvider(
        create: (context) => FetchTodosCubit(DatabaseHelper())..fetchTodos(),
        child: const TodoScreen(),
      ),
    );
  }
}
