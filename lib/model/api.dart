import 'package:axj_app/model/LogInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/adapter.dart';

import 'package:flutter/foundation.dart';

import 'cache.dart';

typedef JsonProcessor<T> = T Function(dynamic json);

const BaseUrl = "http://axj.ciih.net/";
const AuthorizationHeader = "Authorization";

class BaseResp<T> {
  String status;
  T data;
  String token;
  String text;

  BaseResp(this.status, this.data, this.token, this.text);

  BaseResp.error({String message = "失败", T data}) {
    this.status = "0";
    this.data = null;
    this.token = null;
    this.text = message;
  }

  BaseResp.success({String message = "成功"}) {
    this.status = "1";
    this.data = null;
    this.token = null;
    this.text = message;
  }

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{\r\n');
    sb.write("\"status\":\"$status\"");
    sb.write(",\r\n\"token\":$token");
    sb.write(",\r\n\"text\":\"$text\"");
    sb.write(",\r\n\"data\":\"$data\"");
    sb.write('\r\n}');
    return sb.toString();
  }

  bool get success => status == "1";
}

class Api {
  Api._() {
    init();
  }

  static bool proxyHttp = false;
  static bool printLog = true;
  static Api _instance;

  static Api getInstance() {
    if (_instance == null) {
      _instance = Api._();
    }
    return _instance;
  }

  factory Api() {
    return getInstance();
  }

  Dio _dio;

  void init() {
    _dio = Dio(BaseOptions(
      method: "POST",
      connectTimeout: 10000,
      receiveTimeout: 20000,
      baseUrl: BaseUrl,
    ));
    //设置代理
    if (proxyHttp)
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // config the http client
        client.findProxy = (uri) {
          //proxy all request to localhost:8888
          return "PROXY 192.168.99.181:8888";
        };
        // you can also create a new HttpClient to dio
        // return new HttpClient();
      };
    if (printLog) _dio.interceptors.add(DioLogInterceptor());
  }

  Future<BaseResp<T>> post<T>(
    String path, {
    @required JsonProcessor<T> processor,
    Map<String, dynamic> formData,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    ProgressCallback onSendProgress,
    useFormData: false,
  }) async {
    assert(processor != null);
    processor = processor ?? (dynamic raw) => null;
    formData = formData ?? {};
    cancelToken = cancelToken ?? CancelToken();
    onReceiveProgress = onReceiveProgress ??
        (count, total) {
          ///默认接收进度
        };
    onSendProgress = onSendProgress ??
        (count, total) {
          ///默认发送进度
        };
    return _dio
        .post(
      path,
      data: useFormData ? FormData.fromMap(formData) : formData,
      //FormData.fromMap(formData),
      options: RequestOptions(
        responseType: ResponseType.json,
        headers: {AuthorizationHeader: Cache().token},
      ),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    )
        .then((resp) {
      return resp.data;
    }).then((map) {
      dynamic status = map["status"];
      dynamic text = map["text"];
      dynamic token = map["token"];
      dynamic _rawData = map["data"];
      T data;
      try {
        data = processor(_rawData);
      } catch (e) {
        print(e);
      }
      return BaseResp<T>(
          status.toString(), data, token.toString(), text.toString());
    });
  }

  Future<BaseResp<T>> get<T>(
    String path, {
    @required JsonProcessor<T> processor,
    Map<String, dynamic> queryMap,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    assert(processor != null);
    processor = processor ?? (dynamic raw) => null;
    queryMap = queryMap ?? {};
    cancelToken = cancelToken ?? CancelToken();
    onReceiveProgress = onReceiveProgress ??
        (count, total) {
          ///默认接收进度
        };
    Response response = await _dio.get(
      path,
      queryParameters: queryMap,
      options: RequestOptions(
        responseType: ResponseType.json,
        headers: {AuthorizationHeader: Cache().token},
      ),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    Map<String, dynamic> map = response.data;
    dynamic status = map["status"];
    dynamic text = map["text"];
    dynamic token = map["token"];
    dynamic _rawData = map["data"];
    T data;
    try {
      data = processor(_rawData);
    } catch (e) {
      print(e);
    }
    return BaseResp<T>(
        status.toString(), data, token.toString(), text.toString());
  }
}
