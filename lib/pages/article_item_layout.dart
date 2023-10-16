import 'package:flutter/material.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';

class ArticleItemLayout extends StatelessWidget {
  const ArticleItemLayout({Key? key, required this.itemEntity, required this.onCollectTap}) : super(key: key);

  final ArticleItemEntity itemEntity;

  final void Function() onCollectTap;

  @override
  Widget build(BuildContext context) {
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
                              onTap: onCollectTap,
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
}
