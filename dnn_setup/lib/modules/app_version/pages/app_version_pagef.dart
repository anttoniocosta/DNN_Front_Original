import 'dart:io';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_setup/modules/app_version/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppVersionPage extends StatelessWidget {
  const AppVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MobileLayout(
        needCenter: false,
        needScrollView: true,
        hasLeading: true,
        appBarLeading: const SizedBox(),
        bodyChild: GetBuilder<AppVersionController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightGap,
                SvgPicture.asset(
                  MediaRes.waitingCallConectionImg,
                  width: 200,
                ).toCenter,
                24.heightGap,
                Text(
                  'Caro(a) usuário(a),',
                  style: Fonts.titleSmall(context),
                ),
                10.heightGap,
                Text(
                  'Gostaríamos de informar que uma nova versão do nosso aplicativo está disponível com melhorias de desempenho e recursos aprimorados. Para garantir a melhor experiência, recomendamos que você atualize o aplicativo agora. Acesse a loja de aplicativos do seu dispositivo e clique em "Atualizar" para desfrutar das últimas melhorias.',
                  style: Fonts.bodyLarge(context),
                ),
                20.heightGap,
                Text(
                  'Agradecemos pela sua colaboração!',
                  style: Fonts.bodyLarge(context),
                ),
                10.heightGap,
                Text(
                  'Atenciosamente,\nDoutor na net',
                  style: Fonts.titleSmall(context),
                ),
                30.heightGap,
                GetBuilder<AppVersionController>(builder: (_) {
                  String link = '';
                  if (Platform.isAndroid) {
                    link = appVersionController.appModel!.urlGoogle!;
                  }
                  if (Platform.isIOS) {
                    link = appVersionController.appModel!.urlApple!;
                  }
                  return PrimaryButtonWidget(
                    onTap: () => AppFunctions.urlLauncherSimples(link),
                    titleButtom: 'Atualizar',
                  );
                }),
                10.heightGap,
                SecondaryButtonWidget(
                  onTap: () => exit(0),
                  titleButtom: 'Sair do aplicativo',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
