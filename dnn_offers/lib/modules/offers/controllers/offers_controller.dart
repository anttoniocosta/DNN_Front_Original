import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_offers/dnn_offers.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersController extends GetxController {
  final IOffersRepository _repository;

  OffersController(this._repository);

  RxBool isLoading = false.obs;

  OffersResponseModel? offers;
  String redeParceiraLink = '';

  setLoading(RxBool loading, bool status) {
    loading.value = status;
    update();
  }

  @override
  void onInit() async {
    if (offers == null) await getOffers();
    navigationController.getUserLogged();
    super.onInit();
  }

  Future<void> getOffers() async {
    setLoading(isLoading, true);
    try {
      final result = await _repository.getOffers();

      if (result.data != null) {
        offers = result.data;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(isLoading, false);
  }

  Future<void> getRedeOferta({String path = ''}) async {
    if (!navigationController.isLogged) {
      Loading.hide();
      CustomDialogs.simpleDialog(
        title: 'Minhas ofertas',
        context: Get.context!,
        content: Column(
          children: [
            Text(
              'Para acessar as suas ofertas é necessário estar autenticado!\nEntre ou cadastre-se agora mesmo.',
              style: Fonts.bodyLarge(Get.context!),
            ),
            10.heightGap,
            SecondaryButtonWidget(
              onTap: () {
                Get.back();
                navigationController.navigatePageView(
                  NavigationTabs.login,
                );
              },
              titleButtom: 'Entrar ou criar conta',
            ),
            10.heightGap,
            PrimaryButtonWidget(
              onTap: () => Get.back(),
              titleButtom: 'Voltar',
            )
          ],
        ),
      );
      return;
    }
    Loading.show(title: 'Aguarde...');
    try {
      final result = await _repository.getRedeParceira();

      if (result.data != null) {
        Loading.hide();
        redeParceiraLink = result.data!;
        AppFunctions.urlLauncherSimples(
          redeParceriaParce(redeParceiraLink, path),
        );
        update();
      } else if (result.error != null) {
        Loading.hide();
        SnackbarCustom.snackbarError(result.error!.message!);
      } else {
        Loading.hide();
      }
    } catch (e) {
      Loading.hide();
      debugPrint(e.toString());
    }
  }

  String redeParceriaParce(String url, String path) {
    String baseUrl = 'https://doutornanet.clubeparcerias.com.br/';
    String oauthToken = url;
    String urlPath = path;

    log('$baseUrl$urlPath$oauthToken');

    return '$baseUrl$urlPath$oauthToken';
  }
}
