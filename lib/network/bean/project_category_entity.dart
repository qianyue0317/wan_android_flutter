import 'package:wan_android_flutter/generated/json/base/json_field.dart';
import 'package:wan_android_flutter/generated/json/project_category_entity.g.dart';
import 'dart:convert';
export 'package:wan_android_flutter/generated/json/project_category_entity.g.dart';

@JsonSerializable()
class ProjectCategoryEntity {
	late List<dynamic> articleList;
	late String author;
	late List<dynamic> children;
	late int courseId;
	late String cover;
	late String desc;
	late int id;
	late String lisense;
	late String lisenseLink;
	late String name;
	late int order;
	late int parentChapterId;
	late int type;
	late bool userControlSetTop;
	late int visible;

	ProjectCategoryEntity();

	factory ProjectCategoryEntity.fromJson(Map<String, dynamic> json) => $ProjectCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProjectCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}