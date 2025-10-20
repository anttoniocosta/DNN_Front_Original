import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SucessDataChangedPage extends StatelessWidget {
  const SucessDataChangedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: true,
      title: 'Meus dados',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.heightGap,
            Text(
              'Dados da clínica salvos com sucesso!',
              style: Fonts.displaySmall(context),
              textAlign: TextAlign.center,
            ),
            Image.asset(MediaRes.medicalKit, width: 250).toCenter,
            20.heightGap,
            PrimaryButtonWidget(
              onTap: () {
                navigationController.setIndex(NavigationTabs.home);
                Get.toNamed(Routes.basePage);
              },
              titleButtom: 'Voltar para o ínicio',
            ),
            20.heightGap
          ],
        ),
      ),
    );
  }
}
