import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/article_item_layout.dart';
import 'package:wan_android_flutter/pages/detail_page.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key, required this.keyword}) : super(key: key);

  final String keyword;

  @override
  State createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  int _currentIndex = 0;

  List<ArticleItemEntity> data = [];

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  @override
  void initState() {
    super.initState();
    _searchRequest();
  }

  _searchRequest() async {
    AppResponse<ArticleDataEntity> res = await HttpGo.instance.post(
        "${Api.searchForKeyword}$_currentIndex/json",
        data: {"k": widget.keyword});
    if (_currentIndex == 0) {
      data.clear();
    }
    if (res.isSuccessful) {
      setState(() {
        data.addAll(res.data!.datas);
      });
    }
    _refreshController.finishRefresh();
    _refreshController.finishLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.keyword,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: EasyRefresh.builder(
        controller: _refreshController,
        childBuilder: (context, physics) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => Get.to(
                      () => DetailPage(data[index].link, data[index].title)),
                  child: ArticleItemLayout(
                        itemEntity: data[index], onCollectTap: () {}));
              },
              physics: physics, itemCount: data.length,);
        },
        onRefresh: () {
          _currentIndex = 0;
          _searchRequest();
        },
        onLoad: () {
          _currentIndex++;
          _searchRequest();
        },
      ),
    );
  }
}
