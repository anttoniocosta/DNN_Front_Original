import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.midBlackColor : AppColors.blueColor,
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(15),
          bottomEnd: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: AppConstants.pdHorizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: kToolbarHeight - 10),
            10.heightGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PictureWidget(
                      img: accountController.userPhoto,
                      size: const Size(45, 45),
                    ),
                    const MenuButtom(color: AppColors.whiteColor),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: SvgPicture.asset(
                        MediaRes.horizontalBrancoAzulClaro,
                        fit: BoxFit.contain,
                      ),
                    ),
                    appContext.type != AppTypeEnum.CLIENT
                        ? Text(
                            switch (appContext.type) {
                              AppTypeEnum.COMPANY => 'Empresa',
                              AppTypeEnum.SELLER => switch (appContext.ctx) {
                                  AppContextEnum.HIS => 'Vendedor',
                                  AppContextEnum.HIA => 'Afiliado',
                                  AppContextEnum.HIR => 'Revendedor',
                                  String() => 'Vendas',
                                  null => 'Vendas',
                                },
                              AppTypeEnum.SPECIALIST => 'Especialista',
                              //AppTypeEnum.CLIENT => '',
                              AppTypeEnum.CLINIC => 'Clínica',
                              int() => '',
                            },
                            style: Fonts.titleSmall(context)
                                .copyWith(color: AppColors.whiteColor),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            30.heightGap,
          ],
        ),
      ),
    );
  }
}
