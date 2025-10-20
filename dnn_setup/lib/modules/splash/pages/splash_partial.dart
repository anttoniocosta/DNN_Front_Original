import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SplashPartial extends StatelessWidget {
  const SplashPartial({super.key, required this.image, required this.bgColor});

  final String image;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image, width: 180),
          20.heightGap,
          Text(
            switch (appContext.type) {
              AppTypeEnum.CLIENT => 'Para você',
              AppTypeEnum.COMPANY => 'Empresa',
              AppTypeEnum.CLINIC => 'Clínica',
              AppTypeEnum.SELLER => switch (appContext.ctx) {
                  AppContextEnum.HIS => 'Vendedor',
                  AppContextEnum.HIA => 'Afiliado',
                  AppContextEnum.HIR => 'Revendedor',
                  String() => 'Vendas',
                  null => 'Vendas',
                },
              AppTypeEnum.SPECIALIST => 'Especialista',
              int() => 'Para você',
            },
            style: Fonts.displayMedium(context).copyWith(
              color: AppColors.whiteColor,
            ),
            textAlign: TextAlign.center,
          ).toCenter
        ],
      ).toCenter,
    );
  }
}
