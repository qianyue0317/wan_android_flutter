import 'package:banner_carousel/banner_carousel.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/bean/banner_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/article_item_layout.dart';
import 'package:wan_android_flutter/pages/detail_page.dart';
import 'package:wan_android_flutter/user.dart';

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

  bool loadedData = false;

  bool login = false;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  @override
  void initState() {
    super.initState();
    login = User().isLoggedIn();
    _refreshRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<User>(builder: (context, user, child) {
      if (login != User().isLoggedIn()) {
        login = User().isLoggedIn();
        _refreshRequest();
      }
      return _build(context);
    });
  }

  Widget _build(BuildContext context) {
    if (!loadedData) {
      return const Center(
        widthFactor: 1,
        heightFactor: 1,
        child: CircularProgressIndicator(),
      );
    }
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
                      Get.to(() => DetailPage(
                          _articleList[index].link, _articleList[index].title));
                    },
                    child: ArticleItemLayout(
                        itemEntity: _articleList[index],
                        onCollectTap: () {
                          _onCollectClick(_articleList[index]);
                        }));
              }, childCount: _articleList.length))
            ],
          );
        },
      ),
    );
  }

  _onCollectClick(ArticleItemEntity itemEntity) async {
    bool collected = itemEntity.collect;
    AppResponse<dynamic> res = await (collected
        ? HttpGo.instance.post("${Api.uncollectArticel}${itemEntity.id}/json")
        : HttpGo.instance.post("${Api.collectArticle}${itemEntity.id}/json"));

    if (res.isSuccessful) {
      showTextToast(collected ? "取消收藏！" : "收藏成功！");
      itemEntity.collect = !itemEntity.collect;
    } else {
      showTextToast((collected ? "取消失败 -- " : "收藏失败 -- ") +
          (res.errorMsg ?? res.errorCode.toString()));
    }
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
      loadedData = true;
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
