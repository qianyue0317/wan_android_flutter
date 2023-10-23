import 'package:easy_refresh/easy_refresh.dart';
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
import 'package:wan_android_flutter/utils/log_util.dart';

class PlazaPage extends StatefulWidget {
  const PlazaPage({super.key});

  @override
  State<StatefulWidget> createState() => _PlazaState();
}

class _PlazaState extends State<PlazaPage>
    with BasePage<PlazaPage>, AutomaticKeepAliveClientMixin {
  int _currentPageIndex = 0;

  List<ArticleItemEntity> data = [];

  late RxList<ArticleItemEntity> dataObs = data.obs;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  Future<bool> _requestData() async {
    AppResponse<ArticleDataEntity> res = await HttpGo.instance
        .get("${Api.plazaArticleList}$_currentPageIndex/json");

    bool isRefresh = _currentPageIndex == 0;
    if (isRefresh) {
      data.clear();
    }
    if (res.isSuccessful) {
      data.addAll(res.data!.datas);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 监听user的状态，当登录状态改变时，重新build
    return Consumer<User>(builder: (context, user, child) {
      return FutureBuilder(
          future: _requestData(),
          builder: (context, snapshot) {
            WanLog.d("plaza connect state: ${snapshot.connectionState}");
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
    });
  }

  Widget _buildContent() {
    if (data.isEmpty) {
      return const EmptyWidget();
    }
    return EasyRefresh.builder(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      childBuilder: (context, physics) {
        return Obx(() {
          // ignore: invalid_use_of_protected_member
          dataObs.value;
          return ListView.builder(
              physics: physics,
              itemBuilder: (context, index) {
                ArticleItemEntity itemEntity = data[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() =>
                        DetailPage(itemEntity.link, itemEntity.title));
                  },
                  child: ArticleItemLayout(
                      itemEntity: itemEntity,
                      onCollectTap: () {
                        _onCollectClick(itemEntity);
                      }),
                );
              },
              itemCount: data.length);
        });
      },
    );
  }

  _onRefresh() async {
    _currentPageIndex = 0;
    await _requestData();
    _refreshController.finishRefresh();
    dataObs.refresh();
  }

  _onLoad() async {
    _currentPageIndex++;
    await _requestData();
    _refreshController.finishLoad();
    dataObs.refresh();
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
