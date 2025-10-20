import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Entrar',
      hasLeading: true,
      maxWidth: Responsive.maxWidth(),
      appBarLeading: const MenuButtom(),
      drawer: const DrawerCustom(navbarItems: NaviItems()),
      bodyChild: GetBuilder<SpecialistController>(
        builder: (specialist) {
          return SignInPartial(
            signInAction: () async {
              specialist.finishDuty();
              navigationController.navigatePageView(NavigationTabs.home);
              wsServices.start();
            },
            buttonRegisterTitle: 'Criar conta',
          );
        },
      ),
    );
  }
}
