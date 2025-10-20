import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class GatewayValueForPay extends StatelessWidget {
  const GatewayValueForPay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatewayController>(
      builder: (_) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Valor à pagar: ',
                style: Fonts.bodyLarge(context).copyWith(fontSize: 20),
              ),
              TextSpan(
                text: gatewayController.totalPrice!.formatReal(),
                style: Fonts.titleLarge(context).copyWith(fontSize: 20),
              )
            ],
          ),
        ).toCenter;
      },
    );
  }
}
