import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CreditCardInfoPartial extends StatelessWidget {
  const CreditCardInfoPartial({
    super.key,
    required this.formKey,
    required this.finisherButtom,
  });

  final GlobalKey<FormState> formKey;
  final Widget finisherButtom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreditCardController>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.heightGap,
            Text(
              'Pagamento Solicitado',
              style: Fonts.headlineMedium(context),
            ).toCenter,
            12.heightGap,
            const CreditCardCustom(),
            20.heightGap,
            Form(
              key: formKey,
              child: Column(
                children: [
                  GetBuilder<CreditCardController>(builder: (_) {
                    return CustomCardForm(
                      obscureCvv: false,
                      obscureNumber: false,
                      cardNumber: creditCardController.cardNumber,
                      cvvCode: creditCardController.cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: creditCardController.cardHolderName,
                      expiryDate: creditCardController.expiryDate,
                      onCreditCardModelChange:
                          creditCardController.onCreditCardModelChange,
                    );
                  }),
                  CPFInput(controller: creditCardController.cpfEditC),
                  DateInput(
                    controller: creditCardController.bithDayEditC,
                    label: 'Data de nascimento do titular',
                  )
                ],
              ),
            ),
            12.heightGap,
            GetBuilder<CardController>(builder: (_) {
              return Visibility(
                visible: true,
                //visible: AppTrigger.isAppClient,
                child: Obx(
                  () => Row(children: [
                    Expanded(
                      child: Text(
                        'Deseja salvar os dados do cartão para compra futuras?',
                        style: Fonts.titleSmall(context),
                      ).paddingOnly(left: 5),
                    ),
                    20.heightGap,
                    Switch.adaptive(
                      activeColor: AppColors.whiteColor,
                      inactiveThumbColor:
                          AppColors.blackDarkColor.withOpacity(0.6),
                      inactiveTrackColor: AppColors.greyColor,
                      activeTrackColor: AppColors.blueColor,
                      trackOutlineColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      value: cardController.canRegisterCard.value,
                      onChanged: (val) {
                        cardController.setCanRegisterCard(val);
                      },
                    ),
                  ]),
                ),
              );
            }),
            22.heightGap,
            finisherButtom,
            20.heightGap,
          ],
        );
      },
    );
  }
}
