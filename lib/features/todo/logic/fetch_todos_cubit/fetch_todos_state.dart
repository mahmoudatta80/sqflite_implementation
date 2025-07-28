import 'package:sqflite_app/features/todo/data/models/todo_model.dart';

abstract class FetchTodosState {}

class FetchTodosInitialState extends FetchTodosState {}

class FetchTodosLoadingState extends FetchTodosState {}

class FetchTodosSuccessState extends FetchTodosState {
  final List<TodoModel> todos;

  FetchTodosSuccessState(this.todos);
}

class FetchTodosFailureState extends FetchTodosState {
  final String errorMessage;

  FetchTodosFailureState(this.errorMessage);
}
