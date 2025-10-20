import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ContractInvoicesPage extends StatefulWidget {
  const ContractInvoicesPage({super.key});

  @override
  State<ContractInvoicesPage> createState() => _ContractInvoicesPageState();
}

class _ContractInvoicesPageState extends State<ContractInvoicesPage> {
  final InvoiceResponseModel order = Get.arguments['order'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(
      builder: (_) {
        return MobileLayout(
          needCenter:
              _.getInvoicesOrdersLoading.value || _.invoicesByOrder.isEmpty,
          needScrollView: true,
          title: 'Fatura',
          needPadding: false,
          maxWidth: Responsive.maxWidth(),
          bodyChild: GetBuilder<InvoicesController>(
            builder: (_) {
              if (_.getInvoicesOrdersLoading.value) {
                return const PageLoadingWidget();
              }

              if (_.invoicesByOrder.isEmpty) {
                return TryAgainPage(
                  message: 'Houve algum erro ao obter os dados da sua fatura.',
                  onTryAgain: () => _.getInvoicesOrder(order.orderId!),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  14.heightGap,
                  Text(
                    'Você está em dia!',
                    style: Fonts.headlineMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ).paddingSymmetric(horizontal: 20),
                  24.heightGap,
                  Text(
                    'Informações de pagamento',
                    style: Fonts.headlineMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ).paddingSymmetric(horizontal: 20),
                  16.heightGap,
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _.invoicesByOrder.length,
                      itemBuilder: (__, index) {
                        final orderr = _.invoicesByOrder[index];
                        return GetBuilder<InvoicesController>(builder: (_) {
                          return InvoiceMonthlyFeeValues(
                            order: orderr,
                            isOwner: order.holder!.personId ==
                                accountController.userAccount!.id!,
                            onCheck: (val) {
                              if (_.invoicesByOrder.firstWhereOrNull((x) =>
                                      !x.isPaid! &&
                                      (x.info!.billet != null ||
                                          x.info!.pix != null)) !=
                                  null) {
                                CustomDialogs.simpleDialog(
                                  title: 'Atenção!',
                                  isDismissible: false,
                                  context: context,
                                  content: Column(
                                    children: [
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: 'Você possui ',
                                          style: Fonts.bodyLarge(context)
                                              .copyWith(fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: 'fatura(s) pendente(s)',
                                          style: Fonts.titleSmall(context)
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppColors.redColor),
                                        ),
                                        TextSpan(
                                          text:
                                              ', para adiantar as próximas você pode clicar na fatura pendente e ir em',
                                          style: Fonts.bodyLarge(context)
                                              .copyWith(fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: ' "Alterar dados de pagamento"',
                                          style: Fonts.titleSmall(context)
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: Colors.green),
                                        ),
                                        TextSpan(
                                          text: '.',
                                          style: Fonts.bodyLarge(context)
                                              .copyWith(fontSize: 16),
                                        ),
                                      ])),
                                      20.heightGap,
                                      PrimaryButtonWidget(
                                        titleButtom: 'Voltar',
                                        onTap: () => Get.back(),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              _.changeCheckbox(index, val!);
                            },
                            isChecked: _.checkedList[index]['checked'],
                          );
                        });
                      }),
                  Visibility(
                    visible: Responsive.isTabletOrDesktop() &&
                        (!(order.holder!.personId !=
                                accountController.userAccount!.id!) ||
                            !(_.getInvoicesOrdersLoading.value ||
                                _.invoicesByOrder.isEmpty) ||
                            !(_.invoicesByOrder.length == 1)),
                    child: GetBuilder<InvoicesController>(builder: (_) {
                      return PrimaryButtonWidget(
                        onTap: () async {
                          _.invoicesForPay.clear();
                          await _.goToInvoicesForPayDetails();
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
          bottomSheet:
              !(order.holder!.personId != accountController.userAccount!.id!)
                  ? Visibility(
                      visible: (!Responsive.isTabletOrDesktop() &&
                          (!(_.getInvoicesOrdersLoading.value ||
                                  _.invoicesByOrder.isEmpty) ||
                              !(_.invoicesByOrder.length == 1))),
                      child: GetBuilder<InvoicesController>(builder: (_) {
                        return BottomConfirmButton(
                          onTap: () async {
                            _.invoicesForPay.clear();
                            await _.goToInvoicesForPayDetails();
                          },
                          title: 'Pagar',
                        );
                      }),
                    )
                  : null,
        );
      },
    );
  }
}
