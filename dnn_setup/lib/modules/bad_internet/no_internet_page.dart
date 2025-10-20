import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

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
              'packages/dnn_shared/assets/images/no_connection.svg',
              fit: BoxFit.fitWidth,
            ),
            10.heightGap,
            Text(
              'Perda de conexão',
              style: Fonts.displayLarge(context),
              textAlign: TextAlign.center,
            ),
            6.heightGap,
            Text(
              'Parece que você perdeu conexão com a internet, por favor, verifique sua conexão e tente novamente.',
              style: Fonts.bodyLarge(context),
              textAlign: TextAlign.center,
            ),
            30.heightGap,
            GetBuilder<ConnectionManagerController>(builder: (_) {
              return PrimaryButtonWidget(
                isLoading: connectivityController.isLoading.value,
                titleButtom: 'Tentar novamente',
                onTap: () async {
                  LoadingDialog.show(context);
                  await connectivityController.getBaseConfigs().then(
                        (value) => LoadingDialog.hide(context),
                      );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
