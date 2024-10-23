import 'package:todo_list/model/Todo.dart';

abstract class TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<ToDo> todos;
  TodoLoaded(this.todos);
}

class TaskError extends TodoState {
  final String message;

  TaskError(this.message);
}