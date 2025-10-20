import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dnn_shared.dart';

abstract class CustomDialogs {
  static confirmDialog({
    required String title,
    required VoidCallback backAcion,
    required VoidCallback confirmAcion,
    required BuildContext context,
    required bool backVisible,
    String? confirmTitle,
    Widget? content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: AppConstants.pdHorizontal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          title: Text(
            title,
            style: Fonts.titleMedium(context),
            textAlign: TextAlign.start,
          ),
          content: SizedBox(width: 425, child: content),
          actions: [
            if (backVisible == true)
              TextButton(
                onPressed: backAcion,
                child: Text(
                  'Cancelar',
                  style: Fonts.titleMedium(context)
                      .copyWith(color: AppColors.redColor),
                ),
              ),
            TextButton(
              onPressed: confirmAcion,
              child: Text(
                confirmTitle ?? 'Confirmar',
                style: Fonts.titleMedium(context),
              ),
            )
          ],
        );
      },
    );
  }

  static modalBottomSheet(
      {required BuildContext context, required Widget content}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        );
      },
    );
  }

  static simpleDialog(
      {required String title,
      required BuildContext context,
      required Widget content,
      List<CupertinoDialogAction>? actions,
      bool? isDismissible = true}) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible!,
      builder: (context) {
        return AlertDialog(
          contentPadding: AppConstants.pdHorizontal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium.h),
          ),
          actions: actions ?? const <Widget>[],
          titlePadding: EdgeInsets.zero,
          content: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: 425,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    30.heightGap,
                    Text(
                      title,
                      style: Fonts.headlineMedium(context),
                      textAlign: TextAlign.start,
                    ),
                    10.heightGap,
                    content,
                  ],
                ),
              ),
              Positioned(
                  top: -15,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Get.back(),
                    child: AbsorbPointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(boxShadow: highElevation),
                        child: CircleAvatar(
                          backgroundColor: Get.isDarkMode
                              ? AppColors.midBlackColor
                              : AppColors.whiteColor,
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon: FaIcon(
                              FontAwesomeIcons.xmark,
                              color: Get.isDarkMode
                                  ? AppColors.whiteColor
                                  : AppColors.midBlackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }

  static shoppingCartDialog({
    required VoidCallback continueOnTap,
    required VoidCallback goToReume,
    required VoidCallback cancelOnTap,
    bool needGetBack = false,
  }) {
    simpleDialog(
      title: 'Você já iniciou um processo de compra, deseja continuar?',
      context: Get.context!,
      isDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SecondaryButtonWidget(
            onTap: continueOnTap,
            titleButtom: 'Continuar comprando',
          ),
          Visibility(
            visible: navigationController.isLogged,
            child: PrimaryButtonWidget(
              onTap: goToReume,
              titleButtom: 'Ir para resumo da compra',
            ).paddingOnly(top: 6),
          ),
          6.heightGap,
          PrimaryButtonWidget(
            onTap: cancelOnTap,
            titleButtom: 'Limpar carrinho',
          ),
          16.heightGap,
          Visibility(
            visible: needGetBack,
            child: PrimaryButtonWidget(
              onTap: () => Get.back(),
              titleButtom: 'Voltar',
            ).paddingOnly(top: 6),
          ),
        ],
      ),
    );
  }

  static shoppingAlreadyHavePlan(
      {required VoidCallback addToDependent,
      required VoidCallback goToReume,
      required String title}) {
    simpleDialog(
      title: title,
      context: Get.context!,
      isDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          6.heightGap,
          SecondaryButtonWidget(
            onTap: addToDependent,
            titleButtom: 'Continuar',
          ),
          6.heightGap,
          PrimaryButtonWidget(
            onTap: goToReume,
            titleButtom: 'Ir para resumo da compra',
          ),
        ],
      ),
    );
  }

  static permissonDialog({required String campaignRoute}) {
    simpleDialog(
      title:
          'Parece que você não tem um plano ativo no momento ou já atingiu o limite de consultas deste mês. Para continuar acessando nossos serviços e iniciar novas consultas, por favor, considere contratar ou renovar seu plano. Clique abaixo para explorar opções adequadas para você e sua família. Estamos aqui para ajudar!',
      context: Get.context!,
      isDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          6.heightGap,
          SecondaryButtonWidget(
            onTap: () => Get.toNamed(campaignRoute),
            titleButtom: 'Contratar plano',
          ),
          6.heightGap,
          PrimaryButtonWidget(
            onTap: () => Get.back(),
            titleButtom: 'Voltar',
          ),
        ],
      ),
    );
  }

  static dialogYesOrNot({
    required String title,
    required Function() onPositive,
    required Function onNegative,
  }) {
    simpleDialog(
      title: title,
      context: Get.context!,
      isDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          6.heightGap,
          SecondaryButtonWidget(
            onTap: () => onPositive(),
            titleButtom: 'Sim',
          ),
          6.heightGap,
          PrimaryButtonWidget(
            onTap: () => onNegative(),
            titleButtom: 'Não',
          ),
        ],
      ),
    );
  }

  static showFlushBar({required String title, required String description}) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      title: title,
      message: description,
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      backgroundColor: AppColors.blackDarkColor,
      duration: const Duration(seconds: 3),
    ).show(Get.context!);
  }

  static contactWithUsDialog() {
    simpleDialog(
      title: 'Como deseja entrar em contato?',
      context: Get.context!,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.heightGap,
          ContactButton(
            title: 'Whataspp',
            icon: FontAwesomeIcons.whatsapp,
            onTap: () async => AppFunctions.urlLauncherWhatsapp(
              '5508001509008',
              'Olá, Doutor na Net!',
            ),
          ),
          const Divider(height: 0),
          ContactButton(
            title: 'E-mail',
            icon: FontAwesomeIcons.envelope,
            onTap: () async => AppFunctions.urlLauncherWithScheme(
              'suporte@doutornanet.com.br',
              scheme: 'mailto',
            ),
          ),
          const Divider(height: 0),
          ContactButton(
            title: 'Telefone',
            icon: FontAwesomeIcons.phone,
            onTap: () {
              AppFunctions.urlLauncherWithScheme(
                '5508006995003',
                scheme: 'tel',
              );
            },
          ),
        ],
      ),
    );
  }
}
