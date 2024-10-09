import 'package:flutter/material.dart';
import 'package:todo_list/model/Todo.dart';

class TodoItem extends StatelessWidget {
  final Todo? todo;
  const TodoItem({super.key, this.todo});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: const Card(
        child: ListTile(
          leading: FlutterLogo(
            size: 40,
          ),
          title: Text("123"),
          subtitle: Text('Here is a second line'),
          trailing: Icon(Icons.more_vert)
        ),
      ),
    );
  }
}