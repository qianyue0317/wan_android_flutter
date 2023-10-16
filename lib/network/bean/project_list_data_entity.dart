import 'package:wan_android_flutter/generated/json/base/json_field.dart';
import 'package:wan_android_flutter/generated/json/project_list_data_entity.g.dart';
import 'dart:convert';
export 'package:wan_android_flutter/generated/json/project_list_data_entity.g.dart';

@JsonSerializable()
class ProjectListDataEntity {
	late int curPage;
	late List<ProjectListDataItemEntity> datas;
	late int offset;
	late bool over;
	late int pageCount;
	late int size;
	late int total;

	ProjectListDataEntity();

	factory ProjectListDataEntity.fromJson(Map<String, dynamic> json) => $ProjectListDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProjectListDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProjectListDataItemEntity {
	late bool adminAdd;
	late String apkLink;
	late int audit;
	late String author;
	late bool canEdit;
	late int chapterId;
	late String chapterName;
	late bool collect;
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
	late String shareUser;
	late int superChapterId;
	late String superChapterName;
	late List<ProjectListDataDatasTags> tags;
	late String title;
	late int type;
	late int userId;
	late int visible;
	late int zan;

	ProjectListDataItemEntity();

	factory ProjectListDataItemEntity.fromJson(Map<String, dynamic> json) => $ProjectListDataDatasFromJson(json);

	Map<String, dynamic> toJson() => $ProjectListDataDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProjectListDataDatasTags {
	late String name;
	late String url;

	ProjectListDataDatasTags();

	factory ProjectListDataDatasTags.fromJson(Map<String, dynamic> json) => $ProjectListDataDatasTagsFromJson(json);

	Map<String, dynamic> toJson() => $ProjectListDataDatasTagsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}