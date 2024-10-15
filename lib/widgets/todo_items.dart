import 'package:flutter/material.dart';
import 'package:todo_list/model/Todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          title: Text(todo.title),
          subtitle: Text(todo.content),
          trailing: Checkbox(
              value: todo.isDone,
              onChanged: (value) => todo.isDone = false,
          )
        ),
      ),
    );
  }
}