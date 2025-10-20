import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPartial extends StatelessWidget {
  SignInPartial({
    super.key,
    required this.signInAction,
    this.acessWithProviders = true,
    required this.buttonRegisterTitle,
  });

  final bool? acessWithProviders;
  final VoidCallback signInAction;
  final String buttonRegisterTitle;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        24.heightGap,
        const Center(
          child: SignInImage(),
        ),
        24.heightGap,
        Text(
          'Olá, bem-vindo(a)!',
          style: Fonts.titleMedium(context),
        ).paddingSymmetric(vertical: 20),
        GetBuilder<AuthenticationController>(
          builder: (_) => Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                switch (appContext.type) {
                  AppTypeEnum.CLIENT || AppTypeEnum.SPECIALIST => CPFInput(
                      controller: authenticationController.login,
                      showPrefix: false,
                      showHint: true,
                    ),
                  AppTypeEnum.COMPANY || AppTypeEnum.CLINIC => CNPJInput(
                      controller: authenticationController.login,
                      showPrefix: false,
                      showHint: true,
                    ),
                  AppTypeEnum.SELLER => CPFCNPJInput(
                      controller: authenticationController.login,
                      showPrefix: false,
                      showHint: true,
                    ),
                  int() => CPFInput(
                      controller: authenticationController.login,
                      showPrefix: false,
                      showHint: true,
                    ),
                },
                15.heightGap,
                PasswordInput(
                    label: 'Senha',
                    controller: authenticationController.password),
              ],
            ),
          ),
        ),
        10.heightGap,
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => Get.toNamed(Routes.forgetPassword),
            child: Text(
              'Esqueceu a senha?',
              // style: Fonts.titleSmall(context),
              style: TextStyle(
                  fontFamily: Fonts.nexaFontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueColor),
            ).paddingSymmetric(horizontal: 5),
          ),
        ),
        22.heightGap,
        GetBuilder<AuthenticationController>(
          builder: (_) => PrimaryButtonWidget(
            isLoading: authenticationController.isLoading.value,
            titleButtom: 'Entrar',
            onTap: () async {
              FocusScope.of(Get.context!).unfocus();
              if (_formKey.currentState!.validate()) {
                await authenticationController.signIn(signInAction);
              }
            },
          ),
        ),
        10.heightGap,
        if (appContext.type != AppTypeEnum.SPECIALIST) ...[
          // ProvidersAcess(
          //   acessWithProviders: acessWithProviders!,
          //   signInAction: signInAction,
          // ),
          15.heightGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 150,
                child: Divider(color: AppColors.greyColor),
              ),
              10.widthGap,
              Text('ou',
                      style: Fonts.bodyLarge(context).copyWith(
                          color: AppColors.darkGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))
                  .toCenter,
              10.widthGap,
              const SizedBox(
                width: 150,
                child: Divider(color: AppColors.greyColor),
              ),
            ],
          ),
          20.heightGap,
          _buttonRegister(context),
        ],
        const VersionTextWidget().paddingSymmetric(vertical: 25).toCenter,
        60.heightGap,
      ],
    ).toCenter;
  }

  _buttonRegister(context) {
    return GestureDetector(
      onTap: () => _registerAction(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Não possui uma conta?',
            style: Fonts.bodyLarge(context),
          ),
          10.widthGap,
          Text('Inscreva-se',
              style: Fonts.bodyLarge(context).copyWith(
                color: AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }

  _registerAction() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        Get.toNamed(Routes.registerPersonal);
        break;
      case AppTypeEnum.COMPANY:
        Get.toNamed(Routes.registerCompany);
        break;
      case AppTypeEnum.CLINIC:
        Get.toNamed(Routes.registerClinic);
        break;
      case AppTypeEnum.SELLER:
        Get.toNamed(Routes.registerType);
        break;
      default:
    }
  }
}
