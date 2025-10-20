import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignDependentPersonalInfoPage extends StatefulWidget {
  const CampaignDependentPersonalInfoPage({super.key});

  @override
  State<CampaignDependentPersonalInfoPage> createState() =>
      _CampaignDependentPersonalInfoPageState();
}

class _CampaignDependentPersonalInfoPageState
    extends State<CampaignDependentPersonalInfoPage> {
  final _cpfKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    providersController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: switch (appContext.type) {
            AppTypeEnum.CLIENT =>
              pagesController.currentPage(PagesEnum.dependentInfos)?.name,
            AppTypeEnum.COMPANY => 'Dados pessoais',
            int() =>
              pagesController.currentPage(PagesEnum.dependentInfos)?.name,
          } ??
          '',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle(),
          20.heightGap,
          FormPartialPersonalInfo(formKey: _formKey, cpfKey: _cpfKey),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: PrimaryButtonWidget(
          titleButtom: 'Continuar',
          onTap: () {
            if (_formKey.currentState!.validate() &&
                _cpfKey.currentState!.validate()) {
              Get.toNamed(Routes.campaignDependentLocationInfos);
            }
          },
        ),
      ),
    );
  }

  Widget _subtitle() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return Text(
          'Para iniciar, nos informe os dados do seu dependente.',
          style: Fonts.bodyLarge(Get.context!).copyWith(
            fontFamily: Fonts.poppins,
          ),
        );
      case AppTypeEnum.COMPANY:
        return Text(
          'Para começar, nos informe os dados do seu colaborar ou do dependente dele.',
          style: Fonts.bodyLarge(Get.context!).copyWith(
            fontFamily: Fonts.poppins,
          ),
        );
      default:
        return const PageHeader(pgEnum: PagesEnum.dependentInfos);
    }
  }
}
