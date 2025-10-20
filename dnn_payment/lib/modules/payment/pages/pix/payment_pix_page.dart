import 'package:clipboard/clipboard.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_shopping_cart/dnn_shopping_cart.dart';
import 'package:flutter/material.dart';

class PaymentPixPage extends StatelessWidget {
  const PaymentPixPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dataLimitePagamento = DateTime.now().add(const Duration(minutes: 30));
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<PixController>(
        builder: (_) {
          return MobileLayout(
            needCenter: (_.isLoading.value || _.paymentResponse == null) ||
                _.paymentError != null,
            needScrollView: true,
            hasLeading: true,
            appBarLeading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await shoppingCartController.deleteShoppingCart();
                Get.offAllNamed(Routes.basePage);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 22,
                color: AppColors.whiteColor,
              ),
            ),
            maxWidth: Responsive.maxWidth(),
            title: pagesController.currentPage(PagesEnum.resumePix)!.name!,
            bodyChild: GetBuilder<PixController>(
              builder: (_) {
                if (_.isLoading.value) {
                  return const PageLoadingWidget();
                }

                if (_.paymentError != null) {
                  return TryAgainPage(
                    message: _.paymentError!.message!,
                    onTryAgain: () async {
                      await shoppingCartController.deleteShoppingCart();
                      Get.offAllNamed(Routes.basePage);
                    },
                    buttonTitle: 'Voltar ao início',
                  );
                }

                if (_.paymentResponse == null) {
                  return TryAgainPage(
                    message: 'Não foi possível obter os dados',
                    onTryAgain: () async => await pixController.payCart(),
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.heightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          gatewayController.totalPrice!.formatReal(),
                          style: const TextStyle(
                              color: AppColors.blueColor, fontSize: 20),
                        )
                      ],
                    ),
                    10.heightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Pague até:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '${dataLimitePagamento.day}/${dataLimitePagamento.month.toString().padLeft(2, '0')}, ${dataLimitePagamento.hour}:${(dataLimitePagamento.minute.toString().padLeft(2, '0'))}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    20.heightGap,
                    const Text(
                      'Escaneia o QR code ou copie o código PIX abaixo e cole em seu app de pagamento para finalizar a compra. ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0xff66707a)),
                    ),
                    20.heightGap,
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 300, maxHeight: 250),
                      child: QrImageView(
                        data: _.paymentResponse!.pix!.qrcode!,
                        version: QrVersions.auto,
                        eyeStyle: const QrEyeStyle(color: Colors.black),
                        backgroundColor: Colors.white,
                      ),
                    ).toCenter,
                    20.heightGap,
                    const Text(
                      'Código',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff171725),
                          fontWeight: FontWeight.w400),
                    ),
                    10.heightGap,
                    Text(
                      _.paymentResponse!.pix!.qrcode!,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontSize: 16),
                    ),
                    10.heightGap,
                    const Divider(height: 0.6, color: Color(0xff979797)),
                    10.heightGap,
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: PrimaryButtonWidget(
                            height: 40,
                            onTap: () {
                              FlutterClipboard.copy(
                                  _.paymentResponse!.pix!.qrcode!);
                            },
                            titleButtom: "Copiar Código",
                            fontSize: 14.0,
                          ),
                        ),
                        3.widthGap,
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: PrimaryButtonWidget(
                            height: 40,
                            onTap: () {
                              navigationController
                                  .setIndex(NavigationTabs.home);
                              Get.offAllNamed(Routes.basePage);
                            },
                            titleButtom: "Voltar ao início",
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    60.heightGap,
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
