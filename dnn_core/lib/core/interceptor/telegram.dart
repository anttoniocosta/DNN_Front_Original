import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'telegram_logs.dart';

class TelegramInterceptor extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (err.response != null && err.response!.statusCode != null) {
      final fileJson = {
        'createAt': DateTime.now().toString(),
        'app': {
          'name': packageInfo.appName,
          'version': packageInfo.version,
          'buildNumber': packageInfo.buildNumber,
        },
        'request': {
          'path': err.requestOptions.path,
          'headers': err.requestOptions.headers,
          'data': err.requestOptions.data
        },
        'response': {
          'statusCode': err.response?.statusCode,
          'message': err.response?.statusMessage,
          'data': err.response?.data
        }
      };
      await TelegramLogs.sendMessage(
          '(API) Detectamos um erro no acesso ao backend. Equipe, por favor, realize a análise. Data do incidente: ${DateTime.now().toString()}');
      await TelegramLogs.sendDocument(fileJson, null, 'rest_error.json');
    }
    super.onError(err, handler);
  }
}
