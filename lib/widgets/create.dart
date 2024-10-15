import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

import '../helper/database_helper.dart';
import '../model/Todo.dart';


class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  late Todo todo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        title: const Text("To-do"),
        content: Container(
          height: 200,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: FieldTextInput(
                    1,
                    'Title',
                    (value) {
                      setState(() {
                        todo.title = value; // Cập nhật giá trị tiêu đề
                      });
                    }
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: FieldTextInput(
                      3,
                      'Content',
                      (value) {
                        setState(() {
                          todo.content = value; // Cập nhật giá trị tiêu đề
                        });
                      }
                  )
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: creatTodo,
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text(
              "Close",
              style: TextStyle(
                color: tdGrey
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget FieldTextInput(int maxlines, String label, Function(String) onChange) {
    return TextField(
      maxLines: maxlines,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(
        fontSize: 15,
      ),
      onChanged: onChange,
    );
  }

  void creatTodo() async {
    final DatabaseHelper _dbHelper = DatabaseHelper();
    await _dbHelper.insertTodo(todo);
    Navigator.of(context).pop;
  }
}
