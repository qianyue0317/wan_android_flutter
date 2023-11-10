import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class MyTodoListPage extends StatefulWidget {
  const MyTodoListPage({Key? key}) : super(key: key);

  @override
  State createState() => _MyTodoListPageState();
}

class _MyTodoListPageState extends State<MyTodoListPage> {

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的待办", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: EasyRefresh.builder(
        controller: _refreshController,
        childBuilder: (context, physics) {
          return Padding(padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListView.builder(
              physics: physics,
              itemBuilder: (context, index) {
                return _generateItemLayout();
              },
              itemCount: 0,
            ));
        },
      ),
    );
  }

  Widget _generateItemLayout() {
    return Container();
  }
}
