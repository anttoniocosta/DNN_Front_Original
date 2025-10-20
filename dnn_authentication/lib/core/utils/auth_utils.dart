import 'package:dnn_core/all_exports.dart';

class AuthUtils {
  const AuthUtils._();

  static Future<bool> isAuthenticated() async {
    bool isAuth = false;
    final String? data = await storage.getToken();
    data != null ? isAuth = true : isAuth = false;
    return isAuth;
  }
}
