import 'dart:io';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCallPage extends StatefulWidget {
  const ServiceCallPage({super.key});

  @override
  State<ServiceCallPage> createState() => _ServiceCallPageState();
}

class _ServiceCallPageState extends State<ServiceCallPage> {
  String urlRapidoc = Get.arguments;
  @override
  void initState() {
    super.initState();
    _connectRapidocForIos();
  }

  Future<void> _connectRapidocForIos() async {
    if (kIsWeb) {
      AppFunctions.urlLauncherSimples(urlRapidoc);
    }
    if (Platform.isIOS) {
      if (!await launchUrl(
        Uri.parse(urlRapidoc),
        mode: LaunchMode.inAppWebView,
        webViewConfiguration:
            const WebViewConfiguration(enableDomStorage: false),
      )) {
        SnackbarCustom.snackbarError('Não foi possível completar esta ação.');
      }
    }
  }

  bool _isIos() {
    if (!kIsWeb) return Platform.isIOS;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        CustomDialogs.confirmDialog(
          title: 'Deseja realmente finalizar sua consulta?',
          backAcion: () => Get.back(),
          confirmAcion: () {
            navigationController.setIndex(NavigationTabs.home);
            Get.offAllNamed(Routes.basePage);
          },
          context: context,
          backVisible: true,
        );
      },
      child: MobileLayout(
        needCenter: _isIos() || kIsWeb,
        needScrollView: _isIos() || kIsWeb,
        needPadding: _isIos() || kIsWeb,
        needAppBar: (_isIos() || kIsWeb) ? false : true,
        appBar: AppBar(
          backgroundColor:
              Get.isDarkMode ? AppColors.midBlackColor : AppColors.blueColor,
          centerTitle: false,
          toolbarHeight: kToolbarHeight - (kToolbarHeight * .1),
          leading: IconButton(
            onPressed: () {
              CustomDialogs.confirmDialog(
                title: 'Deseja realmente finalizar sua consulta?',
                backAcion: () => Get.back(),
                confirmAcion: () {
                  navigationController.setIndex(NavigationTabs.home);
                  Get.offAllNamed(Routes.basePage);
                },
                context: context,
                backVisible: true,
              );
            },
            icon: const FaIcon(FontAwesomeIcons.xmark),
          ),
          title: Text(
            'Atendimento',
            style: Fonts.headlineMedium(context)
                .copyWith(color: AppColors.whiteColor),
          ),
        ),
        drawer: null,
        maxWidth: Responsive.maxWidth(),
        bodyChild: GetBuilder<ProvidersController>(
          builder: (_) {
            if (kIsWeb) {
              return Column(
                children: [
                  SvgPicture.asset(
                    MediaRes.unboardingImgThree,
                    fit: BoxFit.fitWidth,
                  ),
                  20.heightGap,
                  Text(
                    'Te direcionamos para o seu atendimento, siga os procedimentos e logo será atendido!',
                    style: Fonts.headlineMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  20.heightGap,
                  PrimaryButtonWidget(
                    onTap: () {
                      navigationController.setIndex(NavigationTabs.home);
                      Get.offAllNamed(Routes.basePage);
                    },
                    titleButtom: 'Voltar ao início',
                  )
                ],
              );
            }

            if (Platform.isIOS) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    MediaRes.waitingCallConectionImg,
                    fit: BoxFit.fitWidth,
                  ),
                  20.heightGap,
                  Text(
                    'Te direcionamos para o seu atendimento, siga os procedimentos e logo será atendido!',
                    style: Fonts.headlineMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return WebViewCustom(url: urlRapidoc);
          },
        ),
        bottomNavigationBar: Visibility(
          visible: _isIos(),
          child: BottomConfirmButton(
            title: 'Voltar ao início',
            onTap: () {
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
            },
          ),
        ),
      ),
    );
  }
}
