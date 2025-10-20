import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/modules/payment/export.dart';
import 'package:dnn_payment/modules/payment/utils/payment_utils.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class PaymentDeinedPage extends StatelessWidget {
  PaymentDeinedPage({super.key});

  final String? errorMessage = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MobileLayout(
        needCenter: true,
        needScrollView: true,
        needAppBar: false,
        maxWidth: Responsive.maxWidth(),
        bodyChild: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              MediaRes.errorPaymentImg,
              fit: BoxFit.fitWidth,
            ),
            10.heightGap,
            Text(
              'Pagamento Inválido',
              style: Fonts.displayLarge(context),
              textAlign: TextAlign.center,
            ),
            10.heightGap,
            Text(
              errorMessage ??
                  'Tente novamente com outra forma de pagamento ou volte ao início.',
              style: Fonts.bodyLarge(context),
              textAlign: TextAlign.center,
            ),
            20.heightGap,
            SecondaryButtonWidget(
              titleButtom: 'Tentar novamente',
              onTap: () async {
                final paymentCicle = await storage.getPaymentCicle();
                if (paymentCicle == PaymentEnum.PURCHASE) {
                  Get.offNamedUntil(
                    Routes.paymentChoice,
                    ModalRoute.withName(Routes.useTerms),
                  );
                }
                if (paymentCicle == PaymentEnum.RENEWAL) {
                  Get.offNamedUntil(
                    Routes.renewalChoice,
                    ModalRoute.withName(Routes.myContractsInvoicesResume),
                  );
                }

                if (paymentCicle == PaymentEnum.SCHEDULE) {
                  storage.removeIsAnotherPatient();
                  storage.removeAccountForSchedule();
                  Get.offNamedUntil(
                    Routes.scheduleConfirm,
                    ModalRoute.withName(Routes.scheduleSpecialtyAble),
                  );
                }
              },
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
        ),
      ),
    );
  }
}
