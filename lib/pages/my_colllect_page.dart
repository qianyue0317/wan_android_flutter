import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
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
          title: const Text("我的收藏", style: TextStyle(color: Colors.white),),
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
            children: [_CollectListPage(), _CollectListPage()],
          )),
        ]));
  }
}

class _CollectListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectListPageState();
}

class _CollectListPageState extends State<_CollectListPage> {
  int _pageIndex = 0;

  final List<ArticleItemEntity> data = [];

  late var dataObs = data.obs;

  bool _over = false;

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: (() async {
      _pageIndex = 0;
      return await _requestData();
    })(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data == false) {
          return RetryWidget(onTapRetry: () => setState(() {}));
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

  Future<bool> _requestData() async {
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
  }

  _onRefresh() async {
    _pageIndex = 0;
    await _requestData();
    _refreshController.finishRefresh();
    dataObs.refresh();
  }

  _onLoad() async {
    _pageIndex++;
    await _requestData();
    _refreshController
        .finishLoad(_over ? IndicatorResult.noMore : IndicatorResult.success);
    dataObs.refresh();
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
                        itemEntity: itemEntity, onCollectTap: () {}),
                  );
                });
          });
    });
  }
}
