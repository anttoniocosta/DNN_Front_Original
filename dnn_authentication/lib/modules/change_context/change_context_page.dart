import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeContextPage extends StatefulWidget {
  const ChangeContextPage({super.key});

  @override
  State<ChangeContextPage> createState() => _ChangeContextPageState();
}

class _ChangeContextPageState extends State<ChangeContextPage> {
  onTap(String e) {
    authenticationController.currentInstance = null;
    appContext.setCtx(e);
    splashController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(builder: (_) {
      return MobileLayout(
        needCenter: _.contextAvaiable.isEmpty,
        needScrollView: true,
        title: 'Troca de contexto',
        maxWidth: Responsive.maxWidth(),
        bodyChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<AuthenticationController>(
              builder: (_) {
                if (_.contextAvaiable.isEmpty) {
                  return TryAgainPage(
                      message:
                          'Você não possui acesso a essa aplicação, entre com uma conta com permissão',
                      buttonTitle: 'Sair',
                      onTryAgain: () {
                        authenticationController.impersonateCode = '';
                        appContext.setCtx(null);

                        navigationController.setIndex(NavigationTabs.home);

                        authenticationController.signOut(() {
                          navigationController.getUserLogged();
                          Get.offAllNamed(Routes.basePage);
                        });
                      });
                }

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aqui você tem a opção de mudança do contexto do aplicativo, escolha entre os contextos diponíveis para acessar sua conta.',
                        style: Fonts.bodyLarge(context),
                      ),
                      20.heightGap,
                      ..._.contextAvaiable.map((e) {
                        if (e == AppContextEnum.HIS) {
                          return InstanceTile(
                            text: 'HIS - Vendedor',
                            onTap: () => onTap(e),
                          ).paddingOnly(bottom: 20);
                        }

                        if (e == AppContextEnum.HIA) {
                          return InstanceTile(
                            text: 'HIA - Afiliado',
                            onTap: () => onTap(e),
                          ).paddingOnly(bottom: 20);
                        }

                        if (e == AppContextEnum.HIR) {
                          return InstanceTile(
                            text: 'HIR - Revendedor',
                            onTap: () => onTap(e),
                          ).paddingOnly(bottom: 20);
                        } else {
                          return SizedBox(
                            child: Text(e),
                          );
                        }
                      }).toList(),
                    ]);
              },
            ),
          ],
        ),
      );
    });
  }
}
