import 'dart:convert';

import 'package:dnn_dependencies/dnn_dependencies.dart';

class TelegramLogs {
  static Future<void> sendMessage(String message) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(minutes: 3),
        receiveTimeout: const Duration(minutes: 3),
      ),
    );
    await dio.post(
        'https://api.telegram.org/bot6002269454:AAFCimiOGZEsrJ_V-FYv5XVuAqgk28hFKAk/sendMessage',
        data: {'chat_id': '-1001862032689', 'text': message});
  }

  static Future<void> sendDocument(
      Map<String, Object> fileJson, String? caption, String? fileName) async {
    const encoder = JsonEncoder.withIndent(' ');

    final formData = FormData.fromMap({
      'chat_id': '-1001862032689',
      'document': MultipartFile.fromString(
        encoder.convert(fileJson),
        filename: fileName ?? 'error.json',
      ),
      'caption': caption ?? 'Segue o arquivo para analise'
    });

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(minutes: 3),
        receiveTimeout: const Duration(minutes: 3),
      ),
    );
    await dio.post(
        'https://api.telegram.org/bot6002269454:AAFCimiOGZEsrJ_V-FYv5XVuAqgk28hFKAk/sendDocument',
        data: formData);
  }
}
