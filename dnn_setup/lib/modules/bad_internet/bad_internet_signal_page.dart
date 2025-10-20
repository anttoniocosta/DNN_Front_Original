import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class BadInternetSignalPage extends StatelessWidget {
  const BadInternetSignalPage({super.key});

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
          children: [
            SvgPicture.asset(
              MediaRes.failPaymentImg,
              fit: BoxFit.fitWidth,
            ),
            30.heightGap,
            Text(
              'Tivemos um problema por aqui!',
              style: Fonts.displaySmall(context),
              textAlign: TextAlign.center,
            ),
            6.heightGap,
            Text(
              'Por favor, tente outra vez',
              style: Fonts.bodyLarge(context),
              textAlign: TextAlign.center,
            ),
            30.heightGap,
            GetBuilder<ConnectionManagerController>(builder: (_) {
              return PrimaryButtonWidget(
                isLoading: connectivityController.isLoading.value,
                titleButtom: 'Tentar novamente',
                onTap: dnnController.onTapError ??
                    () async {
                      Get.offAllNamed(Routes.initialize);
                    },
              );
            })
          ],
        ),
      ),
    );
  }
}
