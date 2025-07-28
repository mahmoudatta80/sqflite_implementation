import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/features/todo/data/models/todo_model.dart';
import 'package:sqflite_app/features/todo/logic/update_todo_cubit/update_todo_cubit.dart';
import 'package:sqflite_app/features/todo/logic/update_todo_cubit/update_todo_state.dart';

import '../../logic/fetch_todos_cubit/fetch_todos_cubit.dart';

class UpdateTodoDialog extends StatelessWidget {
  final TodoModel oldTodo;
  const UpdateTodoDialog({super.key, required this.oldTodo});

  @override
  Widget build(BuildContext context) {
    UpdateTodoCubit updateTodoCubit = context.read<UpdateTodoCubit>();
    updateTodoCubit.updateTitleController.text = oldTodo.title;
    updateTodoCubit.updateDescriptionController.text = oldTodo.description;
    return AlertDialog(
      title: const Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: updateTodoCubit.updateTitleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: updateTodoCubit.updateDescriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        BlocListener<UpdateTodoCubit, UpdateTodoState>(
          listener: (context, state) {
            if (state is UpdateTodoSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('todo updated successfully')),
              );
              context.read<FetchTodosCubit>().fetchTodos();
            }
            if (state is UpdateTodoFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: ElevatedButton(
            onPressed: () async {
              TodoModel todo = TodoModel(
                id: oldTodo.id,
                title: updateTodoCubit.updateTitleController.text,
                description: updateTodoCubit.updateDescriptionController.text,
              );
              updateTodoCubit.updateTodo(todo);
            },
            child: const Text('Update'),
          ),
        ),
      ],
    );
  }
}
