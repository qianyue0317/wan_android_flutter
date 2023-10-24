import 'package:flutter/foundation.dart';
import 'package:wan_android_flutter/generated/json/article_data_entity.g.dart';
import 'package:wan_android_flutter/generated/json/base/json_field.dart';
import 'dart:convert';

export 'package:wan_android_flutter/generated/json/article_data_entity.g.dart';

@JsonSerializable()
class ArticleDataEntity {
	late int curPage;
	late List<ArticleItemEntity> datas;
	late int offset;
	late bool over;
	late int pageCount;
	late int size;
	late int total;

	ArticleDataEntity();

	factory ArticleDataEntity.fromJson(Map<String, dynamic> json) => $ArticleDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $ArticleDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ArticleItemEntity with ChangeNotifier {
	late bool adminAdd;
	late String apkLink;
	late int audit;
	late String? author;
	late bool canEdit;
	late int chapterId;
	late String? chapterName;
	bool? _collect;
	set collect(bool value) {
		_collect = value;
		notifyListeners();
	}
  bool get collect => _collect ?? false;
  late int courseId;
	late String desc;
	late String descMd;
	late String envelopePic;
	late bool fresh;
	late String host;
	late int id;
	late bool isAdminAdd;
	late String link;
	late String niceDate;
	late String niceShareDate;
	late String origin;
	late String prefix;
	late String projectLink;
	late int publishTime;
	late int realSuperChapterId;
	late int selfVisible;
	late int shareDate;
	String? shareUser;
	late int superChapterId;
	String? superChapterName;
	late List<dynamic> tags;
	late String title;
	int? type;
	late int userId;
	late int visible;
	late int zan;

	ArticleItemEntity();

	factory ArticleItemEntity.fromJson(Map<String, dynamic> json) => $ArticleItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $ArticleItemEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}