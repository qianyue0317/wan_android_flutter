import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/my_shared_data_entity.dart';
import 'package:wan_android_flutter/network/bean/article_data_entity.dart';


MySharedDataEntity $MySharedDataEntityFromJson(Map<String, dynamic> json) {
  final MySharedDataEntity mySharedDataEntity = MySharedDataEntity();
  final MySharedDataCoinInfo? coinInfo = jsonConvert.convert<
      MySharedDataCoinInfo>(json['coinInfo']);
  if (coinInfo != null) {
    mySharedDataEntity.coinInfo = coinInfo;
  }
  final MySharedDataShareArticles? shareArticles = jsonConvert.convert<
      MySharedDataShareArticles>(json['shareArticles']);
  if (shareArticles != null) {
    mySharedDataEntity.shareArticles = shareArticles;
  }
  return mySharedDataEntity;
}

Map<String, dynamic> $MySharedDataEntityToJson(MySharedDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['coinInfo'] = entity.coinInfo.toJson();
  data['shareArticles'] = entity.shareArticles.toJson();
  return data;
}

extension MySharedDataEntityExtension on MySharedDataEntity {
  MySharedDataEntity copyWith({
    MySharedDataCoinInfo? coinInfo,
    MySharedDataShareArticles? shareArticles,
  }) {
    return MySharedDataEntity()
      ..coinInfo = coinInfo ?? this.coinInfo
      ..shareArticles = shareArticles ?? this.shareArticles;
  }
}

MySharedDataCoinInfo $MySharedDataCoinInfoFromJson(Map<String, dynamic> json) {
  final MySharedDataCoinInfo mySharedDataCoinInfo = MySharedDataCoinInfo();
  final int? coinCount = jsonConvert.convert<int>(json['coinCount']);
  if (coinCount != null) {
    mySharedDataCoinInfo.coinCount = coinCount;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    mySharedDataCoinInfo.level = level;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    mySharedDataCoinInfo.nickname = nickname;
  }
  final String? rank = jsonConvert.convert<String>(json['rank']);
  if (rank != null) {
    mySharedDataCoinInfo.rank = rank;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    mySharedDataCoinInfo.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    mySharedDataCoinInfo.username = username;
  }
  return mySharedDataCoinInfo;
}

Map<String, dynamic> $MySharedDataCoinInfoToJson(MySharedDataCoinInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['coinCount'] = entity.coinCount;
  data['level'] = entity.level;
  data['nickname'] = entity.nickname;
  data['rank'] = entity.rank;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  return data;
}

extension MySharedDataCoinInfoExtension on MySharedDataCoinInfo {
  MySharedDataCoinInfo copyWith({
    int? coinCount,
    int? level,
    String? nickname,
    String? rank,
    int? userId,
    String? username,
  }) {
    return MySharedDataCoinInfo()
      ..coinCount = coinCount ?? this.coinCount
      ..level = level ?? this.level
      ..nickname = nickname ?? this.nickname
      ..rank = rank ?? this.rank
      ..userId = userId ?? this.userId
      ..username = username ?? this.username;
  }
}

MySharedDataShareArticles $MySharedDataShareArticlesFromJson(
    Map<String, dynamic> json) {
  final MySharedDataShareArticles mySharedDataShareArticles = MySharedDataShareArticles();
  final int? curPage = jsonConvert.convert<int>(json['curPage']);
  if (curPage != null) {
    mySharedDataShareArticles.curPage = curPage;
  }
  final List<ArticleItemEntity>? datas = (json['datas'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ArticleItemEntity>(e) as ArticleItemEntity)
      .toList();
  if (datas != null) {
    mySharedDataShareArticles.datas = datas;
  }
  final int? offset = jsonConvert.convert<int>(json['offset']);
  if (offset != null) {
    mySharedDataShareArticles.offset = offset;
  }
  final bool? over = jsonConvert.convert<bool>(json['over']);
  if (over != null) {
    mySharedDataShareArticles.over = over;
  }
  final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
  if (pageCount != null) {
    mySharedDataShareArticles.pageCount = pageCount;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    mySharedDataShareArticles.size = size;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    mySharedDataShareArticles.total = total;
  }
  return mySharedDataShareArticles;
}

Map<String, dynamic> $MySharedDataShareArticlesToJson(
    MySharedDataShareArticles entity) {
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

extension MySharedDataShareArticlesExtension on MySharedDataShareArticles {
  MySharedDataShareArticles copyWith({
    int? curPage,
    List<ArticleItemEntity>? datas,
    int? offset,
    bool? over,
    int? pageCount,
    int? size,
    int? total,
  }) {
    return MySharedDataShareArticles()
      ..curPage = curPage ?? this.curPage
      ..datas = datas ?? this.datas
      ..offset = offset ?? this.offset
      ..over = over ?? this.over
      ..pageCount = pageCount ?? this.pageCount
      ..size = size ?? this.size
      ..total = total ?? this.total;
  }
}