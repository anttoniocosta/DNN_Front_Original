import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ContractInvoicesResumePage extends StatelessWidget {
  const ContractInvoicesResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.invoicesForPay.isEmpty,
          needScrollView: true,
          title: 'Fatura',
          needPadding: false,
          maxWidth: Responsive.maxWidth(),
          bodyChild: GetBuilder<InvoicesController>(
            builder: (_) {
              if (_.invoicesForPay.isEmpty) {
                return const EmptyPageWidget(
                  title:
                      'Aparentemente você não selecionou as faturas para antecipar, volte e escolha.',
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  14.heightGap,
                  Text(
                    'Resumo do pagamento',
                    style: Fonts.headlineMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ).toCenter.paddingSymmetric(horizontal: 20),
                  21.heightGap,
                  Image.asset(
                    MediaRes.paymentSucessPng,
                    width: 300,
                  ).toCenter,
                  31.heightGap,
                  ..._.invoicesForPay
                      .map(
                        (e) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(height: 0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    e.title!,
                                    style: Fonts.bodyLarge(context),
                                  ),
                                ),
                                Text(
                                  e.total!.formatReal(),
                                  style: Fonts.bodyLarge(context),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 20, vertical: 10),
                            const Divider(height: 0),
                          ],
                        ),
                      )
                      .toList(),
                  24.heightGap,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Valor a pagar: ',
                          style: Fonts.titleLarge(context).copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: _.invoiceTotalPrice.formatReal(),
                          style:
                              Fonts.titleLarge(context).copyWith(fontSize: 24),
                        ),
                      ],
                    ),
                  ).toCenter.paddingSymmetric(horizontal: 20),
                  Visibility(
                    visible: Responsive.isTabletOrDesktop(),
                    child: GetBuilder<InvoicesController>(builder: (_) {
                      return PrimaryButtonWidget(
                        onTap: _.invoicesForPay.isEmpty
                            ? null
                            : () {
                                _.saveInvoicesIdsList();
                                Get.toNamed(Routes.renewalChoice);
                              },
                        titleButtom: 'Pagar',
                      );
                    }).paddingOnly(top: 24),
                  ),
                  100.heightGap,
                ],
              );
            },
          ),
          bottomSheet: Visibility(
            visible: !Responsive.isTabletOrDesktop(),
            child: GetBuilder<InvoicesController>(builder: (_) {
              return BottomConfirmButton(
                onTap: _.invoicesForPay.isEmpty
                    ? null
                    : () {
                        _.saveInvoicesIdsList();
                        Get.toNamed(Routes.renewalChoice);
                      },
                title: 'Pagar',
              );
            }),
          ),
        );
      },
    );
  }
}
