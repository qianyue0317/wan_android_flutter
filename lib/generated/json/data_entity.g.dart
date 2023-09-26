import 'package:wan_android_flutter/generated/json/base/json_convert_content.dart';
import 'package:wan_android_flutter/network/bean/data_entity.dart';

DataEntity $DataEntityFromJson(Map<String, dynamic> json) {
  final DataEntity dataEntity = DataEntity();
  final int? curPage = jsonConvert.convert<int>(json['curPage']);
  if (curPage != null) {
    dataEntity.curPage = curPage;
  }
  final List<ArticleItemEntity>? datas = (json['datas'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ArticleItemEntity>(e) as ArticleItemEntity).toList();
  if (datas != null) {
    dataEntity.datas = datas;
  }
  final int? offset = jsonConvert.convert<int>(json['offset']);
  if (offset != null) {
    dataEntity.offset = offset;
  }
  final bool? over = jsonConvert.convert<bool>(json['over']);
  if (over != null) {
    dataEntity.over = over;
  }
  final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
  if (pageCount != null) {
    dataEntity.pageCount = pageCount;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    dataEntity.size = size;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    dataEntity.total = total;
  }
  return dataEntity;
}

Map<String, dynamic> $DataEntityToJson(DataEntity entity) {
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

extension DataEntityExtension on DataEntity {
  DataEntity copyWith({
    int? curPage,
    List<ArticleItemEntity>? datas,
    int? offset,
    bool? over,
    int? pageCount,
    int? size,
    int? total,
  }) {
    return DataEntity()
      ..curPage = curPage ?? this.curPage
      ..datas = datas ?? this.datas
      ..offset = offset ?? this.offset
      ..over = over ?? this.over
      ..pageCount = pageCount ?? this.pageCount
      ..size = size ?? this.size
      ..total = total ?? this.total;
  }
}

ArticleItemEntity $ArticleItemEntityFromJson(Map<String, dynamic> json) {
  final ArticleItemEntity articleItem = ArticleItemEntity();
  final bool? adminAdd = jsonConvert.convert<bool>(json['adminAdd']);
  if (adminAdd != null) {
    articleItem.adminAdd = adminAdd;
  }
  final String? apkLink = jsonConvert.convert<String>(json['apkLink']);
  if (apkLink != null) {
    articleItem.apkLink = apkLink;
  }
  final int? audit = jsonConvert.convert<int>(json['audit']);
  if (audit != null) {
    articleItem.audit = audit;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    articleItem.author = author;
  }
  final bool? canEdit = jsonConvert.convert<bool>(json['canEdit']);
  if (canEdit != null) {
    articleItem.canEdit = canEdit;
  }
  final int? chapterId = jsonConvert.convert<int>(json['chapterId']);
  if (chapterId != null) {
    articleItem.chapterId = chapterId;
  }
  final String? chapterName = jsonConvert.convert<String>(json['chapterName']);
  if (chapterName != null) {
    articleItem.chapterName = chapterName;
  }
  final bool? collect = jsonConvert.convert<bool>(json['collect']);
  if (collect != null) {
    articleItem.collect = collect;
  }
  final int? courseId = jsonConvert.convert<int>(json['courseId']);
  if (courseId != null) {
    articleItem.courseId = courseId;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    articleItem.desc = desc;
  }
  final String? descMd = jsonConvert.convert<String>(json['descMd']);
  if (descMd != null) {
    articleItem.descMd = descMd;
  }
  final String? envelopePic = jsonConvert.convert<String>(json['envelopePic']);
  if (envelopePic != null) {
    articleItem.envelopePic = envelopePic;
  }
  final bool? fresh = jsonConvert.convert<bool>(json['fresh']);
  if (fresh != null) {
    articleItem.fresh = fresh;
  }
  final String? host = jsonConvert.convert<String>(json['host']);
  if (host != null) {
    articleItem.host = host;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    articleItem.id = id;
  }
  final bool? isAdminAdd = jsonConvert.convert<bool>(json['isAdminAdd']);
  if (isAdminAdd != null) {
    articleItem.isAdminAdd = isAdminAdd;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    articleItem.link = link;
  }
  final String? niceDate = jsonConvert.convert<String>(json['niceDate']);
  if (niceDate != null) {
    articleItem.niceDate = niceDate;
  }
  final String? niceShareDate = jsonConvert.convert<String>(
      json['niceShareDate']);
  if (niceShareDate != null) {
    articleItem.niceShareDate = niceShareDate;
  }
  final String? origin = jsonConvert.convert<String>(json['origin']);
  if (origin != null) {
    articleItem.origin = origin;
  }
  final String? prefix = jsonConvert.convert<String>(json['prefix']);
  if (prefix != null) {
    articleItem.prefix = prefix;
  }
  final String? projectLink = jsonConvert.convert<String>(json['projectLink']);
  if (projectLink != null) {
    articleItem.projectLink = projectLink;
  }
  final int? publishTime = jsonConvert.convert<int>(json['publishTime']);
  if (publishTime != null) {
    articleItem.publishTime = publishTime;
  }
  final int? realSuperChapterId = jsonConvert.convert<int>(
      json['realSuperChapterId']);
  if (realSuperChapterId != null) {
    articleItem.realSuperChapterId = realSuperChapterId;
  }
  final int? selfVisible = jsonConvert.convert<int>(json['selfVisible']);
  if (selfVisible != null) {
    articleItem.selfVisible = selfVisible;
  }
  final int? shareDate = jsonConvert.convert<int>(json['shareDate']);
  if (shareDate != null) {
    articleItem.shareDate = shareDate;
  }
  final String? shareUser = jsonConvert.convert<String>(json['shareUser']);
  if (shareUser != null) {
    articleItem.shareUser = shareUser;
  }
  final int? superChapterId = jsonConvert.convert<int>(json['superChapterId']);
  if (superChapterId != null) {
    articleItem.superChapterId = superChapterId;
  }
  final String? superChapterName = jsonConvert.convert<String>(
      json['superChapterName']);
  if (superChapterName != null) {
    articleItem.superChapterName = superChapterName;
  }
  final List<dynamic>? tags = (json['tags'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (tags != null) {
    articleItem.tags = tags;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    articleItem.title = title;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    articleItem.type = type;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    articleItem.userId = userId;
  }
  final int? visible = jsonConvert.convert<int>(json['visible']);
  if (visible != null) {
    articleItem.visible = visible;
  }
  final int? zan = jsonConvert.convert<int>(json['zan']);
  if (zan != null) {
    articleItem.zan = zan;
  }
  return articleItem;
}

Map<String, dynamic> $ArticleItemEntityToJson(ArticleItemEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['adminAdd'] = entity.adminAdd;
  data['apkLink'] = entity.apkLink;
  data['audit'] = entity.audit;
  data['author'] = entity.author;
  data['canEdit'] = entity.canEdit;
  data['chapterId'] = entity.chapterId;
  data['chapterName'] = entity.chapterName;
  data['collect'] = entity.collect;
  data['courseId'] = entity.courseId;
  data['desc'] = entity.desc;
  data['descMd'] = entity.descMd;
  data['envelopePic'] = entity.envelopePic;
  data['fresh'] = entity.fresh;
  data['host'] = entity.host;
  data['id'] = entity.id;
  data['isAdminAdd'] = entity.isAdminAdd;
  data['link'] = entity.link;
  data['niceDate'] = entity.niceDate;
  data['niceShareDate'] = entity.niceShareDate;
  data['origin'] = entity.origin;
  data['prefix'] = entity.prefix;
  data['projectLink'] = entity.projectLink;
  data['publishTime'] = entity.publishTime;
  data['realSuperChapterId'] = entity.realSuperChapterId;
  data['selfVisible'] = entity.selfVisible;
  data['shareDate'] = entity.shareDate;
  data['shareUser'] = entity.shareUser;
  data['superChapterId'] = entity.superChapterId;
  data['superChapterName'] = entity.superChapterName;
  data['tags'] = entity.tags;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['userId'] = entity.userId;
  data['visible'] = entity.visible;
  data['zan'] = entity.zan;
  return data;
}

extension ArticleItemEntityExtension on ArticleItemEntity {
  ArticleItemEntity copyWith({
    bool? adminAdd,
    String? apkLink,
    int? audit,
    String? author,
    bool? canEdit,
    int? chapterId,
    String? chapterName,
    bool? collect,
    int? courseId,
    String? desc,
    String? descMd,
    String? envelopePic,
    bool? fresh,
    String? host,
    int? id,
    bool? isAdminAdd,
    String? link,
    String? niceDate,
    String? niceShareDate,
    String? origin,
    String? prefix,
    String? projectLink,
    int? publishTime,
    int? realSuperChapterId,
    int? selfVisible,
    int? shareDate,
    String? shareUser,
    int? superChapterId,
    String? superChapterName,
    List<dynamic>? tags,
    String? title,
    int? type,
    int? userId,
    int? visible,
    int? zan,
  }) {
    return ArticleItemEntity()
      ..adminAdd = adminAdd ?? this.adminAdd
      ..apkLink = apkLink ?? this.apkLink
      ..audit = audit ?? this.audit
      ..author = author ?? this.author
      ..canEdit = canEdit ?? this.canEdit
      ..chapterId = chapterId ?? this.chapterId
      ..chapterName = chapterName ?? this.chapterName
      ..collect = collect ?? this.collect
      ..courseId = courseId ?? this.courseId
      ..desc = desc ?? this.desc
      ..descMd = descMd ?? this.descMd
      ..envelopePic = envelopePic ?? this.envelopePic
      ..fresh = fresh ?? this.fresh
      ..host = host ?? this.host
      ..id = id ?? this.id
      ..isAdminAdd = isAdminAdd ?? this.isAdminAdd
      ..link = link ?? this.link
      ..niceDate = niceDate ?? this.niceDate
      ..niceShareDate = niceShareDate ?? this.niceShareDate
      ..origin = origin ?? this.origin
      ..prefix = prefix ?? this.prefix
      ..projectLink = projectLink ?? this.projectLink
      ..publishTime = publishTime ?? this.publishTime
      ..realSuperChapterId = realSuperChapterId ?? this.realSuperChapterId
      ..selfVisible = selfVisible ?? this.selfVisible
      ..shareDate = shareDate ?? this.shareDate
      ..shareUser = shareUser ?? this.shareUser
      ..superChapterId = superChapterId ?? this.superChapterId
      ..superChapterName = superChapterName ?? this.superChapterName
      ..tags = tags ?? this.tags
      ..title = title ?? this.title
      ..type = type ?? this.type
      ..userId = userId ?? this.userId
      ..visible = visible ?? this.visible
      ..zan = zan ?? this.zan;
  }
}