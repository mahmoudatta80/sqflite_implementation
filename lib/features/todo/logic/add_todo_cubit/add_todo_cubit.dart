import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';
import 'package:sqflite_app/features/todo/data/models/todo_model.dart';
import 'package:sqflite_app/features/todo/logic/add_todo_cubit/add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final DatabaseHelper databaseHelper;
  TextEditingController addTitleController = TextEditingController();
  TextEditingController addDescriptionController = TextEditingController();
  AddTodoCubit(this.databaseHelper) : super(AddTodoInitialState());

  Future addTodo(TodoModel todo) async {
    try {
      await databaseHelper.addTodo(todo);
      emit(AddTodoSuccessState());
    } catch (error) {
      emit(AddTodoFailureState(error.toString()));
    }
  }

  @override
  Future<void> close() {
    addTitleController.dispose();
    addDescriptionController.dispose();
    return super.close();
  }
}
