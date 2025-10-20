import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_authentication/shared/validator/auth_validators.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formPassword = GlobalKey<FormState>();

  @override
  void initState() {
    authenticationController.clear();
    super.initState();
  }

  @override
  void dispose() {
    authenticationController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      title: pagesController.currentPage(PagesEnum.changePassword)?.name,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<AuthenticationController>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightGap,
              Form(
                key: formPassword,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PasswordInput(
                      label: 'Senha atual',
                      controller: authenticationController.password,
                      showIcon: true,
                    ),
                    PasswordInput(
                      label: 'Nova senha',
                      controller: authenticationController.newPassword,
                      showIcon: true,
                    ),
                    PasswordInput(
                      label: 'Digite novamente a senha',
                      controller: authenticationController.confirmPassword,
                      showIcon: true,
                      validator: AuthValidators.confirmPasswordValidator,
                    ),
                  ],
                ),
              ),
              20.heightGap,
              GetBuilder<AuthenticationController>(
                builder: (_) {
                  return BottomConfirmButton(
                    isLoading: authenticationController.isLoadingPassword.value,
                    title: 'Confirmar',
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (formPassword.currentState!.validate()) {
                        await authenticationController.updatePassword();
                      }
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
