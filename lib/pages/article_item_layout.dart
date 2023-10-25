import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';

class ArticleItemLayout extends StatefulWidget {
  const ArticleItemLayout(
      {Key? key,
      required this.itemEntity,
      required this.onCollectTap,
      this.showCollectBtn})
      : super(key: key);

  final ArticleItemEntity itemEntity;

  final void Function() onCollectTap;

  final bool? showCollectBtn;

  @override
  State<StatefulWidget> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItemLayout> {
  @override
  void initState() {
    super.initState();
    widget.itemEntity.addListener(_onCollectChange);
  }

  @override
  void didUpdateWidget(ArticleItemLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemEntity != widget.itemEntity) {
      oldWidget.itemEntity.removeListener(_onCollectChange);
      widget.itemEntity.addListener(_onCollectChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.itemEntity.removeListener(_onCollectChange);
  }

  _onCollectChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String publishTime =
        DateTime.fromMillisecondsSinceEpoch(widget.itemEntity.publishTime)
            .toString();
    publishTime = publishTime.substring(0, publishTime.length - 4);
    StringBuffer sb = StringBuffer(widget.itemEntity.superChapterName ?? "");
    if (sb.isNotEmpty &&
        widget.itemEntity.chapterName != null &&
        widget.itemEntity.chapterName!.isNotEmpty) {
      sb.write("·");
    }
    sb.write(widget.itemEntity.chapterName ?? "");
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
                    if (widget.itemEntity.type == 1)
                      const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "置顶",
                            style: TextStyle(color: Colors.red),
                          )),
                    Container(
                      padding: widget.itemEntity.type == 1
                          ? const EdgeInsets.fromLTRB(8, 0, 0, 0)
                          : const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text(widget.itemEntity.author?.isNotEmpty == true
                          ? widget.itemEntity.author!
                          : widget.itemEntity.shareUser ?? ""),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                        child: Text(publishTime),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Html(
                        data: widget.itemEntity.title,
                        style: {
                          "html": Style(
                              margin: Margins.zero,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: FontSize(14),
                              padding: HtmlPaddings.zero,
                              alignment: Alignment.topLeft),
                          "body": Style(
                              margin: Margins.zero,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: FontSize(14),
                              padding: HtmlPaddings.zero,
                              alignment: Alignment.topLeft)
                        },
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(sb.toString())),
                    Expanded(
                        child: Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.only(right: 8),
                            child: Builder(builder: (context) {
                              if (widget.showCollectBtn == false) {
                                return Container();
                              }
                              return GestureDetector(
                                onTap: widget.onCollectTap,
                                child: Image.asset(widget.itemEntity.collect
                                    ? "assets/images/icon_collect.png"
                                    : "assets/images/icon_uncollect.png"),
                              );
                            })))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
