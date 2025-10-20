import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class RegisterTypesPage extends StatelessWidget {
  const RegisterTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: 'Cadastro',
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Como deseja se cadastrar?',
            style: Fonts.headlineMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 10),
          40.heightGap,
          Row(
            children: [
              Expanded(
                child: SecondaryButtonWidget(
                  onTap: () => Get.toNamed(Routes.registerPersonal),
                  titleButtom: 'Pessoa Física',
                ),
              ),
              16.widthGap,
              Expanded(
                child: PrimaryButtonWidget(
                  onTap: () => Get.toNamed(Routes.registerCompany),
                  titleButtom: 'Pessoa Jurídica',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
