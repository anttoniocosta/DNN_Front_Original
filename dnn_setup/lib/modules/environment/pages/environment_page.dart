import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class EnvironmentPage extends StatelessWidget {
  const EnvironmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: false,
      hasActions: false,
      maxWidth: Responsive.maxWidth(),
      title: 'Ambiente',
      bodyChild: GetBuilder<DnnController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextForDescriptions(
              text: dnnController.apiUrl,
              title: 'Ambiente atual',
            ),
            const Spacer(),
            PrimaryButtonWidget(
              isLoading: connectivityController.isLoading.value,
              titleButtom: 'Ambiente Produção',
              onTap: () async {
                dnnController.changeUrl(Environment.Production);
              },
            ),
            10.heightGap,
            SecondaryButtonWidget(
              titleButtom: 'Ambiente Homologação',
              onTap: () async {
                dnnController.changeUrl(Environment.Hml);
              },
            ),
            10.heightGap,
            SecondaryButtonWidget(
              titleButtom: 'Ambiente Tester',
              onTap: () async {
                dnnController.changeUrl(Environment.Tester);
              },
            ),
            const Spacer(),
          ],
        );
      }),
    );
  }
}
