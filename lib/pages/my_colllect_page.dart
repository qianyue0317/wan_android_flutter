import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/bean/user_tool_entity.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/article_item_layout.dart';
import 'package:wan_android_flutter/pages/detail_page.dart';

class MyColllectPage extends StatefulWidget {
  const MyColllectPage({Key? key}) : super(key: key);

  @override
  State createState() => _MyColllectPageState();
}

class _MyColllectPageState extends State<MyColllectPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "我的收藏",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(children: [
          TabBar(
            controller: _tabController,
            isScrollable: false,
            tabs: const [
              Tab(
                text: "文章",
              ),
              Tab(
                text: "网站",
              )
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: const [_CollectListPage(0), _CollectListPage(1)],
          )),
        ]));
  }
}

class _CollectListPage extends StatefulWidget {
  const _CollectListPage(this._tag, {super.key});

  final int _tag;

  @override
  State<StatefulWidget> createState() => _CollectListPageState();
}

class _CollectListPageState extends State<_CollectListPage>
    with AutomaticKeepAliveClientMixin {
  int _pageIndex = 0;

  final List<ArticleItemEntity> data = [];

  final List<UserToolEntity> data2 = [];

  late var dataObs = data.obs;

  late var data2Obs = data2.obs;

  bool _over = false;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget._tag == 1) {
      _over = true;
    }
    return FutureBuilder(future: (() async {
      _pageIndex = 0;
      return await _requestData();
    })(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return RetryWidget(onTapRetry: () => setState(() {}));
        }
        return widget._tag == 0 ? _buildContent() : _buildContent2();
      } else {
        return const Center(
          widthFactor: 1,
          heightFactor: 1,
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Future<bool> _requestData() async {
    if (widget._tag == 0) {
      AppResponse<ArticleDataEntity> res =
          await HttpGo.instance.get("${Api.collectList}/$_pageIndex/json");
      if (res.isSuccessful) {
        if (_pageIndex == 0) {
          data.clear();
        }
        _over = res.data!.over;
        data.addAll(res.data!.datas);
        return true;
      }
      return false;
    } else {
      AppResponse<List<UserToolEntity>> res =
          await HttpGo.instance.get(Api.collectWebaddressList);
      if (res.isSuccessful) {
        if (_pageIndex == 0) {
          data2.clear();
        }
        data2.addAll(res.data!);
        return true;
      }
      return false;
    }
  }

  _onRefresh() async {
    _pageIndex = 0;
    await _requestData();
    _refreshController.finishRefresh();
    if (mounted) {
      if (widget._tag == 0) {
        dataObs.refresh();
      } else {
        data2Obs.refresh();
      }
    }
  }

  _onLoad() async {
    _pageIndex++;
    await _requestData();
    _refreshController
        .finishLoad(_over ? IndicatorResult.noMore : IndicatorResult.success);
    if (mounted) {
      if (widget._tag == 0) {
        dataObs.refresh();
      } else {
        data2Obs.refresh();
      }
    }
  }

  Widget _buildContent() {
    if (data.isEmpty) {
      return const EmptyWidget();
    }
    return Obx(() {
      // ignore: invalid_use_of_protected_member
      dataObs.value;
      return EasyRefresh.builder(
          onRefresh: _onRefresh,
          onLoad: _onLoad,
          controller: _refreshController,
          childBuilder: (context, physics) {
            return ListView.builder(
                physics: physics,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  ArticleItemEntity itemEntity = data[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.to(
                          () => DetailPage(itemEntity.link, itemEntity.title));
                    },
                    child: ArticleItemLayout(
                        itemEntity: itemEntity,
                        onCollectTap: () {},
                        showCollectBtn: false),
                  );
                });
          });
    });
  }

  Widget _buildContent2() {
    if (data2.isEmpty) {
      return const EmptyWidget();
    }

    return ListView.builder(
        itemCount: data2.length,
        itemBuilder: (context, index) {
          UserToolEntity userToolEntity = data2[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(userToolEntity.name),
                            Text(userToolEntity.link)
                          ],
                        )),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
