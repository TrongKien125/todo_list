abstract class TodoEvent {}

class ListTodos extends TodoEvent {}
class CreateTodo extends TodoEvent {}
class EditTodo extends TodoEvent {}
class DeleteTodo extends TodoEvent {}