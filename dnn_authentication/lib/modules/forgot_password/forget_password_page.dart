import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final loginEditText = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.forgetPassword)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          switch (appContext.type) {
            AppTypeEnum.CLIENT =>
              const PageHeader(pgEnum: PagesEnum.forgetPassword),
            AppTypeEnum.COMPANY => const Text(
                'Por favor, insira o CNPJ da sua empresa para recuperação da senha.'),
            AppTypeEnum.SELLER => const Text(
                'Por favor, insira o CNPJ da sua empresa ou o seu CPF para recuperação da senha.'),
            int() => const PageHeader(pgEnum: PagesEnum.forgetPassword),
          },
          10.heightGap,
          Form(
            key: loginFormKey,
            child: switch (appContext.type) {
              AppTypeEnum.CLIENT => CPFInput(
                  controller: loginEditText,
                  showPrefix: false,
                  showHint: true,
                ),
              AppTypeEnum.COMPANY => CNPJInput(
                  controller: loginEditText,
                  showPrefix: false,
                  showHint: true,
                ),
              AppTypeEnum.SELLER => CPFCNPJInput(
                  controller: loginEditText,
                  showPrefix: false,
                  showHint: true,
                ),
              int() => CPFCNPJInput(
                  controller: loginEditText,
                  showPrefix: false,
                  showHint: true,
                ),
            },
          ),
          20.heightGap,
          Visibility(
            visible: Responsive.isTabletOrDesktop(),
            child: GetBuilder<AuthenticationController>(builder: (_) {
              return BottomConfirmButton(
                needHzPadding: false,
                isLoading: authenticationController.isLoading.value,
                title: 'Confirmar',
                onTap: () async {
                  if (loginFormKey.currentState!.validate()) {
                    final doc = loginEditText.text.removeDocumentMask();
                    await authenticationController.forgetPassword(doc);
                  }
                },
              );
            }),
          ),
          Visibility(
            visible: !Responsive.isTabletOrDesktop(),
            child: GetBuilder<AuthenticationController>(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomConfirmButton(
                    isLoading: authenticationController.isLoading.value,
                    title: 'Confirmar',
                    onTap: () async {
                      if (loginFormKey.currentState!.validate()) {
                        final doc = loginEditText.text.removeDocumentMask();
                        await authenticationController.forgetPassword(doc);
                      }
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
