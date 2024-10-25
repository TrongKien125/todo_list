import 'package:todo_list/blocs/todo_event.dart';
import 'package:todo_list/blocs/todo_state.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoLoading()) {
    // Sử dụng async/await trong on<Event>
    on<ListTodos>((_event, emit) async {
      try {
        final tasks = await todoRepository.getToDoItems();
        emit(TodoLoaded(tasks));
      } catch (e) {
        emit(TodoError("Failed to fetch todos"));
      }
    });
    on<AddTodo>((_event, emit) async {
      await todoRepository.addToDoItem(_event.todo);
      final tasks = await todoRepository.getToDoItems();
      emit(TodoLoaded(tasks));
    });
  }
}