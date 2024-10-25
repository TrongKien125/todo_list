import 'package:todo_list/model/Todo.dart';

abstract class TodoEvent {}

class ListTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final ToDo todo;
  AddTodo(this.todo);
}

class EditTodo extends TodoEvent {
  final ToDo todo;
  EditTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final ToDo todo;
  DeleteTodo(this.todo);
}