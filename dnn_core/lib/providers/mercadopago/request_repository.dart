import 'dart:developer';

import 'package:dio/dio.dart';

class Request {
  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );
  final _url = "https://api.mercadopago.com/";

  Future<dynamic> post(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $acessToken";
      _dio.options.headers['content-Type'] = 'application/json';

      log(_url + path);

      final result = await _dio.post(_url + path, data: data);
      log(result.data.toString());
      return result.data;
    } on DioException catch (e) {
      log(e.response!.data.toString());
      throw e.message!;
    }
  }

  Future<dynamic> put(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    try {
      _dio.options.headers["Authorization"] = "Bearer $acessToken";
      _dio.options.headers['content-Type'] = 'application/json';

      log(_url + path);

      final result = await _dio.put(_url + path, data: data);
      return result.data;
    } on DioException catch (e) {
      log(e.response!.data);
      throw e.message!;
    }
  }

  Future<dynamic> get(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    _dio.options.headers["Authorization"] = "Bearer $acessToken";
    _dio.options.headers['content-Type'] = 'application/json';

    // log('Bearer $acessToken');
    // log(_url + path);

    final result = await _dio.get(_url + path, queryParameters: data);
    return result.data;
  }

  Future<dynamic> delete(
      {required String path,
      required String acessToken,
      Map<String, dynamic> data = const {}}) async {
    _dio.options.headers["Authorization"] = "Bearer $acessToken";
    _dio.options.headers['content-Type'] = 'application/json';

    final result = await _dio.delete(_url + path);
    return result.data;
  }
}
