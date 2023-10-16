import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/project_category_entity.dart';

ProjectCategoryEntity $ProjectCategoryEntityFromJson(
    Map<String, dynamic> json) {
  final ProjectCategoryEntity projectCategoryEntity = ProjectCategoryEntity();
  final List<dynamic>? articleList = (json['articleList'] as List<dynamic>?)
      ?.map(
          (e) => e)
      .toList();
  if (articleList != null) {
    projectCategoryEntity.articleList = articleList;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    projectCategoryEntity.author = author;
  }
  final List<dynamic>? children = (json['children'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (children != null) {
    projectCategoryEntity.children = children;
  }
  final int? courseId = jsonConvert.convert<int>(json['courseId']);
  if (courseId != null) {
    projectCategoryEntity.courseId = courseId;
  }
  final String? cover = jsonConvert.convert<String>(json['cover']);
  if (cover != null) {
    projectCategoryEntity.cover = cover;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    projectCategoryEntity.desc = desc;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    projectCategoryEntity.id = id;
  }
  final String? lisense = jsonConvert.convert<String>(json['lisense']);
  if (lisense != null) {
    projectCategoryEntity.lisense = lisense;
  }
  final String? lisenseLink = jsonConvert.convert<String>(json['lisenseLink']);
  if (lisenseLink != null) {
    projectCategoryEntity.lisenseLink = lisenseLink;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    projectCategoryEntity.name = name;
  }
  final int? order = jsonConvert.convert<int>(json['order']);
  if (order != null) {
    projectCategoryEntity.order = order;
  }
  final int? parentChapterId = jsonConvert.convert<int>(
      json['parentChapterId']);
  if (parentChapterId != null) {
    projectCategoryEntity.parentChapterId = parentChapterId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    projectCategoryEntity.type = type;
  }
  final bool? userControlSetTop = jsonConvert.convert<bool>(
      json['userControlSetTop']);
  if (userControlSetTop != null) {
    projectCategoryEntity.userControlSetTop = userControlSetTop;
  }
  final int? visible = jsonConvert.convert<int>(json['visible']);
  if (visible != null) {
    projectCategoryEntity.visible = visible;
  }
  return projectCategoryEntity;
}

Map<String, dynamic> $ProjectCategoryEntityToJson(
    ProjectCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['articleList'] = entity.articleList;
  data['author'] = entity.author;
  data['children'] = entity.children;
  data['courseId'] = entity.courseId;
  data['cover'] = entity.cover;
  data['desc'] = entity.desc;
  data['id'] = entity.id;
  data['lisense'] = entity.lisense;
  data['lisenseLink'] = entity.lisenseLink;
  data['name'] = entity.name;
  data['order'] = entity.order;
  data['parentChapterId'] = entity.parentChapterId;
  data['type'] = entity.type;
  data['userControlSetTop'] = entity.userControlSetTop;
  data['visible'] = entity.visible;
  return data;
}

extension ProjectCategoryEntityExtension on ProjectCategoryEntity {
  ProjectCategoryEntity copyWith({
    List<dynamic>? articleList,
    String? author,
    List<dynamic>? children,
    int? courseId,
    String? cover,
    String? desc,
    int? id,
    String? lisense,
    String? lisenseLink,
    String? name,
    int? order,
    int? parentChapterId,
    int? type,
    bool? userControlSetTop,
    int? visible,
  }) {
    return ProjectCategoryEntity()
      ..articleList = articleList ?? this.articleList
      ..author = author ?? this.author
      ..children = children ?? this.children
      ..courseId = courseId ?? this.courseId
      ..cover = cover ?? this.cover
      ..desc = desc ?? this.desc
      ..id = id ?? this.id
      ..lisense = lisense ?? this.lisense
      ..lisenseLink = lisenseLink ?? this.lisenseLink
      ..name = name ?? this.name
      ..order = order ?? this.order
      ..parentChapterId = parentChapterId ?? this.parentChapterId
      ..type = type ?? this.type
      ..userControlSetTop = userControlSetTop ?? this.userControlSetTop
      ..visible = visible ?? this.visible;
  }
}