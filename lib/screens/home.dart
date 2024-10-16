import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/Todo.dart';
import 'package:todo_list/widgets/todo_items.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  final _todoDate = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      // appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Todos',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _foundToDo.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(_foundToDo[index].id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  _deleteToDoItem(_foundToDo[index].id);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('ToDo item đã bị xóa')),
                                );
                              },
                              background: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red, // Màu nền khi vuốt
                                  borderRadius: BorderRadius.circular(15), // Bo tròn góc
                                ),
                                padding: EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Delete ', style: TextStyle(color: Colors.white)),
                                    Icon(Icons.delete, color: Colors.white),
                                  ],
                                ), // Biểu tượng xóa
                              ),
                              child: InkWell(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CreateTodo(_foundToDo[index]);
                                    },
                                  );
                                },
                            child: ToDoItem(
                              todo: _foundToDo[index],
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteToDoItem),
                              ),
                            );
                          }
                        ),
                      ),
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
          showDialog(
            context: context,
            builder: (_) {
              _todoController.clear();
              _todoDate.clear();
              return CreateTodo(null);
            },
          );
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem() {
    String toDo = _todoController.text;
    String date = _todoDate.text;
    setState(() {
      if(toDo.trim() == "") {
        return;
      }
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo.trim(),
        dateTime: date
      ));
    });
    Navigator.of(context).pop();
  }

  void _changeToDoItem(ToDo toDo) {
    String text = _todoController.text;
    String date = _todoDate.text;

    setState(() {
      if(text.trim() == "") {
        return;
      }
      toDo.todoText = text;
      toDo.dateTime = date;
    });
    Navigator.of(context).pop();
    _todoController.clear();
    _todoDate.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(
        top: 60,
        bottom: 20,
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
      ]),
    );
  }

  Widget CreateTodo(ToDo ?todo) {
    if (todo != null) {
      if (todo.dateTime != null) {
        _todoDate.text = todo.dateTime!;
      }
      _todoController.text = todo.todoText!;
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        title: const Text("To-do"),
        content: Container(
          height: 330,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: FieldTextInput(3, 'Add a new todo item'),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: DateTimePicker(
                  controller: _todoDate,
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }
                    return true;
                  },
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
              Transform.translate(
                offset: Offset(-15, 0),
                child: ListTile(
                  leading: Icon(Icons.notifications_active),
                  title: Text("Notification"),
                ),
              ),
              Transform.translate(
                offset: Offset(-15, 0),
                child: ListTile(
                  leading: Icon(Icons.done),
                  title: Text("Done"),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
          onPressed: () {
            if (todo != null) {
              _changeToDoItem(todo);
            } else {
              _addToDoItem();
            }
          },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _todoController.clear();
              _todoDate.clear();
            },
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

  Widget FieldTextInput(int maxlines, String label) {
    return TextField(
      maxLines: maxlines,
      controller: _todoController,
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
    );
  }
}