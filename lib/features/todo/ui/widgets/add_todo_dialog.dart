import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/features/todo/data/models/todo_model.dart';
import 'package:sqflite_app/features/todo/logic/add_todo_cubit/add_todo_cubit.dart';
import 'package:sqflite_app/features/todo/logic/add_todo_cubit/add_todo_state.dart';
import 'package:sqflite_app/features/todo/logic/fetch_todos_cubit/fetch_todos_cubit.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    AddTodoCubit addTodoCubit = context.read<AddTodoCubit>();
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: addTodoCubit.addTitleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: addTodoCubit.addDescriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if (state is AddTodoSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('todo added successfully')),
              );
              context.read<FetchTodosCubit>().fetchTodos();
            }
            if (state is AddTodoFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: ElevatedButton(
            onPressed: () async {
              TodoModel todo = TodoModel(
                title: addTodoCubit.addTitleController.text,
                description: addTodoCubit.addDescriptionController.text,
              );
              addTodoCubit.addTodo(todo);
            },
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }
}
