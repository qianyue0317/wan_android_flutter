import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/bean/my_shared_data_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/article_item_layout.dart';

class MySharedPage extends StatefulWidget {
  const MySharedPage({Key? key}) : super(key: key);

  @override
  State createState() => _MySharedPageState();
}

class _MySharedPageState extends State<MySharedPage> {
  int _pageIndex = 1;

  final List<ArticleItemEntity> _data = [];

  bool _over = true;

  late var dataObs = _data.obs;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  Future<bool> _requestData() async {
    AppResponse<MySharedDataEntity> res =
        await HttpGo.instance.get("${Api.sharedList}$_pageIndex/json");
    if (res.isSuccessful) {
      _over = res.data!.shareArticles.over;
      if (_pageIndex == 1) {
        _data.clear();
      }
      _data.addAll(res.data!.shareArticles.datas);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("我的分享", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(future: (() async {
        _pageIndex = 1;
        return await _requestData();
      })(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == false) {
            return RetryWidget(onTapRetry: () => setState(() {}));
          } else {
            return _build();
          }
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget _build() {
    return EasyRefresh.builder(
        onLoad: _onLoad,
        onRefresh: _onRefresh,
        controller: _refreshController,
        childBuilder: (context, physics) {
          return Obx(() {
            // ignore: invalid_use_of_protected_member
            dataObs.value;
            return ListView.builder(
              physics: physics,
              itemCount: _data.length,
              itemBuilder: (context, index) {
                ArticleItemEntity itemEntity = _data[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ArticleItemLayout(
                      itemEntity: itemEntity,
                      onCollectTap: () {
                        _onCollectClick(itemEntity);
                      }),
                );
              },
            );
          });
        });
  }

  _onLoad() async {
    _pageIndex++;
    await _requestData();
    _refreshController
        .finishLoad(_over ? IndicatorResult.noMore : IndicatorResult.success);
    dataObs.refresh();
  }

  _onRefresh() async {
    _pageIndex = 1;
    await _requestData();
    _refreshController.finishRefresh();
    dataObs.refresh();
  }

  _onCollectClick(ArticleItemEntity itemEntity) async {
    bool collected = itemEntity.collect;
    AppResponse<dynamic> res = await (collected
        ? HttpGo.instance.post("${Api.uncollectArticel}${itemEntity.id}/json")
        : HttpGo.instance.post("${Api.collectArticle}${itemEntity.id}/json"));

    if (res.isSuccessful) {
      Fluttertoast.showToast(msg: collected ? "取消收藏！" : "收藏成功！");
      itemEntity.collect = !itemEntity.collect;
    } else {
      Fluttertoast.showToast(
          msg: (collected ? "取消失败 -- " : "收藏失败 -- ") +
              (res.errorMsg ?? res.errorCode.toString()));
    }
  }
}
