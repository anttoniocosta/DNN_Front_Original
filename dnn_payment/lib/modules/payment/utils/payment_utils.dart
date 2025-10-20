import 'dart:developer';
import 'dart:io';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PaymentUtils {
  static selectCardBrand() {
    CustomDialogs.simpleDialog(
      title:
          'Não conseguimos identificar a bandeira do cartão, poderia nos informar?',
      context: Get.context!,
      isDismissible: true,
      content: GetBuilder<CreditCardController>(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SelectBrandCreditCard(brand: 'Mastercard'),
                  SelectBrandCreditCard(brand: 'Visa'),
                  SelectBrandCreditCard(brand: 'Amex'),
                  SelectBrandCreditCard(brand: 'Hipercard'),
                  SelectBrandCreditCard(brand: 'Elo'),
                ],
              ),
              12.heightGap,
              PrimaryButtonWidget(
                onTap: () => Get.back(),
                titleButtom: 'Nenhuma das opções',
              ),
            ],
          ),
        );
      }),
    );
  }

  static Future sharedBilletGenerate(String url, int gatewayId) async {
    try {
      final directory = Platform.isAndroid
          ? (await getExternalStorageDirectory())!.path //FOR ANDROID
          : (await getApplicationSupportDirectory()).path; //FOR iOS

      final fileNameParts = url.split("/");

      String? filaName;
      if (gatewayId == GatewayEnum.BILLET_GNT) {
        filaName = fileNameParts[fileNameParts.length - 1].split('?').first;
      }

      if (gatewayId == GatewayEnum.BILLET_MP) {
        filaName = '${fileNameParts[fileNameParts.length - 2]}.pdf';
      }
      var response = await Dio(
        BaseOptions(
          connectTimeout: const Duration(minutes: 3),
          receiveTimeout: const Duration(minutes: 3),
        ),
      ).download(url, '$directory/$filaName');
      if (response.statusCode == 200) {
        await Share.shareXFiles(
          [XFile('$directory/$filaName')],
          text: 'Compartilhando boleto!',
        );
      } else {
        SnackbarCustom.snackbarError(
          "Não foi possível compartilhar o boleto. Tenta novamente!",
        );
      }
    } catch (e) {
      log(e.toString());
      SnackbarCustom.snackbarException(e);
    }
  }

  Future<void> clearPaymentKeys() async {
    await storage.removeGatewayId();
    await storage.removePaymentCicle();
    await storage.removeUseTerms();
    await storage.removeCartId();
    await storage.removeOrderId();

    await storage.removePaymentIds();
  }
}

class SelectBrandCreditCard extends StatelessWidget {
  const SelectBrandCreditCard({super.key, required this.brand});

  final String brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 6,
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        creditCardController.brand = brand.toLowerCase();
        cardController.handleCreditCardInfoAction();
        Get.back();
      },
      child: Container(
        width: 120,
        height: 100,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Get.isDarkMode
                ? AppColors.whiteColor
                : AppColors.lighterGreyColor,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              brand.creditCardIssuer(),
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            Text(
              brand,
              overflow: TextOverflow.ellipsis,
              style: Fonts.titleSmall(context),
            ),
          ],
        ).toCenter,
      ),
    );
  }
}
