// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';
import 'package:wan_android_flutter/network/bean/banner_entity.dart';
import 'package:wan_android_flutter/network/bean/project_category_entity.dart';
import 'package:wan_android_flutter/network/bean/project_list_data_entity.dart';
import 'package:wan_android_flutter/network/bean/user_info_entity.dart';

JsonConvert jsonConvert = JsonConvert();

typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);
typedef ConvertExceptionHandler = void Function(Object error, StackTrace stackTrace);

class JsonConvert {
  static ConvertExceptionHandler? onError;

  static Map<String, JsonConvertFunction> get convertFuncMap =>
      {
        (ArticleDataEntity).toString(): ArticleDataEntity.fromJson,
        (ArticleItemEntity).toString(): ArticleItemEntity.fromJson,
        (BannerEntity).toString(): BannerEntity.fromJson,
        (ProjectCategoryEntity).toString(): ProjectCategoryEntity.fromJson,
        (ProjectListDataEntity).toString(): ProjectListDataEntity.fromJson,
        (ProjectListDataItemEntity).toString(): ProjectListDataItemEntity.fromJson,
        (ProjectListDataDatasTags).toString(): ProjectListDataDatasTags
            .fromJson,
        (UserInfoEntity).toString(): UserInfoEntity.fromJson,
      };

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return _asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return null;
    }
  }

  List<T?>? convertList<T>(List<dynamic>? value,
      {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e, enumConvert: enumConvert))
          .toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) =>
      _asT<T>(e, enumConvert: enumConvert)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        return convertFuncMap[type]!(Map<String, dynamic>.from(value)) as T;
      } else {
        throw UnimplementedError('$type unimplemented');
      }
    }
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<ArticleDataEntity>[] is M) {
      return data.map<ArticleDataEntity>((Map<String, dynamic> e) =>
          ArticleDataEntity.fromJson(e)).toList() as M;
    }
    if (<ArticleItemEntity>[] is M) {
      return data.map<ArticleItemEntity>((Map<String, dynamic> e) =>
          ArticleItemEntity.fromJson(e)).toList() as M;
    }
    if (<BannerEntity>[] is M) {
      return data.map<BannerEntity>((Map<String, dynamic> e) =>
          BannerEntity.fromJson(e)).toList() as M;
    }
    if (<ProjectCategoryEntity>[] is M) {
      return data.map<ProjectCategoryEntity>((Map<String, dynamic> e) =>
          ProjectCategoryEntity.fromJson(e)).toList() as M;
    }
    if (<ProjectListDataEntity>[] is M) {
      return data.map<ProjectListDataEntity>((Map<String, dynamic> e) =>
          ProjectListDataEntity.fromJson(e)).toList() as M;
    }
    if (<ProjectListDataItemEntity>[] is M) {
      return data.map<ProjectListDataItemEntity>((Map<String, dynamic> e) =>
          ProjectListDataItemEntity.fromJson(e)).toList() as M;
    }
    if (<ProjectListDataDatasTags>[] is M) {
      return data.map<ProjectListDataDatasTags>((Map<String, dynamic> e) =>
          ProjectListDataDatasTags.fromJson(e)).toList() as M;
    }
    if (<UserInfoEntity>[] is M) {
      return data.map<UserInfoEntity>((Map<String, dynamic> e) =>
          UserInfoEntity.fromJson(e)).toList() as M;
    }

    debugPrint("${M.toString()} not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json is M) {
      return json;
    }
    if (json is List) {
      return _getListChildType<M>(
          json.map((e) => e as Map<String, dynamic>).toList());
    } else {
      return jsonConvert.convert<M>(json);
    }
  }
}