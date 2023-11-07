import 'package:flutter/material.dart';

class MyTodoListPage extends StatefulWidget {
  const MyTodoListPage({Key? key}) : super(key: key);

  @override
  State createState() => _MyTodoListPageState();
}

class _MyTodoListPageState extends State<MyTodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的待办", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

    );
  }
}
