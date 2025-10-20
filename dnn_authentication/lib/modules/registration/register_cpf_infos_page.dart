import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class RegisterCPFInfoPage extends StatefulWidget {
  const RegisterCPFInfoPage({super.key});

  @override
  State<RegisterCPFInfoPage> createState() => _RegisterCPFInfoPageState();
}

class _RegisterCPFInfoPageState extends State<RegisterCPFInfoPage> {
  final _cpfKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    providersController.clear();
    super.initState();
  }

  @override
  void dispose() {
    providersController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.personalInfos)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightGap,
          const PageHeader(pgEnum: PagesEnum.personalInfos),
          20.heightGap,
          FormPartialPersonalInfo(formKey: _formKey, cpfKey: _cpfKey),
          20.heightGap,
          GetBuilder<AccountController>(
            builder: (_) {
              return PrimaryButtonWidget(
                onTap: () {
                  if (_formKey.currentState!.validate() &&
                      _cpfKey.currentState!.validate()) {
                    Get.toNamed(Routes.registerZipcode);
                  }
                },
                titleButtom: 'Inscrever-se',
              );
            },
          ),
          20.heightGap,
          _terms(context),
          40.heightGap,
        ],
      ),
    );
  }

  _terms(context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(
          Routes.useTerms,
          arguments: true,
        )
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Ao clicar em Criar conta, você concorda com',
              style: Fonts.bodyLarge(context).copyWith(
                color: AppColors.secondaryTextColor,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('os ',
                  style: Fonts.bodyLarge(context).copyWith(
                    color: AppColors.secondaryTextColor,
                  )),
              Text(
                'Termos e políticas do sistema',
                style: Fonts.bodyLarge(context).copyWith(
                  color: AppColors.blueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
