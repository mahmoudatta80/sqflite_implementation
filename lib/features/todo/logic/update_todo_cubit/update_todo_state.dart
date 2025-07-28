abstract class UpdateTodoState {}

class UpdateTodoInitialState extends UpdateTodoState {}

class UpdateTodoSuccessState extends UpdateTodoState {}

class UpdateTodoFailureState extends UpdateTodoState {
  final String errorMessage;

  UpdateTodoFailureState(this.errorMessage);
}
