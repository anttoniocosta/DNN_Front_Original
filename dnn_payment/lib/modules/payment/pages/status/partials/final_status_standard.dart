import 'dart:async';
import 'dart:developer';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/payment/utils/payment_utils.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class PaymentFinalStatusStandard extends StatelessWidget {
  const PaymentFinalStatusStandard({
    super.key,
    required this.payment,
  });

  final PaymentResponseModel payment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (payment.paymentConfirmed!)
            PaymentFinalCompleted(payment: payment)
          else if (payment.paymentAwaiting!)
            PaymentFinalAwaiting(payment: payment)
          else
            const PaymentFinalDeclined(),
        ],
      ),
    );
  }
}

class PaymentFinalCompleted extends StatefulWidget {
  const PaymentFinalCompleted({super.key, required this.payment});

  final PaymentResponseModel payment;

  @override
  State<PaymentFinalCompleted> createState() => _PaymentFinalCompletedState();
}

class _PaymentFinalCompletedState extends State<PaymentFinalCompleted> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentDetailsController>(builder: (_) {
      if (paymentDetailsController.getPaymentDetails.value) {
        return const PageLoadingWidget();
      }

      if (paymentDetailsController.paymentDetails == null) {
        return TryAgainPage(
          message: 'Não conseguimos recuperar os dados da sua compra',
          onTryAgain: () {
            paymentDetailsController
                .getInvoicesPaymentDetail(widget.payment.paymentId!);
          },
        );
      }

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
                    'Pagamento Recebido',
                    style: Fonts.headlineMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ),
                10.heightGap,
                Row(
                  children: [
                    Expanded(
                      child: TextForDescriptions(
                        text: paymentDetailsController
                            .paymentDetails!.transactionCode
                            .toString(),
                        title: 'Código transacional',
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextForDescriptions(
                          text: paymentDetailsController
                              .paymentDetails!.createAt!
                              .formatDate(),
                          title: 'Data',
                          align: CrossAxisAlignment.end,
                        ),
                      ),
                    ),
                  ],
                ),
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
                20.heightGap,
                Center(
                  child: Text(
                    'Valor pago',
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
          Visibility(
            visible: !(appContext.type == AppTypeEnum.COMPANY) &&
                (dnnController.dnnConfigs!.modeStreaming! == false),
            child: SecondaryButtonWidget(
              titleButtom: 'Prosseguir para a consulta',
              onTap: () async {
                await PaymentUtils().clearPaymentKeys();
                await startAppointmentController.getDependents(
                    forceUpdate: true);
              },
            ).paddingOnly(top: 20),
          ),
          10.heightGap,
          PrimaryButtonWidget(
            titleButtom: 'Voltar ao início',
            onTap: () async {
              await PaymentUtils().clearPaymentKeys();
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
            },
          ),
        ],
      );
    });
  }
}

class PaymentFinalDeclined extends StatelessWidget {
  const PaymentFinalDeclined({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          MediaRes.failPaymentImg,
          fit: BoxFit.fitWidth,
          width: 400,
        ),
        20.heightGap,
        Text(
          'Pagamento Não Confirmado',
          style: Fonts.displayLarge(context),
          textAlign: TextAlign.center,
        ),
        10.heightGap,
        Text(
          'Desculpe, seu pagamento não pode ser processado agora. Assim que confirmado, seu plano estará disponível.',
          style: Fonts.bodyLarge(context),
          textAlign: TextAlign.center,
        ),
        10.heightGap,
        PrimaryButtonWidget(
          titleButtom: 'Voltar ao início',
          onTap: () async {
            await PaymentUtils().clearPaymentKeys();
            navigationController.setIndex(NavigationTabs.home);
            Get.offAllNamed(Routes.basePage);
          },
        ),
      ],
    );
  }
}

class PaymentFinalAwaiting extends StatefulWidget {
  const PaymentFinalAwaiting({super.key, required this.payment});
  final PaymentResponseModel payment;

  @override
  State<PaymentFinalAwaiting> createState() => _PaymentFinalAwaitingState();
}

class _PaymentFinalAwaitingState extends State<PaymentFinalAwaiting> {
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  initTimer() async {
    Timer.periodic(
      const Duration(seconds: 8),
      (timer) async {
        if (Get.currentRoute != Routes.paymentStatus) return timer.cancel();
        log('******* Buscando dados do pagamento ******* ');
        await paymentDetailsController
            .getInvoicesPaymentDetail(widget.payment.paymentId!);
        if (paymentDetailsController.paymentDetails != null) {
          if (paymentDetailsController.paymentDetails!.isPaid!) {
            final paied = widget.payment;
            paied.paymentConfirmed = true;
            Get.offAllNamed(Routes.paymentStatus, arguments: paied);
            timer.cancel();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          MediaRes.failPaymentImg,
          fit: BoxFit.fitWidth,
          width: 250,
        ),
        40.heightGap,
        Text(
          'Pagamento em Análise',
          style: Fonts.displayLarge(context),
          textAlign: TextAlign.center,
        ),
        10.heightGap,
        Text(
          'Estamos processando seu pagamento. Por favor, aguarde um momento enquanto confirmamos os detalhes.',
          style: Fonts.bodyLarge(context),
          textAlign: TextAlign.center,
        ),
        10.heightGap,
        const CircularProgressIndicator.adaptive(),
        20.heightGap,
      ],
    );
  }
}
