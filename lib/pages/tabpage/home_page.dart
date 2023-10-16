import 'package:banner_carousel/banner_carousel.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/bean/banner_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with BasePage<HomePage>, AutomaticKeepAliveClientMixin {
  var _pageIndex = 0;

  List<ArticleItemEntity> _articleList = List.empty();

  List<BannerEntity>? bannerData;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  @override
  void initState() {
    super.initState();
    _refreshRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh.builder(
        controller: _refreshController,
        onRefresh: _refreshRequest,
        onLoad: _loadRequest,
        childBuilder: (context, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              if (bannerData != null && bannerData!.isNotEmpty)
                SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: BannerCarousel(
                          banners: bannerData!
                              .map((e) => BannerModel(
                                  imagePath: e.imagePath, id: e.id.toString()))
                              .toList(),
                        ))),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return GestureDetector(
                    onTap: () {
                      Get.to(DetailPage(_articleList[index].link, _articleList[index].title));
                    }, child: _generateItemView(context, index));
              }, childCount: _articleList.length))
            ],
          );
        },
      ),
    );
  }

  Widget _generateItemView(BuildContext context, int index) {
    ArticleItemEntity itemEntity = _articleList[index];
    String publishTime =
        DateTime.fromMillisecondsSinceEpoch(itemEntity.publishTime).toString();
    publishTime = publishTime.substring(0, publishTime.length - 4);
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
          surfaceTintColor: Colors.white,
          color: Colors.white,
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(publishTime),
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
                            child: GestureDetector(
                              onTap: () {
                                // todo 点击收藏
                                setState(() {
                                  itemEntity.collect = !itemEntity.collect;
                                });
                              },
                              child: Image.asset(itemEntity.collect
                                  ? "assets/images/icon_collect.png"
                                  : "assets/images/icon_uncollect.png"),
                            )))
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

    AppResponse<List<BannerEntity>> bannerRes =
        await HttpGo.instance.get(Api.banner);
    bannerData = bannerRes.data;

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

  @override
  bool get wantKeepAlive => true;
}
