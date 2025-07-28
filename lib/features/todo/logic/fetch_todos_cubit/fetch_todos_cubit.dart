import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';

import 'fetch_todos_state.dart';

class FetchTodosCubit extends Cubit<FetchTodosState> {
  final DatabaseHelper databaseHelper;
  FetchTodosCubit(this.databaseHelper) : super(FetchTodosInitialState());

  Future fetchTodos() async {
    emit(FetchTodosLoadingState());
    try {
      final todos = await databaseHelper.readTodos();
      emit(FetchTodosSuccessState(todos));
    } catch (error) {
      emit(FetchTodosFailureState(error.toString()));
    }
  }
}
