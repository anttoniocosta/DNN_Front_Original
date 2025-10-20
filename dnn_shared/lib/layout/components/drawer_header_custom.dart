import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class DrawerHeaderCustom extends StatelessWidget {
  const DrawerHeaderCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (_) {
        if (_.userAccount == null) return const _NoUserWidget();
        return const _UserWelcomeWidget();
      },
    );
  }
}

class _UserWelcomeWidget extends StatelessWidget {
  const _UserWelcomeWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PictureWidget(
                img: accountController.userPhoto,
                size: const Size(70, 70),
              ),
              const _BackButtonSideBar()
            ],
          ),
        ),
        22.heightGap,
        Text(
          accountController.userAccount!.fullName!.capitalize!,
          style: Fonts.titleLarge(context).copyWith(
            fontFamily: Fonts.poppins,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        5.heightGap,
        Row(
          children: [
            Image.asset(MediaRes.locationIcon, width: 16).toCenter,
            Text(
              accountController.userAccount!.city!,
              style: Fonts.bodyMedium(context).copyWith(
                height: 0.9,
                fontFamily: Fonts.poppins,
              ),
            ),
            Text(
              ' - ${accountController.userAccount!.state!}',
              style: Fonts.bodyMedium(context).copyWith(
                height: 0.9,
                fontFamily: Fonts.poppins,
              ),
            ),
          ],
        ),
        5.heightGap,
        const Divider(
          thickness: 2,
        )
      ],
    ).paddingOnly(top: 60, left: 10);
  }
}

class _NoUserWidget extends StatelessWidget {
  const _NoUserWidget();

  _picture() => Get.isDarkMode
      ? MediaRes.horizontalBranco
      : MediaRes.horizontalAzulEscuro;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(_picture(), fit: BoxFit.fitWidth, width: 150),
            const _BackButtonSideBar()
          ],
        ),
        16.heightGap,
        Text(
          'Telemedicina no conforto da sua casa.',
          style: Fonts.bodyLarge(context).copyWith(fontSize: 16),
        ).paddingOnly(right: 30),
      ],
    ).paddingOnly(top: 60, left: 10);
  }
}

class _BackButtonSideBar extends StatelessWidget {
  const _BackButtonSideBar();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Obx(
          () => IconButton(
            color: themeController.isDark.value
                ? AppColors.whiteColor
                : AppColors.blueColor,
            onPressed: () {
              Scaffold.of(context).closeDrawer();
            },
            icon: const FaIcon(FontAwesomeIcons.chevronRight),
          ),
        );
      },
    );
  }
}
