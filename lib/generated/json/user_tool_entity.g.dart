import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/user_tool_entity.dart';

UserToolEntity $UserToolEntityFromJson(Map<String, dynamic> json) {
  final UserToolEntity userToolEntity = UserToolEntity();
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    userToolEntity.desc = desc;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    userToolEntity.icon = icon;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userToolEntity.id = id;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    userToolEntity.link = link;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userToolEntity.name = name;
  }
  final int? order = jsonConvert.convert<int>(json['order']);
  if (order != null) {
    userToolEntity.order = order;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    userToolEntity.userId = userId;
  }
  final int? visible = jsonConvert.convert<int>(json['visible']);
  if (visible != null) {
    userToolEntity.visible = visible;
  }
  return userToolEntity;
}

Map<String, dynamic> $UserToolEntityToJson(UserToolEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['desc'] = entity.desc;
  data['icon'] = entity.icon;
  data['id'] = entity.id;
  data['link'] = entity.link;
  data['name'] = entity.name;
  data['order'] = entity.order;
  data['userId'] = entity.userId;
  data['visible'] = entity.visible;
  return data;
}

extension UserToolEntityExtension on UserToolEntity {
  UserToolEntity copyWith({
    String? desc,
    String? icon,
    int? id,
    String? link,
    String? name,
    int? order,
    int? userId,
    int? visible,
  }) {
    return UserToolEntity()
      ..desc = desc ?? this.desc
      ..icon = icon ?? this.icon
      ..id = id ?? this.id
      ..link = link ?? this.link
      ..name = name ?? this.name
      ..order = order ?? this.order
      ..userId = userId ?? this.userId
      ..visible = visible ?? this.visible;
  }
}