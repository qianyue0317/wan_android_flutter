import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/network/api.dart';
import 'package:wan_android_flutter/network/bean/AppResponse.dart';
import 'package:wan_android_flutter/network/request_util.dart';
import 'package:wan_android_flutter/pages/search_result_page.dart';
import 'package:wan_android_flutter/utils/log_util.dart';

import '../network/bean/hot_keyword_entity.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with BasePage<SearchPage> {
  static const String historyKey = "historyKey";

  List<String> histories = [];

  List<HotKeywordEntity> hotKeywords = [];

  List<Color> keywordsColors = [
    const Color(0xffe35454),
    const Color(0xff549A3A),
    const Color(0xff34856E),
    const Color(0xffB59B42),
    const Color(0xff9B4BAA),
    const Color(0xff4966B1),
  ];

  @override
  void initState() {
    super.initState();
    try {
      var mmkv = MMKV.defaultMMKV();
      String historyContent = mmkv.decodeString(historyKey) ?? "";
      if (historyKey.trim().isNotEmpty) {
        histories.addAll((json.decoder.convert(historyContent) as List<dynamic>)
            .map((e) => e as String));
      }
    } catch (e) {
      WanLog.e("load history words error - ${e.toString()}");
    }
    _getHotKeywords();
  }

  _getHotKeywords() async {
    AppResponse<List<HotKeywordEntity>> res =
        await HttpGo.instance.get(Api.hotKeywords);

    if (res.isSuccessful) {
      setState(() {
        hotKeywords.clear();
        hotKeywords.addAll(res.data!);
      });
    }
  }

  _saveHistoryToLocal() {
    try {
      var mmkv = MMKV.defaultMMKV();
      String historyContent = json.encoder.convert(histories);
      mmkv.encodeString(historyKey, historyContent);
    } catch (e) {
      WanLog.e("load history words error - ${e.toString()}");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _saveHistoryToLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: MySearchBar(
                onSubmit: _onSearch,
              )),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  spacing: 16,
                  runAlignment: WrapAlignment.center,
                  children: List.generate(hotKeywords.length, (index) {
                    return GestureDetector(
                        onTap: () {
                          _onSearch(hotKeywords[index].name);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: keywordsColors[
                                    index % (keywordsColors.length)]),
                            child: Text(hotKeywords[index].name,
                                style: const TextStyle(color: Colors.white))));
                  }),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "搜索记录",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: _onClearClick, child: const Text("清空")),
                    ),
                  )
                ],
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 16),
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _onSearch(histories[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(histories[index]),
                              Expanded(
                                child: GestureDetector(
                                  child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.close)),
                                  onTap: () {
                                    _deleteHistory(index);
                                  },
                                ),
                              )
                            ],
                          )));
                },
              ))
            ],
          ),
        ));
  }

  _onClearClick() async {
    bool? result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示"),
            content: const Text("确定要清除所有搜索记录吗？"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back<bool>(result: false);
                  },
                  child: const Text("取消")),
              TextButton(
                  onPressed: () {
                    Get.back<bool>(result: true);
                  },
                  child: const Text("确定")),
            ],
          );
        });

    if (result == true) {
      setState(() {
        histories.clear();
        _saveHistoryToLocal();
      });
    }
  }

  _deleteHistory(int index) {
    setState(() {
      histories.removeAt(index);
    });
  }

  _onSearch(String content) {
    setState(() {
      if (histories.contains(content)) {
        histories.remove(content);
      }
      histories.insert(0, content);
    });
    Get.to(() => SearchResultPage(keyword: content));
  }
}

/// -------------------------------搜索框封装↓---------------------------------
class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key, required this.onSubmit});

  final void Function(String) onSubmit;

  @override
  State<StatefulWidget> createState() => _MySearchState();
}

class _MySearchState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "搜索",
          contentPadding: EdgeInsets.only(bottom: 10),
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
        onSubmitted: (content) {
          widget.onSubmit(content);
        },
      ),
    );
  }
}
