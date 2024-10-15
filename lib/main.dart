import 'package:flutter/material.dart';
import 'package:todo_list/helper/database_helper.dart';
import 'package:todo_list/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Khởi tạo cơ sở dữ liệu
  await DatabaseHelper().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      home: const Home(),
    );
  }
}
