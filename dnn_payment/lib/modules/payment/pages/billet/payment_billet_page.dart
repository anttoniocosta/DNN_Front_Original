import 'package:clipboard/clipboard.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_shopping_cart/dnn_shopping_cart.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class PaymentBilletPage extends StatelessWidget {
  const PaymentBilletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BilletController>(builder: (_) {
      return WillPopScope(
        onWillPop: () async => false,
        child: MobileLayout(
          needCenter: (_.isLoading.value || _.paymentResponse == null) ||
              _.paymentError != null,
          needScrollView: false,
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
          needPadding: false,
          title: pagesController.currentPage(PagesEnum.resumeBillet)?.name,
          bodyChild: GetBuilder<ScheduleController>(
            builder: (sch) {
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
                  onTryAgain: () async => await _.payCart(),
                );
              }
              return GetBuilder<InvoicesController>(builder: (inv) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      20.heightGap,
                      Text(
                        'Confirme as informações',
                        style: Fonts.headlineMedium(context).copyWith(
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.start,
                      ).paddingSymmetric(horizontal: 20),
                      20.heightGap,
                      const Divider(
                        thickness: 1,
                        color: AppColors.oldGreyColor,
                      ),
                      10.heightGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Fonts.bodyMedium(context).copyWith(
                              fontSize: 18.0,
                              fontFamily: Fonts.poppins,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            sch.scheduleHourSelected == null
                                ? inv.invoicesForPay.isEmpty
                                    ? (shoppingCartController
                                            .shoppingCartPersons!.items!
                                            .map((e) => e.total)
                                            .toList()
                                            .reduce((a, b) => a! + b!)!)
                                        .formatReal()
                                    : inv.invoiceTotalPrice.formatReal()
                                : sch.scheduleHourSelected!.price!.formatReal(),
                            style: Fonts.bodyMedium(context).copyWith(
                              fontSize: 18.0,
                              fontFamily: Fonts.poppins,
                              color: AppColors.blueColor,
                            ),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ).paddingSymmetric(horizontal: 20),
                      10.heightGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pague até:',
                            style: Fonts.bodyMedium(context).copyWith(
                              fontSize: 14.0,
                              fontFamily: Fonts.poppins,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            DateFormat('dd/MM, HH:mm').format(
                                DateTime.now().add(const Duration(days: 1))),
                            style: Fonts.bodyMedium(context).copyWith(
                              fontSize: 14.0,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          )
                        ],
                      ).paddingSymmetric(horizontal: 20),
                      25.heightGap,
                      Text(
                        'Baixe o documento PDF ou copie o código abaixo e cole em seu app de pagamento para finalizar a compra.',
                        style: Fonts.bodyMedium(context).copyWith(
                          fontSize: 12.0,
                          fontFamily: Fonts.poppins,
                        ),
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 28),
                      40.heightGap,
                      InkWell(
                        onTap: () {
                          AppFunctions.urlLauncherSimples(
                              _.paymentResponse!.pdf!);
                        },
                        child: Image.asset(
                          MediaRes.pdfIcon,
                          width: 70,
                        ).toCenter,
                      ),
                      40.heightGap,
                      Text(
                        'Código',
                        style: Fonts.bodyMedium(context).copyWith(
                          fontSize: 16.0,
                          fontFamily: Fonts.poppins,
                        ),
                        textAlign: TextAlign.start,
                      ).paddingSymmetric(horizontal: 20),
                      Text(
                        _.paymentResponse!.barcode!,
                        style: Fonts.bodyMedium(context).copyWith(
                          fontSize: 14.0,
                          fontFamily: Fonts.poppins,
                        ),
                        textAlign: TextAlign.start,
                      ).paddingSymmetric(horizontal: 20),
                      const Divider(
                        thickness: 1,
                        color: AppColors.oldGreyColor,
                      ).paddingSymmetric(horizontal: 20),
                      10.heightGap,
                      PrimaryButtonWidget(
                        height: 40,
                        onTap: () {
                          debugPrint(_.paymentResponse!.barcode!);
                          FlutterClipboard.copy(_.paymentResponse!.barcode!
                              .replaceAll(".", "")
                              .replaceAll(" ", ""));
                        },
                        titleButtom: "Copiar Código",
                        fontSize: 14.0,
                      ).marginOnly(
                          right: MediaQuery.of(context).size.width / 2.5,
                          left: 20),
                      40.heightGap,
                      Visibility(
                        visible: !Responsive.isTabletOrDesktop() &&
                            !((_.isLoading.value ||
                                    _.paymentResponse == null) ||
                                _.paymentError != null),
                        child: PrimaryButtonWidget(
                          titleButtom: 'Finalizar',
                          onTap: () {
                            Get.offAllNamed(Routes.basePage);
                            navigationController
                                .navigatePageView(NavigationTabs.home);
                          },
                        ),
                      ).paddingSymmetric(horizontal: 20),
                      40.heightGap,
                    ],
                  ),
                );
              });
            },
          ),
        ),
      );
    });
  }
}

class SeeBilletAction extends StatelessWidget {
  const SeeBilletAction({super.key, required this.pdfUrl});

  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return BilletActions(
      title: 'Visualizar boleto',
      icon: FontAwesomeIcons.barcode,
      onTap: () async {
        AppFunctions.urlLauncherSimples(pdfUrl);
      },
    );
  }
}
