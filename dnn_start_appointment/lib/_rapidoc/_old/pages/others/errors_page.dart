import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErroPage extends StatelessWidget {
  const ErroPage({
    key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: true,
      needAppBar: false,
      bottomNavigationBar: BottomConfirmButton(
        onTap: () {
          Get.back();
        },
        title: "Voltar",
      ),
      bodyChild: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                MediaRes.horizontalOriginal,
                width: 250,
              ),
              40.heightGap,
              Text(
                message,
                style: Fonts.displaySmall(context).copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              20.heightGap,
              SecondaryButtonWidget(
                titleButtom: "Entrar em Contato",
                onTap: () {
                  CustomDialogs.simpleDialog(
                    title: 'Como deseja entrar em contato?',
                    context: Get.context!,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        20.heightGap,
                        ContactButton(
                          title: 'Whataspp',
                          icon: FontAwesomeIcons.whatsapp,
                          onTap: () async => AppFunctions.urlLauncherWhatsapp(
                            '5508001509008',
                            'Olá, Doutor na Net!',
                          ),
                        ),
                        const Divider(),
                        10.heightGap,
                        ContactButton(
                          title: 'E-mail',
                          icon: FontAwesomeIcons.envelope,
                          onTap: () async => AppFunctions.urlLauncherWithScheme(
                            'suporte@doutornanet.com.br',
                            scheme: 'mailto',
                          ),
                        ),
                        const Divider(),
                        10.heightGap,
                        ContactButton(
                          title: 'Telefone',
                          icon: FontAwesomeIcons.phone,
                          onTap: () {
                            AppFunctions.urlLauncherWithScheme(
                              '5508006995003',
                              scheme: 'tel',
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
