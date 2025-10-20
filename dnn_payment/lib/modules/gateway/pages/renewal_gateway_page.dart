import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';

import 'package:flutter/material.dart';

class RenewalGatewayPage extends StatelessWidget {
  const RenewalGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatewayController>(
      builder: (_) {
        return MobileLayout(
          maxWidth: Responsive.maxWidth(),
          needCenter: _.isLoading.value || _.gatewayList.isEmpty,
          needScrollView: true,
          title:
              pagesController.currentPage(PagesEnum.renewalGatewayChoice)?.name,
          bodyChild: GetBuilder<GatewayController>(
            builder: (_) {
              if (_.isLoading.value) {
                return const PageLoadingWidget();
              }

              if (_.gatewayList.isEmpty) {
                return TryAgainPage(
                  message: 'Não foi possível recuperar as formas de pagamento',
                  onTryAgain: () {
                    gatewayController.getAllGateways();
                  },
                );
              }
              return Column(
                children: [
                  const PageHeader(pgEnum: PagesEnum.renewalGatewayChoice),
                  32.heightGap,
                  ...gatewayController.gatewayList.map(
                    (e) => GatewayButton(
                      onTap: () async {
                        await storage.setGatewayId(e.id!);
                        final price = await storage.getTotalPrice();
                        gatewayController.progressWithPayment(
                            PaymentEnum.RENEWAL, price);
                      },
                      name: e.name!,
                      id: e.id!,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
