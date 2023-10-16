import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_flutter/base/base_page.dart';
import 'package:wan_android_flutter/pages/search_result_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with BasePage<SearchPage> {
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
    );
  }

  _onSearch(String content) {
    Get.to(SearchResultPage(keyword: content));
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
