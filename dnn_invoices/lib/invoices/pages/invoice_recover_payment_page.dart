import 'dart:async';
import 'dart:developer';

import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/payment/utils/payment_utils.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InvoiceRecoverPaymentPage extends StatefulWidget {
  const InvoiceRecoverPaymentPage({super.key});

  @override
  State<InvoiceRecoverPaymentPage> createState() =>
      _InvoiceRecoverPaymentPageState();
}

class _InvoiceRecoverPaymentPageState extends State<InvoiceRecoverPaymentPage> {
  final InvoicePaymentDetailsModel order = Get.arguments;

  @override
  void initState() {
    if (order.info == null) {
      invoiceController.invoicesForPay.clear();
      invoiceController.addInvoiceToList(true, order);
      Get.toNamed(Routes.myContractsInvoicesResume);
      return;
    }
    GatewayBinding().dependencies();
    gatewayController.totalPrice = order.total;
    if (order.info?.pix != null) {
      Timer.periodic(
        const Duration(seconds: 8),
        (timer) async {
          if (Get.currentRoute != Routes.myInvoiceRecover) {
            return timer.cancel();
          }
          log('Buscando dados do pagamento');
          await invoiceController.getInvoicesPaymentDetail(order.paymentId!);
          if (invoiceController.paymentDetails != null) {
            log('A venda está: ${invoiceController.paymentDetails!.isPaid!}');
            if (invoiceController.paymentDetails!.isPaid!) {
              final paied = PaymentResponseModel(
                paymentId: order.paymentId,
                paymentConfirmed: true,
                paymentAwaiting: false,
              );
              invoiceController.getInvoicesPaymentDetail(paied.paymentId!);
              Get.offAllNamed(Routes.paymentStatus, arguments: paied);
              timer.cancel();
            }
          }
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Alterar pagamento',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          24.heightGap,
          Text(
            'Pagamento Solicitado',
            textAlign: TextAlign.center,
            style: Fonts.displayMedium(context),
          ),
          10.heightGap,
          if (order.info?.billet != null) ...[
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Pedido aguardando pagamento via boleto, revise o valor do mesmo pela aba ',
                    style: Fonts.bodyLarge(context),
                  ),
                  TextSpan(
                    text: '"Visualizar boleto" ',
                    style: Fonts.titleSmall(context)
                        .copyWith(color: AppColors.blueColor),
                  ),
                  TextSpan(
                    text:
                        'e, caso queria, poderá pagar esta fatura individualmente a partir do botão ',
                    style: Fonts.bodyLarge(context),
                  ),
                  TextSpan(
                    text: '"Alterar forma de pagamento"',
                    style:
                        Fonts.titleSmall(context).copyWith(color: Colors.green),
                  ),
                  TextSpan(
                    text: '.',
                    style: Fonts.bodyLarge(context),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            24.heightGap,
            SeeBilletAction(pdfUrl: order.info!.billet!.pdf!),
            Visibility(
              visible: !kIsWeb,
              child: BilletActions(
                title: 'Compartilhar boleto',
                icon: FontAwesomeIcons.arrowUpFromBracket,
                onTap: () async {
                  await PaymentUtils.sharedBilletGenerate(
                    order.info!.billet!.pdf!,
                    order.typePayment!.id!,
                  );
                },
              ).paddingOnly(top: 10),
            ),
            10.heightGap,
            CopyToClipboardWidget(
              textToClip: order.info!.billet!.barcode!,
              isBarcode: true,
            ),
            20.heightGap,
          ],
          if (order.info?.pix != null) ...[
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Pedido aguardando pagamento via PIX, revise o valor do mesmo na hora pagamento em seu aplicativo de banco e, caso queria, poderá pagar esta fatura individualmente a partir do botão ',
                    style: Fonts.bodyLarge(context),
                  ),
                  TextSpan(
                    text: '"Alterar forma de pagamento"',
                    style:
                        Fonts.titleSmall(context).copyWith(color: Colors.green),
                  ),
                  TextSpan(
                    text: '.',
                    style: Fonts.bodyLarge(context),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            10.heightGap,
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 250),
              child: QrImageView(
                data: order.info!.pix!.qrcode!,
                version: QrVersions.auto,
                eyeStyle: const QrEyeStyle(color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ).toCenter,
            20.heightGap,
            CopyToClipboardWidget(textToClip: order.info!.pix!.qrcode!),
          ],
          Visibility(
            visible: Responsive.isTabletOrDesktop(),
            child: GetBuilder<InvoicesController>(builder: (_) {
              return PrimaryButtonWidget(
                onTap: () async {
                  _.invoicesForPay.clear();
                  invoiceController.invoicesForPay.clear();
                  _.addInvoicesToList([order]);
                  await _.totalPrice();
                  invoiceController.addInvoicesToList([order]);
                  Get.toNamed(Routes.myContractsInvoicesResume);
                },
                titleButtom: 'Alterar forma de pagamento',
              );
            }).paddingOnly(top: 24),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !Responsive.isTabletOrDesktop(),
        child: GetBuilder<InvoicesController>(builder: (_) {
          return BottomConfirmButton(
            onTap: () async {
              _.invoicesForPay.clear();
              invoiceController.invoicesForPay.clear();
              _.addInvoicesToList([order]);
              await _.totalPrice();
              invoiceController.addInvoicesToList([order]);
              Get.toNamed(Routes.myContractsInvoicesResume);
            },
            title: 'Alterar forma de pagamento',
          );
        }),
      ),
    );
  }
}
