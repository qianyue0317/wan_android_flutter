import 'package:wan_android_flutter/generated/json/base/json_field.dart';
import 'package:wan_android_flutter/generated/json/my_todo_data_entity.g.dart';
import 'dart:convert';
export 'package:wan_android_flutter/generated/json/my_todo_data_entity.g.dart';

@JsonSerializable()
class MyTodoDataEntity {
	late int curPage;
	late List<MyTodoDataItem> datas;
	late int offset;
	late bool over;
	late int pageCount;
	late int size;
	late int total;

	MyTodoDataEntity();

	factory MyTodoDataEntity.fromJson(Map<String, dynamic> json) => $MyTodoDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyTodoDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyTodoDataItem {
	late int completeDate;
	late String completeDateStr;
	late String content;
	late int date;
	late String dateStr;
	late int id;
	late int priority;
	late int status;
	late String title;
	late int type;
	late int userId;

	MyTodoDataItem();

	factory MyTodoDataItem.fromJson(Map<String, dynamic> json) => $MyTodoDataDatasFromJson(json);

	Map<String, dynamic> toJson() => $MyTodoDataDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}