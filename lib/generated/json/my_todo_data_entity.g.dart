import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/my_todo_data_entity.dart';

MyTodoDataEntity $MyTodoDataEntityFromJson(Map<String, dynamic> json) {
  final MyTodoDataEntity myTodoDataEntity = MyTodoDataEntity();
  final int? curPage = jsonConvert.convert<int>(json['curPage']);
  if (curPage != null) {
    myTodoDataEntity.curPage = curPage;
  }
  final List<MyTodoDataItem>? datas = (json['datas'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<MyTodoDataItem>(e) as MyTodoDataItem)
      .toList();
  if (datas != null) {
    myTodoDataEntity.datas = datas;
  }
  final int? offset = jsonConvert.convert<int>(json['offset']);
  if (offset != null) {
    myTodoDataEntity.offset = offset;
  }
  final bool? over = jsonConvert.convert<bool>(json['over']);
  if (over != null) {
    myTodoDataEntity.over = over;
  }
  final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
  if (pageCount != null) {
    myTodoDataEntity.pageCount = pageCount;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    myTodoDataEntity.size = size;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    myTodoDataEntity.total = total;
  }
  return myTodoDataEntity;
}

Map<String, dynamic> $MyTodoDataEntityToJson(MyTodoDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['curPage'] = entity.curPage;
  data['datas'] = entity.datas.map((v) => v.toJson()).toList();
  data['offset'] = entity.offset;
  data['over'] = entity.over;
  data['pageCount'] = entity.pageCount;
  data['size'] = entity.size;
  data['total'] = entity.total;
  return data;
}

extension MyTodoDataEntityExtension on MyTodoDataEntity {
  MyTodoDataEntity copyWith({
    int? curPage,
    List<MyTodoDataItem>? datas,
    int? offset,
    bool? over,
    int? pageCount,
    int? size,
    int? total,
  }) {
    return MyTodoDataEntity()
      ..curPage = curPage ?? this.curPage
      ..datas = datas ?? this.datas
      ..offset = offset ?? this.offset
      ..over = over ?? this.over
      ..pageCount = pageCount ?? this.pageCount
      ..size = size ?? this.size
      ..total = total ?? this.total;
  }
}

MyTodoDataItem $MyTodoDataDatasFromJson(Map<String, dynamic> json) {
  final MyTodoDataItem myTodoDataDatas = MyTodoDataItem();
  final int? completeDate = jsonConvert.convert<int>(json['completeDate']);
  if (completeDate != null) {
    myTodoDataDatas.completeDate = completeDate;
  }
  final String? completeDateStr = jsonConvert.convert<String>(
      json['completeDateStr']);
  if (completeDateStr != null) {
    myTodoDataDatas.completeDateStr = completeDateStr;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    myTodoDataDatas.content = content;
  }
  final int? date = jsonConvert.convert<int>(json['date']);
  if (date != null) {
    myTodoDataDatas.date = date;
  }
  final String? dateStr = jsonConvert.convert<String>(json['dateStr']);
  if (dateStr != null) {
    myTodoDataDatas.dateStr = dateStr;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    myTodoDataDatas.id = id;
  }
  final int? priority = jsonConvert.convert<int>(json['priority']);
  if (priority != null) {
    myTodoDataDatas.priority = priority;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    myTodoDataDatas.status = status;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    myTodoDataDatas.title = title;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    myTodoDataDatas.type = type;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    myTodoDataDatas.userId = userId;
  }
  return myTodoDataDatas;
}

Map<String, dynamic> $MyTodoDataDatasToJson(MyTodoDataItem entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['completeDate'] = entity.completeDate;
  data['completeDateStr'] = entity.completeDateStr;
  data['content'] = entity.content;
  data['date'] = entity.date;
  data['dateStr'] = entity.dateStr;
  data['id'] = entity.id;
  data['priority'] = entity.priority;
  data['status'] = entity.status;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['userId'] = entity.userId;
  return data;
}

extension MyTodoDataDatasExtension on MyTodoDataItem {
  MyTodoDataItem copyWith({
    int? completeDate,
    String? completeDateStr,
    String? content,
    int? date,
    String? dateStr,
    int? id,
    int? priority,
    int? status,
    String? title,
    int? type,
    int? userId,
  }) {
    return MyTodoDataItem()
      ..completeDate = completeDate ?? this.completeDate
      ..completeDateStr = completeDateStr ?? this.completeDateStr
      ..content = content ?? this.content
      ..date = date ?? this.date
      ..dateStr = dateStr ?? this.dateStr
      ..id = id ?? this.id
      ..priority = priority ?? this.priority
      ..status = status ?? this.status
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..userId = userId ?? this.userId;
  }
}