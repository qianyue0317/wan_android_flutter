import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/my_todo_data_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';

import '../base/base_page.dart';

class MyTodoListPage extends StatefulWidget {
  const MyTodoListPage({Key? key}) : super(key: key);

  @override
  State createState() => _MyTodoListPageState();
}

class _MyTodoListPageState extends State<MyTodoListPage> {
  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  final List<MyTodoDataItem> _data = [];

  int _currentIndex = 1;

  late final _dataObs = _data.obs;

  Future<bool> _requestData() async {
    AppResponse<MyTodoDataEntity> res =
        await HttpGo.instance.get("${Api.todoList}$_currentIndex/json");
    bool isRefresh = _currentIndex == 1;
    if (isRefresh) {
      _data.clear();
    }
    if (res.isSuccessful) {
      _data.addAll(res.data!.datas);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("我的待办", style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: _getBody()));
  }

  Widget _getBody() {
    return FutureBuilder(
        future: _requestData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == false) {
              return RetryWidget(onTapRetry: () {
                setState(() {});
              });
            }
            return _buildContent();
          } else {
            return const Center(
              widthFactor: 1,
              heightFactor: 1,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildContent() {
    if (_data.isEmpty) {
      return const EmptyWidget();
    }
    return EasyRefresh.builder(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      childBuilder: (context, physics) {
        return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Obx(() {
              // ignore: invalid_use_of_protected_member
              _dataObs.value;
              return ListView.builder(
                physics: physics,
                itemBuilder: (context, index) {
                  MyTodoDataItem item = _data[index];
                  return _generateItemLayout(item);
                },
                itemCount: _data.length,
              );
            }));
      },
    );
  }

  _onRefresh() async {
    _currentIndex = 1;
    await _requestData();
    _refreshController.finishRefresh();
    _dataObs.refresh();
  }

  _onLoad() async {
    _currentIndex++;
    await _requestData();
    _refreshController.finishLoad();
    _dataObs.refresh();
  }

  Widget _generateItemLayout(MyTodoDataItem item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          child: Text(item.title),
        )
      ],
    );
  }
}
