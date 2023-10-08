import 'package:easy_refresh/easy_refresh.dart';
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
  void initState() {
    super.initState();
    _refreshRequest();
  }

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
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return _generateItemView(context, index);
              }, childCount: _articleList.length))
            ],
          );
        },
      ),
    );
  }

  Widget _generateItemView(BuildContext context, int index) {
    ArticleItemEntity itemEntity = _articleList[index];
    StringBuffer sb = StringBuffer(itemEntity.superChapterName ?? "");
    if (sb.isNotEmpty &&
        itemEntity.chapterName != null &&
        itemEntity.chapterName!.isNotEmpty) {
      sb.write("·");
    }
    sb.write(itemEntity.chapterName ?? "");
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          shadowColor: Colors.grey,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    if (itemEntity.type == 1)
                      const Text(
                        "置顶",
                        style: TextStyle(color: Colors.red),
                      ),
                    Container(
                      padding: itemEntity.type == 1
                          ? const EdgeInsets.fromLTRB(8, 0, 0, 0)
                          : const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(itemEntity.author?.isNotEmpty == true
                          ? itemEntity.author!
                          : itemEntity.shareUser),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("2022-10-07 23:58"),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        itemEntity.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(sb.toString()),
                    Expanded(
                        child: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.topRight,
                      child: Image.asset(itemEntity.collect
                          ? "assets/images/icon_collect.png"
                          : "assets/images/icon_uncollect.png"),
                    ))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void _refreshRequest() async {
    _pageIndex = 0;

    List<ArticleItemEntity> result = [];

    AppResponse<List<ArticleItemEntity>> topRes =
        await HttpGo.instance.get(Api.topArticle);
    if (topRes.isSuccessful) {
      result.addAll(topRes.data ?? List.empty());
    }

    AppResponse<ArticleDataEntity> res = await HttpGo.instance
        .get<ArticleDataEntity>("${Api.homePageArticle}$_pageIndex/json");
    if (res.isSuccessful) {
      result.addAll(res.data?.datas ?? List.empty());
    }

    setState(() {
      _articleList = result;
    });
    _refreshController.finishRefresh();
  }

  void _loadRequest() async {
    _pageIndex++;
    AppResponse<ArticleDataEntity> res = await HttpGo.instance
        .get<ArticleDataEntity>("${Api.homePageArticle}$_pageIndex/json");
    if (res.isSuccessful) {
      setState(() {
        _articleList.addAll(res.data?.datas ?? List.empty());
      });
    }
    _refreshController.finishLoad();
  }
}
