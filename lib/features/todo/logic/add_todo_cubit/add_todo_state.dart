abstract class AddTodoState {}

class AddTodoInitialState extends AddTodoState {}

class AddTodoSuccessState extends AddTodoState {}

class AddTodoFailureState extends AddTodoState {
  final String errorMessage;

  AddTodoFailureState(this.errorMessage);
}
