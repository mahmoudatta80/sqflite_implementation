import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';
import 'package:sqflite_app/features/todo/logic/update_todo_cubit/update_todo_state.dart';

import '../../data/models/todo_model.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  final DatabaseHelper databaseHelper;
  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();
  UpdateTodoCubit(this.databaseHelper) : super(UpdateTodoInitialState());

  Future updateTodo(TodoModel todo) async {
    try {
      await databaseHelper.updataTodo(todo);
      emit(UpdateTodoSuccessState());
    } catch (error) {
      emit(UpdateTodoFailureState(error.toString()));
    }
  }

  @override
  Future<void> close() {
    updateTitleController.dispose();
    updateDescriptionController.dispose();
    return super.close();
  }
}
