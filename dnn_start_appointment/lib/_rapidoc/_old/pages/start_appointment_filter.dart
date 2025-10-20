import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartAppointmentFilter extends StatelessWidget {
  const StartAppointmentFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Iniciar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.heightGap,
          PrimaryButtonWidget(
            titleButtom: "Iniciar consulta na emergência agora",
            fontSize: 24,
            height: 100,
            onTap: () {},
          ),
          Text('Ou', style: Fonts.titleMedium(context))
              .paddingSymmetric(vertical: 10)
              .toCenter,
          SecondaryButtonWidget(
            titleButtom: "Agendar nova consulta",
            fontSize: 24,
            height: 100,
            onTap: () {},
          ),
          Text('Ou', style: Fonts.titleMedium(context))
              .paddingSymmetric(vertical: 10)
              .toCenter,
          const MainOffersListPartial()
        ],
      ),
    );
  }
}
