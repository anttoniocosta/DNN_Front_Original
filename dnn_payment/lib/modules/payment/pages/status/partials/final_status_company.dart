import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/payment/utils/payment_utils.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PaymentFinalStatusCompany extends StatelessWidget {
  const PaymentFinalStatusCompany({super.key, required this.payment});

  final PaymentResponseModel payment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          MediaRes.paymentSucessPng,
          fit: BoxFit.fitWidth,
          width: 250,
        ),
        20.heightGap,
        CardForDetails(
          children: InsideContextDetail(
            children: [
              Center(
                child: Text(
                  'Pedido recebido',
                  style: Fonts.headlineMedium(context),
                  textAlign: TextAlign.center,
                ),
              ),
              10.heightGap,
              TextForDescriptions(
                text: DateTime.now().formatDate(),
                title: 'Data do pedido',
                align: CrossAxisAlignment.center,
              ).toCenter,
              10.heightGap,
              SizedBox(
                width: double.infinity,
                child: DottedLine(
                  height: 1.0,
                  color: Get.isDarkMode
                      ? AppColors.lighterGreyColor
                      : AppColors.blackDarkColor.withOpacity(0.3),
                  dotSize: 12.0,
                  spacing: 6.0,
                ),
              ),
              16.heightGap,
              Center(
                child: Text(
                  'Valor a faturar',
                  style: Fonts.displaySmall(context),
                ),
              ),
              10.heightGap,
              Center(
                child: Text(
                  gatewayController.totalPrice!.formatReal(),
                  style: Fonts.displayLarge(context),
                ),
              ),
            ],
          ),
        ),
        30.heightGap,
        PrimaryButtonWidget(
          titleButtom: 'Voltar ao início',
          onTap: () async {
            await PaymentUtils().clearPaymentKeys();
            navigationController.setIndex(NavigationTabs.home);
            Get.offAllNamed(Routes.basePage);
          },
        ),
      ],
    ).paddingSymmetric(horizontal: 12);
  }
}
