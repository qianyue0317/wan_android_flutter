import 'package:wan_android_flutter/generated/json/base/json_field.dart';
import 'package:wan_android_flutter/generated/json/banner_entity.g.dart';
import 'dart:convert';
export 'package:wan_android_flutter/generated/json/banner_entity.g.dart';

@JsonSerializable()
class BannerEntity {
	late String desc;
	late int id;
	late String imagePath;
	late int isVisible;
	late int order;
	late String title;
	late int type;
	late String url;

	BannerEntity();

	factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

	Map<String, dynamic> toJson() => $BannerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}