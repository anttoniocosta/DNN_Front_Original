import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/widgets.dart';
import 'package:dnn_shared/dnn_shared.dart';

class LoginModal extends StatelessWidget {
  const LoginModal({super.key, required this.signInAction});
  final VoidCallback signInAction;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        builder: (authenticationController) => Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButtonWidget(
                    titleButtom: 'Entrar',
                    onTap: () {
                      Navigator.pop(context);
                      navigationController
                          .navigatePageView(NavigationTabs.login);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('ou',
                          style: TextStyle(
                              color: AppColors.darkGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                      .toCenter,
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: LoginButton(
                          label: "Login Google",
                          type: 'google',
                          assetName: MediaRes.googleLogo,
                          onPressed: () async {
                            Navigator.pop(context);
                            authenticationController
                                .signInWithGoogle(signInAction);
                          },
                        ).toCenter,
                      ),
                      Flexible(
                        child: LoginButton(
                          label: "Login Apple",
                          type: 'apple',
                          assetName: MediaRes.appleLogo,
                          onPressed: () async {
                            Navigator.pop(context);
                            authenticationController
                                .signInWithApple(signInAction);
                          },
                        ).toCenter,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _registerAction(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Não possuir uma conta?',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        10.widthGap,
                        const Text(
                          'Inscreva-se',
                          style: TextStyle(
                              color: AppColors.blueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  _registerAction() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        Get.toNamed(Routes.registerPersonal);
        break;
      case AppTypeEnum.COMPANY:
        Get.toNamed(Routes.registerCompany);
        break;
      case AppTypeEnum.CLINIC:
        Get.toNamed(Routes.registerClinic);
        break;
      case AppTypeEnum.SELLER:
        Get.toNamed(Routes.registerType);
        break;
      default:
    }
  }
}
