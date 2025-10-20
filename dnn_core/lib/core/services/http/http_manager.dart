import 'dart:convert';
import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:flutter/material.dart';

abstract class HttpMethods {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
  static const String put = 'PUT';
}

class HttpManager {
  final Dio _dio;

  HttpManager(this._dio) {
    // if (kReleaseMode) _dio.interceptors.add(TelegramInterceptor());
    final myStatuses = {
      408,
      429,
      503,
      504,
      460,
      499,
      520,
      521,
      522,
      523,
      524,
      525,
      598,
      599
    };
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: log,
        retries: 6,
        retryEvaluator: DefaultRetryEvaluator(myStatuses).evaluate,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 2),
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 2),
          // Duration(seconds: 1),
          // Duration(seconds: 2),
          // Duration(seconds: 2),
        ],
      ),
    );
    _dio.options.connectTimeout = Duration(minutes: 4);
    _dio.options.receiveTimeout = Duration(minutes: 4);
    _dio.options.receiveDataWhenStatusError = true;
  }

  Future<HttpResponse<T>> request<T>({
    required String path,
    String method = 'GET',
    Map? headers,
    String? baseUrl,
    String? contentType,
    Map? body,
    Map<String, dynamic>? formData,
    T Function(dynamic data)? parser,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'Content-type': 'application/json',
        'api-key': 'RG5uQXBpOiNEbm5BcGlAMjAyMw==',
        'Accept-Encoding': 'gzip, deflate, br',
        'Authorization': 'Bearer ${await storage.getToken()}'
      });

    try {
      if (baseUrl != null) {
        debugPrint('baseUrl $baseUrl');
      } else {
        debugPrint('link: ${dnnController.apiUrl}$path');
      }
      if (body != null) {
        debugPrint('Body: ${jsonEncode(body)}');
      }

      final response = await _dio.request(
        baseUrl ?? '${dnnController.apiUrl}$path',
        options: Options(
          method: method,
          contentType: contentType,
          headers: defaultHeaders,
        ),
        data: formData != null ? FormData.fromMap(formData) : body,
      );
      if (parser != null) {
        return HttpResponse.success<T>(parser(response.data));
      }
      // ignore: argument_type_not_assignable
      return HttpResponse.success<T>(response.data);
    } on DioException catch (e) {
      var statusCode = 0;
      var message = 'Falha.';
      dynamic data;
      ResultError? resultError;
      statusCode = -1;
      message = e.message!;
      try {
        resultError = ResultError.fromJson(e.response!.data!);
      } catch (ef0) {}
      if (e.response != null) {
        if (resultError != null) {
          statusCode = resultError.code;
          message = resultError.error;
        } else {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
        }
        data = e.response!.data;
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
