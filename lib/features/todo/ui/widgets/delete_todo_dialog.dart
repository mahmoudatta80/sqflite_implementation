import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/features/todo/logic/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:sqflite_app/features/todo/logic/delete_todo_cubit/delete_todo_state.dart';

import '../../logic/fetch_todos_cubit/fetch_todos_cubit.dart';

class DeleteTodoDialog extends StatelessWidget {
  final int id;
  const DeleteTodoDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    DeleteTodoCubit deleteTodoCubit = context.read<DeleteTodoCubit>();
    return AlertDialog(
      title: const Text('Delete Task'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        BlocListener<DeleteTodoCubit, DeleteTodoState>(
          listener: (context, state) {
            if (state is DeleteTodoSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('todo deleted successfully')),
              );
              context.read<FetchTodosCubit>().fetchTodos();
            }
            if (state is DeleteTodoFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: ElevatedButton(
            onPressed: () async {
              deleteTodoCubit.deleteTodo(id);
            },
            child: const Text('Delete'),
          ),
        ),
      ],
    );
  }
}
