import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import "package:path_provider/path_provider.dart";
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
        //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain,
        baseUrl: _baseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout));
    Future<Directory> dirResult = getApplicationDocumentsDirectory();
    dirResult.then((value) {
      _dio.interceptors.add(CookieManager(
          PersistCookieJar(storage: FileStorage("${value.path}/.cookies/"))));
    });
    _dio.interceptors.addAll(_interceptors);
  }

  Future<AppResponse<T>> request<T>(String url, String method,
      {Object? data,
      Map<String, dynamic>? queryParams,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? progressCallback,
      ProgressCallback? receiveCallback}) async {
    Response<String> response = await _dio.request(url,
        data: data,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        options: (options ?? Options())..method = method,
        onSendProgress: progressCallback,
        onReceiveProgress: receiveCallback);
    Map<String, dynamic> map = json.decode(response.data.toString());
    AppResponse<T> result = AppResponse.fromJson(map);
    return result;
  }

  Future<AppResponse<T>> get<T>(String url,
      {Object? data,
      Map<String, dynamic>? queryParams,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? progressCallback,
      ProgressCallback? receiveCallback}) async {
    return request(url, "GET",
        data: data,
        queryParams: queryParams,
        cancelToken: cancelToken,
        options: options,
        progressCallback: progressCallback,
        receiveCallback: receiveCallback);
  }

  Future<AppResponse<T>> post<T>(String url,
      {Object? data,
      Map<String, dynamic>? queryParams,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? progressCallback,
      ProgressCallback? receiveCallback}) async {
    return request(url, "POST",
        data: data,
        queryParams: queryParams,
        cancelToken: cancelToken,
        options: options,
        progressCallback: progressCallback,
        receiveCallback: receiveCallback);
  }

  Future<AppResponse<T>> delete<T>(String url,
      {Object? data,
      Map<String, dynamic>? queryParams,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? progressCallback,
      ProgressCallback? receiveCallback}) async {
    return request(url, "DELETE",
        data: data,
        queryParams: queryParams,
        cancelToken: cancelToken,
        options: options,
        progressCallback: progressCallback,
        receiveCallback: receiveCallback);
  }

  Future<AppResponse<T>> put<T>(String url,
      {Object? data,
      Map<String, dynamic>? queryParams,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? progressCallback,
      ProgressCallback? receiveCallback}) async {
    return request(url, "PUT",
        data: data,
        queryParams: queryParams,
        cancelToken: cancelToken,
        options: options,
        progressCallback: progressCallback,
        receiveCallback: receiveCallback);
  }
}
