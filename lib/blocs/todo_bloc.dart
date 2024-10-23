import 'package:todo_list/blocs/todo_event.dart';
import 'package:todo_list/blocs/todo_state.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   final TodoRepository todoRepository;
//
//   TodoBloc(this.todoRepository) : super(TodoLoading());
//
//   @override
//   Stream<TodoState> mapEventToState(TodoEvent event) async* {
//     if (event is ListTodos) {
//       final tasks = await todoRepository.getToDoItems();
//       yield TodoLoaded(tasks);
//     }
//     else if (event is CreateTodo) {
//         await todoRepository.addToDoItem(event.todo);
//         final tasks = await todoRepository.getToDoItems();
//         yield TodoLoaded(tasks);
//     };
//   }
// }