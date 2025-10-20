import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class InitializePage extends StatelessWidget {
  const InitializePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MobileLayout(
        needCenter: true,
        needScrollView: false,
        needAppBar: false,
        maxWidth: Responsive.maxWidth(),
        bodyChild: InitializePartial(onStart: () async {
          try {
            final userData = await storage.getAccount();
            if (userData != null) {
              accountController.setAccountCreated(userData);
            }
            navigationController.getUserLogged();
            if (userData != null) {
              if (userData.expiredAt!.compareDate() == 1) {
                accountController.handleSaveLocalData();
              } else {
                await accountController.getAccount();

                wsServices.start();
              }
            }
          } catch (e) {
            debugPrint(e.toString());
          }
          Get.offAllNamed(Routes.basePage);
        }),
      ),
    );
  }
}
