import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/features/todo/logic/delete_todo_cubit/delete_todo_state.dart';

import '../../../../core/helper/database_helper.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  final DatabaseHelper databaseHelper;
  DeleteTodoCubit(this.databaseHelper) : super(DeleteTodoInitialState());

  Future deleteTodo(int id) async {
    try {
      await databaseHelper.deleteTodo(id);
      emit(DeleteTodoSuccessState());
    } catch (error) {
      emit(DeleteTodoFailureState(error.toString()));
    }
  }
}
