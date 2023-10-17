import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/hot_keyword_entity.dart';

HotKeywordEntity $HotKeywordEntityFromJson(Map<String, dynamic> json) {
  final HotKeywordEntity hotKeywordEntity = HotKeywordEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    hotKeywordEntity.id = id;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    hotKeywordEntity.link = link;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    hotKeywordEntity.name = name;
  }
  final int? order = jsonConvert.convert<int>(json['order']);
  if (order != null) {
    hotKeywordEntity.order = order;
  }
  final int? visible = jsonConvert.convert<int>(json['visible']);
  if (visible != null) {
    hotKeywordEntity.visible = visible;
  }
  return hotKeywordEntity;
}

Map<String, dynamic> $HotKeywordEntityToJson(HotKeywordEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['link'] = entity.link;
  data['name'] = entity.name;
  data['order'] = entity.order;
  data['visible'] = entity.visible;
  return data;
}

extension HotKeywordEntityExtension on HotKeywordEntity {
  HotKeywordEntity copyWith({
    int? id,
    String? link,
    String? name,
    int? order,
    int? visible,
  }) {
    return HotKeywordEntity()
      ..id = id ?? this.id
      ..link = link ?? this.link
      ..name = name ?? this.name
      ..order = order ?? this.order
      ..visible = visible ?? this.visible;
  }
}