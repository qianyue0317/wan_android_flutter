import 'package:wan_android_flutter/constants/constants.dart';

import '../../generated/json/base/json_convert_content.dart';

class AppResponse<T> {
  int errorCode = -1;
  String? errorMsg;
  T? data;

  AppResponse(this.errorCode, this.errorMsg, this.data);

  AppResponse.fromJson(Map<String, dynamic> map) {
    errorCode = (map['errorCode'] as int?) ?? -1;
    errorMsg = map['errorMsg'] as String?;
    if (map.containsKey('data')) {
      data = _generateOBJ(map['data']);
    }
  }

  T? _generateOBJ<O>(Object? json) {
    if (json == null) {
      return null;
    }
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }

  bool get isSuccessful  => errorCode == Constant.successCode;
}
