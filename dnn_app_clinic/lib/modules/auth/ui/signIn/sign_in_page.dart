import 'package:dnn_app_clinic/core/clinic/controller/my_specialists_controller.dart';
import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<MySpecialistsController>(
        builder: (_) {
          return SignInPartial(
            signInAction: () async {
              navigationController.setIndex(0);
              Get.offAllNamed(Routes.basePage);
              _.getMySpecialists();
            },
            buttonRegisterTitle: 'Cadastre-sua clínica',
          );
        },
      ),
    );
  }
}
