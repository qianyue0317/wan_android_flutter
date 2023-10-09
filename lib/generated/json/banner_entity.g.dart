import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/banner_entity.dart';

BannerEntity $BannerEntityFromJson(Map<String, dynamic> json) {
  final BannerEntity bannerEntity = BannerEntity();
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    bannerEntity.desc = desc;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    bannerEntity.id = id;
  }
  final String? imagePath = jsonConvert.convert<String>(json['imagePath']);
  if (imagePath != null) {
    bannerEntity.imagePath = imagePath;
  }
  final int? isVisible = jsonConvert.convert<int>(json['isVisible']);
  if (isVisible != null) {
    bannerEntity.isVisible = isVisible;
  }
  final int? order = jsonConvert.convert<int>(json['order']);
  if (order != null) {
    bannerEntity.order = order;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    bannerEntity.title = title;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    bannerEntity.type = type;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    bannerEntity.url = url;
  }
  return bannerEntity;
}

Map<String, dynamic> $BannerEntityToJson(BannerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['desc'] = entity.desc;
  data['id'] = entity.id;
  data['imagePath'] = entity.imagePath;
  data['isVisible'] = entity.isVisible;
  data['order'] = entity.order;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['url'] = entity.url;
  return data;
}

extension BannerEntityExtension on BannerEntity {
  BannerEntity copyWith({
    String? desc,
    int? id,
    String? imagePath,
    int? isVisible,
    int? order,
    String? title,
    int? type,
    String? url,
  }) {
    return BannerEntity()
      ..desc = desc ?? this.desc
      ..id = id ?? this.id
      ..imagePath = imagePath ?? this.imagePath
      ..isVisible = isVisible ?? this.isVisible
      ..order = order ?? this.order
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..url = url ?? this.url;
  }
}