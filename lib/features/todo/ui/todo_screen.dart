import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';
import 'package:sqflite_app/features/todo/logic/add_todo_cubit/add_todo_cubit.dart';
import 'package:sqflite_app/features/todo/logic/fetch_todos_cubit/fetch_todos_cubit.dart';
import 'package:sqflite_app/features/todo/logic/fetch_todos_cubit/fetch_todos_state.dart';

import 'widgets/add_todo_dialog.dart';
import 'widgets/todos_list_view_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BlocBuilder<FetchTodosCubit, FetchTodosState>(
          builder: (context, state) {
            if (state is FetchTodosSuccessState) {
              return ListView.separated(
                itemCount: state.todos.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return TodosListViewItem(todo: todo);
                },
              );
            } else if (state is FetchTodosFailureState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (con) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AddTodoCubit(DatabaseHelper()),
                ),
                BlocProvider.value(value: context.read<FetchTodosCubit>()),
              ],
              child: AddTodoDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
