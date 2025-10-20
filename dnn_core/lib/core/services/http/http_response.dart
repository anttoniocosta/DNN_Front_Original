import 'package:meta/meta.dart' show required;

//Classe genérica para respostas http.
class HttpResponse<T> {
  final T? data;
  final HttpError? error;

  HttpResponse(this.data, this.error);

  // ignore: null_check_always_fails
  static HttpResponse<T> success<T>(T data) => HttpResponse(data, null);

  static HttpResponse<T> fail<T>({
    @required int? statusCode,
    @required String? message,
    @required dynamic data,
  }) =>
      HttpResponse(
        // ignore: null_check_always_fails
        null,
        // ignore: dead_code
        HttpError(
          statusCode: statusCode,
          message: message,
          data: data,
        ),
      );
}

class HttpError {
  final int? statusCode;
  final String? message;
  final dynamic data;

  HttpError({
    @required this.statusCode,
    @required this.message,
    @required this.data,
  });
}
