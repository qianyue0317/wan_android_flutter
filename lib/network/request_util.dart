
import 'package:dio/dio.dart';
import 'package:wan_android_flutter/utils/log_util.dart';

import 'bean/AppResponse.dart';

// 是否用compute异步
bool useCompute = false;
bool configured = false;

Duration _connectTimeout = const Duration(seconds: 10);
Duration _receiveTimeout = const Duration(seconds: 10);
Duration _sendTimeout = const Duration(seconds: 10);
String _baseUrl = "";
List<Interceptor> _interceptors = [];



void configDio({
  Duration? connectTimeout,
  Duration? receiveTimeout,
  Duration? sendTimeout,
  String? baseUrl,
  List<Interceptor>? interceptors,
}) {
  configured = true;
  _connectTimeout = connectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}


class HttpGo {
  late Dio _dio;

  static final HttpGo _singleton = HttpGo._internal();

  static HttpGo get instance => _singleton;

  HttpGo._internal() {
    if (!configured) {
        WanLog.w("you have not config the dio!");
    }
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl, connectTimeout: _connectTimeout, receiveTimeout: _receiveTimeout, sendTimeout: _sendTimeout
    ));
  }

}


