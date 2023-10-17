import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/article_item_layout.dart';
import 'package:wan_android_flutter/pages/detail_page.dart';
import 'package:wan_android_flutter/user.dart';

class PlazaPage extends StatefulWidget {
  const PlazaPage({super.key});

  @override
  State<StatefulWidget> createState() => _PlazaState();
}

class _PlazaState extends State<PlazaPage>
    with BasePage<PlazaPage>, AutomaticKeepAliveClientMixin {
  int _currentPageIndex = 0;

  List<ArticleItemEntity> data = [];

  bool loadedData = false;

  bool login = false;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  @override
  void initState() {
    super.initState();
    login = User().isLoggedIn();
    _requestData();
  }

  _requestData() async {
    AppResponse<ArticleDataEntity> res = await HttpGo.instance
        .get("${Api.plazaArticleList}$_currentPageIndex/json");

    bool isRefresh = _currentPageIndex == 0;
    if (isRefresh) {
      data.clear();
    }
    if (res.isSuccessful) {
      setState(() {
        if (isRefresh) {
          _refreshController.finishRefresh();
        } else {
          _refreshController.finishLoad();
        }
        loadedData = true;
        data.addAll(res.data!.datas);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 监听user的状态，当登录状态改变时，重新build
    Provider.of<User>(context);

    if (login != User().isLoggedIn()) {
      login = User().isLoggedIn();
      _currentPageIndex = 0;
      _requestData();
    }

    if (!loadedData) {
      return const Center(
        widthFactor: 1,
        heightFactor: 1,
        child: CircularProgressIndicator(),
      );
    }
    return EasyRefresh.builder(
      controller: _refreshController,
      onRefresh: () {
        _currentPageIndex = 0;
        _requestData();
      },
      onLoad: () {
        _currentPageIndex++;
        _requestData();
      },
      childBuilder: (context, physics) {
        return ListView.builder(
            physics: physics,
            itemBuilder: (context, index) {
              ArticleItemEntity itemEntity = data[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPage(itemEntity.link, itemEntity.title));
                },
                child: ArticleItemLayout(
                    itemEntity: itemEntity,
                    onCollectTap: () {
                      _onCollectClick(itemEntity);
                    }),
              );
            },
            itemCount: data.length);
      },
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

  @override
  bool get wantKeepAlive => true;
}
