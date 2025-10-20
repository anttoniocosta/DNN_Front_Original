import 'package:flutter/material.dart';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_dependencies/sc_util.dart';

import 'package:dnn_shared/dnn_shared.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails({
    super.key,
    this.canContact = false,
    this.moreActions,
    required this.name,
    required this.email,
    this.urlPhoto,
    required this.document,
    required this.phone,
  });

  final bool? canContact;
  final List<PopupMenuItem<String>>? moreActions;
  final String name;
  final String email;
  final String document;
  final String phone;
  final String? urlPhoto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => personInfosDialog(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PictureWidget(
            img: ValueNotifier<String>(urlPhoto ?? MediaRes.blankImg),
            size: const Size(50, 50),
            radius: 12,
          ),
          10.widthGap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name.capitalize!,
                        style: Fonts.titleSmall(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MenuPopup(
                      items: [
                        popupMenuItem(
                          context: context,
                          onTap: () {
                            Future.delayed(
                              const Duration(seconds: 0),
                              () => personInfosDialog(),
                            );
                          },
                          icon: FontAwesomeIcons.solidUser,
                          title: 'Detalhes',
                        ),
                      ],
                    ),
                  ],
                ),
                TextForDescriptions(
                  title: 'Documento',
                  text: document.formatDocument(),
                  hasPadding: false,
                ),
              ],
            ),
          )
        ],
      ),
    ).paddingOnly(bottom: 10);
  }

  personInfosDialog() {
    CustomDialogs.simpleDialog(
      title: 'Dados da pessoa',
      context: Get.context!,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          TextForDescriptions(
            text: name.capitalize!,
            title: 'Nome',
          ),
          TextForDescriptions(
            text: document.formatDocument(),
            title: 'Documento',
          ),
          TextForDescriptions(
            text: email,
            title: 'E-mail',
          ),
          TextForDescriptions(
            text: phone.formatPhone(),
            title: 'Contato',
            hasPadding: false,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PersonActions(
                icon: FontAwesomeIcons.whatsapp,
                onTap: () {
                  AppFunctions.urlLauncherWhatsapp(
                    '55$phone',
                    'Olá, ${name.capitalizeFirst}',
                  );
                },
              ),
              _PersonActions(
                icon: FontAwesomeIcons.phone,
                onTap: () {
                  AppFunctions.urlLauncherWithScheme(
                    phone,
                    scheme: 'tel',
                  );
                },
              ),
              _PersonActions(
                icon: FontAwesomeIcons.solidEnvelope,
                onTap: () {
                  AppFunctions.urlLauncherWithScheme(
                    email,
                    scheme: 'mailto',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PersonActions extends StatelessWidget {
  const _PersonActions({required this.onTap, required this.icon});

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: onTap,
        icon: FaIcon(icon, size: 26, color: AppColors.blueColor),
      ),
    );
  }
}

class MenuPopup extends StatelessWidget {
  const MenuPopup({super.key, required this.items});

  final List<PopupMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: PopupMenuButton<String>(
        surfaceTintColor: !Get.isDarkMode
            ? Theme.of(context).scaffoldBackgroundColor
            : AppColors.midBlackColor,
        icon: Icon(Icons.more_vert,
            color: Get.isDarkMode
                ? AppColors.whiteColor
                : AppColors.midBlackColor),
        offset: const Offset(0, 24),
        padding: EdgeInsets.zero,
        itemBuilder: (context) => items,
      ),
    );
  }
}

PopupMenuItem<String> popupMenuItem({
  required BuildContext context,
  required VoidCallback onTap,
  required IconData icon,
  required String title,
}) {
  return PopupMenuItem<String>(
    onTap: onTap,
    child: Row(
      children: [
        FaIcon(icon, size: 16.h, color: AppColors.blueColor),
        SizedBox(width: 16.h),
        Text(title, style: Fonts.titleSmall(context)),
      ],
    ),
  );
}
