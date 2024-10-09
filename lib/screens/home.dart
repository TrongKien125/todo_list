import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/widgets/todo_items.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todoList = [
    Todo(1, "Morning Excercise", "2024", true, true),
    Todo(1, "Morning Excercise", "2024", true, true),
    Todo(1, "Check Emails", '123', true, true),
    Todo(1, "Work on mobile apps for 2 hour'", "2024", true, true),
    Todo(1, "Dinner with Jenny", "2024", true, true),
    Todo(1, "Check Emails", '123', true, true),
    Todo(1, "Work on mobile apps for 2 hour'", "2024", true, true),
    Todo(1, "Dinner with Jenny", "2024", true, true),
    Todo(1, "Check Emails", '123', true, true),
    Todo(1, "Work on mobile apps for 2 hour'", "2024", true, true),
    Todo(1, "Dinner with Jenny", "2024", true, true),
    Todo(1, "Check Emails", '123', true, true),
    Todo(1, "Work on mobile apps for 2 hour'", "2024", true, true),
    Todo(1, "Dinner with Jenny", "2024", true, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              'To-do list',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      for(Todo todo in todoList)
                        TodoItem(todo: todo)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const Icon(
              Icons.account_circle_outlined
            ),
          ),
        ),
      ]),
    );
  }
}