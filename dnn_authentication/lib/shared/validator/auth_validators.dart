import 'package:dnn_authentication/dnn_authentication.dart';

class AuthValidators {
  static String? confirmPasswordValidator(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Digite a sua senha novamente.';
    }
    if (senha != authenticationController.newPassword.text) {
      return 'As senhas não coincidem!';
    }
    return null;
  }
}
