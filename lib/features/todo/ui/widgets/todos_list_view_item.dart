import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/database_helper.dart';
import '../../data/models/todo_model.dart';
import '../../logic/delete_todo_cubit/delete_todo_cubit.dart';
import '../../logic/fetch_todos_cubit/fetch_todos_cubit.dart';
import '../../logic/update_todo_cubit/update_todo_cubit.dart';
import 'delete_todo_dialog.dart';
import 'update_todo_dialog.dart';

class TodosListViewItem extends StatelessWidget {
  final TodoModel todo;
  const TodosListViewItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(todo.id.toString(), style: TextStyle(fontSize: 24)),
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.0,
          children: [
            InkWell(
              child: const Icon(Icons.edit, color: Colors.black),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => UpdateTodoCubit(DatabaseHelper()),
                      ),
                      BlocProvider.value(
                        value: context.read<FetchTodosCubit>(),
                      ),
                    ],
                    child: UpdateTodoDialog(oldTodo: todo),
                  ),
                );
              },
            ),
            InkWell(
              child: const Icon(Icons.delete, color: Colors.red),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => DeleteTodoCubit(DatabaseHelper()),
                      ),
                      BlocProvider.value(
                        value: context.read<FetchTodosCubit>(),
                      ),
                    ],
                    child: DeleteTodoDialog(id: todo.id!),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
