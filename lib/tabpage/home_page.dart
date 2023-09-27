import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with BasePage<HomePage> {

  var _pageIndex = 0;

  List<ArticleItemEntity> _articleList = List.empty();

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.builder(
        controller: _refreshController,
        onRefresh: _refreshRequest,
        onLoad: _loadRequest,
        childBuilder: (context, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverList(delegate: SliverChildBuilderDelegate((context, index){
                return Center(
                  child: Text("条目：${_articleList[index].title}"),
                );
              }, childCount: _articleList.length))
            ],
          );
        },
      ),
    );
  }

  void _refreshRequest() async {
    _pageIndex = 0;
    AppResponse<ArticleDataEntity> res = await HttpGo.instance.get<
        ArticleDataEntity>("${Api.homePage}$_pageIndex/json");
    if (res.isSuccessful) {
      setState(() {
        _articleList = res.data?.datas ?? List.empty();
      });
    }
    _refreshController.finishRefresh();
  }

  void _loadRequest() async {
    _pageIndex++;
    AppResponse<ArticleDataEntity> res = await HttpGo.instance.get<
        ArticleDataEntity>("${Api.homePage}$_pageIndex/json");
    if (res.isSuccessful) {
      setState(() {
        _articleList.addAll(res.data?.datas ?? List.empty());
      });
    }
    _refreshController.finishLoad();
  }
}