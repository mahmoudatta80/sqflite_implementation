abstract class DeleteTodoState {}

class DeleteTodoInitialState extends DeleteTodoState {}

class DeleteTodoSuccessState extends DeleteTodoState {}

class DeleteTodoFailureState extends DeleteTodoState {
  final String errorMessage;

  DeleteTodoFailureState(this.errorMessage);
}
