import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CreditCardResumePage extends StatelessWidget {
  const CreditCardResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      hasActions: false,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.resumeCreditCard)?.name,
      bodyChild: GetBuilder<CreditCardController>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              14.heightGap,
              Text(
                'Deseja finalizar sua compra?',
                style: Fonts.headlineMedium(context),
                textAlign: TextAlign.center,
              ).toCenter,
              Image.asset(
                MediaRes.paymentSucessPng,
                width: 300,
                fit: BoxFit.fitWidth,
              ).toCenter,
              const Divider(height: 0),
              16.heightGap,
              CardInfosForResume(
                issuer: cardController.card!.brand!.capitalize!,
                lastFourDigits: cardController.card!.lastFourDigits,
              ),
              16.heightGap,
              const Divider(height: 0),
              16.heightGap,
              Text('Endereço da fatura', style: Fonts.titleLarge(context)),
              if (creditCardController.isMyAddress.value) ...[
                AddressFormatted(
                  address: accountController.userAccount!.address!,
                  number: accountController.userAccount!.number!,
                  neighborhood: accountController.userAccount!.neighborhood!,
                  city: accountController.userAccount!.city!,
                  state: accountController.userAccount!.state!,
                  zipcode: accountController.userAccount!.zipcode!,
                ),
              ] else ...[
                AddressFormatted(
                  address: providersController.adress!.logradouro!,
                  number: providersController.number.text,
                  neighborhood: providersController.adress!.bairro!,
                  city: providersController.adress!.localidade!,
                  state: providersController.adress!.uf!,
                  zipcode: providersController.adress!.cep!,
                ),
              ],
              16.heightGap,
              const Divider(height: 0),
              16.heightGap,
              GetBuilder<GatewayController>(
                builder: (_) {
                  return Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Valor à pagar: ',
                          style:
                              Fonts.bodyLarge(context).copyWith(fontSize: 20),
                        ),
                        TextSpan(
                          text: gatewayController.totalPrice!.formatReal(),
                          style:
                              Fonts.titleLarge(context).copyWith(fontSize: 20),
                        )
                      ],
                    ),
                  ).toCenter;
                },
              ),
              Visibility(
                visible: Responsive.isTabletOrDesktop(),
                child: GetBuilder<CreditCardController>(builder: (_) {
                  return PrimaryButtonWidget(
                    isLoading: _.isLoadingFinish.value,
                    titleButtom: 'Finalizar compra',
                    onTap: () async {
                      creditCardController.setCreditCard();
                      await creditCardController.payCart();
                    },
                  );
                }).paddingOnly(top: 36),
              ),
              20.heightGap,
            ],
          );
        },
      ),
      bottomNavigationBar: Visibility(
        visible: !Responsive.isTabletOrDesktop(),
        child: GetBuilder<CreditCardController>(builder: (_) {
          return BottomConfirmButton(
            isLoading: _.isLoadingFinish.value,
            title: 'Finalizar compra',
            onTap: () async {
              creditCardController.setCreditCard();
              await creditCardController.payCart();
            },
          );
        }),
      ),
    );
  }
}
