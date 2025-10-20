import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoice,
    this.seeInvoiceButtom = true,
  });

  final InvoiceResponseModel invoice;
  final bool? seeInvoiceButtom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _highlightColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlanCardHeader(
            isHighlight: false,
            isSubscription: true,
            campaignTitle: invoice.productName!,
            // price: 39.90,
            // isHighlight: invoice.flgHighlight!,
            // isSubscription: invoice.isSubscription!,
            // campaignTitle: invoice.title!,
            // price: invoice.price!,
          ),
          Text(
            '#${invoice.code.toString()}',
            style: Fonts.titleLarge(context).copyWith(
              // color:
              //     invoice.flgHighlight! ? AppColors.whiteColor : null,
              // color: AppColors.whiteColor,
              overflow: TextOverflow.ellipsis,
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
          19.heightGap,
          // Text(
          //   // invoice.descriptions!,
          //   'Essa era para ser a descrição mas atualmente mockado para mostrar algum conteúdo que preeencha bem e não sinta falta de algum texto.',
          //   style: Fonts.bodyLarge(context).copyWith(
          //     color: AppColors.whiteColor,
          //     // color:
          //     //     invoice.flgHighlight! ? AppColors.whiteColor : null,
          //     fontSize: 16,
          //   ),
          //   textAlign: TextAlign.start,
          // ),
          20.heightGap,
          GetBuilder<InvoicesController>(builder: (_) {
            return Row(
              children: [
                if (seeInvoiceButtom!)
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Get.isDarkMode ? null : AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusSmall),
                        ),
                      ),
                      onPressed: () async {
                        await _.getInvoicesOrder(invoice.orderId!);
                        _.setOrderId(invoice.orderId!);
                        _.checkedList.clear();
                        _.setCheckedList();
                        storage.removePaymentIds();
                        Get.toNamed(
                          Routes.myContractsInvoices,
                          arguments: {'order': invoice},
                        );
                      },
                      child:
                          Text('Ver Fatura', style: Fonts.titleSmall(context)),
                    ).paddingOnly(right: 10),
                  ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radiusSmall),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.myPlansDetails, arguments: invoice);
                    },
                    child: Text(
                      'Ver Detalhes',
                      style: Fonts.titleSmall(context)
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ],
            );
          }),
          20.heightGap,
          _statusPlan(context),
          // 10.heightGap,
          // BeneficitsSections(
          //   isHighlight: false,
          //   benefitsList: ['Benefícios 1', 'Benefícios 2', 'Benefícios 3'],
          //   // isHighlight: invoice.flgHighlight!,
          //   // benefitsList: invoice.benefitsList!,
          // ),
        ],
      ),
    ).paddingOnly(bottom: 20);
  }

  Widget _statusPlan(context) {
    return Container(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusLarge),
          color: _handleColorStatusPlan(),
        ),
        padding: const EdgeInsets.all(10),
        width: Responsive.maxWidth(),
        child: Text(_handleTextStatusPlan(),
            style: Fonts.titleSmall(context)
                .copyWith(color: AppColors.whiteColor)));
  }

  Color _handleColorStatusPlan() {
    if (invoice.cancelationAt != null) return AppColors.redColor;
    if (invoice.cancelationAt == null && invoice.blockedAt != null) {
      return AppColors.redColor;
    }
    if (invoice.cancelationAt == null && invoice.blockedAt == null) {
      return AppColors.successColor;
    }
    return AppColors.greyColor;
  }

  String _handleTextStatusPlan() {
    if (invoice.cancelationAt != null) return 'Plano Encerrado';
    if (invoice.cancelationAt == null && invoice.blockedAt != null) {
      return 'Plano Inativo';
    }
    if (invoice.cancelationAt == null && invoice.blockedAt == null) {
      return 'Plano Ativo';
    }
    return '';
  }

  Color _highlightColor() {
    // return invoice.flgHighlight!
    //     ? (Get.isDarkMode
    //         ? AppColors.lighterblackLightColor
    //         : AppColors.planCardColor)
    //     : (Get.isDarkMode
    //         ? AppColors.midBlackColor
    //         : AppColors.lighterGreyColor);
    // return AppColors.planCardColor;
    return AppColors.defaultBackgroundCardColor;
  }
}
