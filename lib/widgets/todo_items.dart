import 'package:flutter/material.dart';
import 'package:todo_list/helpers/dateHelper.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print('Clicked on Todo Item.');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        title: Flexible(
          child: Container(
            child: Visibility(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: DateHelper().dateFormart(todo.dateTime) != "",
                    child: Row(
                      children: [
                        Text(
                          DateHelper().dateFormart(todo.dateTime),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Icon(
                          Icons.notifications_active_outlined,
                          size: 18,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Text(
                    todo.todoText!,
                    style: TextStyle(
                      fontSize: 16,
                      color: tdBlack,
                      decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
