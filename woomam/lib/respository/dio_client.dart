import 'dart:developer';

import 'package:dio_http/dio_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './end_point.dart';

class DioClient {
  /// constructor of Dio, used for http management
  DioClient({required this.prefs});

  /// save token in [SharedPreferences]
  SharedPreferences prefs;

  /// variables
  static final endPoint = EndPoint();
  static final _baseURL = endPoint.baseURL;
  static final _options = BaseOptions(
      baseUrl: _baseURL,
      responseType: ResponseType.json,
      connectTimeout: 3000,
      receiveTimeout: 3000);

  static String? accessToken;

  /// methods
  static Dio init() => Dio(_options);

  static Dio addInterceptorWithTokenRefresher(Dio dio) => dio
    ..interceptors.add(InterceptorsWrapper(

        /// before sending request
        onRequest: (options, handler) async {
      /// if token is null get new token
      if (accessToken == null) {
      }

      /// keep going on to next step
      else {}
    },

        /// after sending request and got error
        onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        /// assume that statusCode returned with 401 means token is not validate any more!
      }
    }

        /// after receiving response
        ));

  static Future<String> updateToken(RequestOptions options) async {
    /// the user gets token when it logged-in
    /// so need another logic to receive token
    /// with verifying the current token
    return '';
  }

  static Future<bool> verifyToken(RequestOptions options) async {
    /// same as [updateToken] metohd above
    /// currently we don't have appropriate logic to verify current token
    return false;
  }

  /// set the dio for usage
  static final dioClient = init();

  /// add Interceptor when it is ready

  /// [body] needs wrapped up with `jsonEncode()`
  /// [path] needs to be only path after baseURL ex) '/signin'
  Future<Response> httpPost(path, body) async {
    try {
      return await dioClient.post(path, data: body);
    } on DioError catch (e) {
      log(e.toString(), name: 'httpPost-Dio');
      rethrow;
    }
  }

  /// [path] needs to be only path after baseURL ex) '/signin'
  Future<Response> httpGet(path) async {
    try {
      return await dioClient.get(path);
    } on DioError catch (e) {
      log(e.toString(), name: 'httpGet-Dio');
      rethrow;
    }
  }

  /// [body] needs wrapped up with `jsonEncode()`
  /// [path] needs to be only path after baseURL ex) '/signin'
  Future<Response> httpPatch(path, body) async {
    try {
      return await dioClient.patch(path, data: body);
    } on DioError catch (e) {
      log(e.toString(), name: 'httpPatch-Dio');
      rethrow;
    }
  }

  /// [body] needs wrapped up with `jsonEncode()`
  /// [path] needs to be only path after baseURL ex) '/signin'
  Future<Response> httpDelete(path, body) async {
    try {
      return await dioClient.delete(path, data: body);
    } on DioError catch (e) {
      log(e.toString(), name: 'httpDelete-Dio');
      rethrow;
    }
  }
}
