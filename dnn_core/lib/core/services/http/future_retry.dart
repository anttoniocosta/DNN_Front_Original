import 'dart:developer';

class FutureRetry {
  static Future<T> retry<T>(Future<T> Function() action,
      {int maxAttempts = 5}) async {
    int attempt = 0;
    do {
      try {
        return await action();
      } catch (e) {
        attempt++;
        if (attempt == maxAttempts) {
          rethrow;
        }

        log('Tentativa $attempt falhou: $e');
        await Future.delayed(
            Duration(seconds: 2)); // espera antes de tentar novamente
      }
    } while (true);
  }
}
