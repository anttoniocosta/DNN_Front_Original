import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PaymentFinalStatusPage extends StatefulWidget {
  const PaymentFinalStatusPage({super.key});

  @override
  State<PaymentFinalStatusPage> createState() => _PaymentFinalStatusPageState();
}

class _PaymentFinalStatusPageState extends State<PaymentFinalStatusPage> {
  late PaymentResponseModel payment;

  @override
  void initState() {
    payment = Get.arguments;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (vak) async {
        CustomDialogs.confirmDialog(
            title: 'Deseja voltar ao início?',
            backAcion: () => Get.back(),
            confirmAcion: () {
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
            },
            context: context,
            backVisible: true);
      },
      child: GetBuilder<PaymentDetailsController>(
        builder: (_) {
          return MobileLayout(
            needCenter: true,
            needScrollView: true,
            maxWidth: Responsive.maxWidth(),
            needAppBar: false,
            bodyChild: switch (appContext.type) {
              AppTypeEnum.CLIENT =>
                PaymentFinalStatusStandard(payment: payment),
              AppTypeEnum.COMPANY =>
                paymentDetailsController.paymentCicle == PaymentEnum.RENEWAL
                    ? PaymentFinalStatusStandard(payment: payment)
                    : PaymentFinalStatusCompany(payment: payment),
              int() => PaymentFinalStatusStandard(payment: payment),
            },
          );
        },
      ),
    );
  }
}
