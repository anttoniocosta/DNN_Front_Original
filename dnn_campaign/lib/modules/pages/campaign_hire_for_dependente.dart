import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignHireForDependentPage extends StatefulWidget {
  const CampaignHireForDependentPage({super.key});

  @override
  State<CampaignHireForDependentPage> createState() =>
      _CampaignHireForDependentPageState();
}

class _CampaignHireForDependentPageState
    extends State<CampaignHireForDependentPage> {
  @override
  void initState() {
    if (appContext.type == AppTypeEnum.COMPANY) {
      _init();
    }

    super.initState();
  }

  _init() async {
    campaignController.clearChoicedPlans();
    await shoppingCartController.getShoppingCart();
    await shoppingCartController.addShoppingCartMain();
  }

  @override
  void dispose() {
    if (appContext.type == AppTypeEnum.COMPANY) {
      campaignController.clearChoicedPlans();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Adicione Dependente',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.heightGap,
          Text(
            _textTitle(),
            style: Fonts.headlineMedium(context).copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          10.heightGap,
          Text(
            _textContent(),
            style: Fonts.bodyLarge(context).copyWith(
              fontSize: 15,
            ),
          ),
          24.heightGap,
          InkWell(
            onTap: () {
              Get.toNamed(Routes.campaignDependentPersonalInfos);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyColor),
              child: Column(
                children: [
                  10.heightGap,
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      MediaRes.heartHand,
                      fit: BoxFit.fitWidth,
                    ).toCenter,
                  ),
                  6.heightGap,
                  Text(
                    'Adicionar Dependente',
                    textAlign: TextAlign.center,
                    style: Fonts.bodySmall(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: Responsive.isTabletOrDesktop(),
            child: GetBuilder<ShoppingCartController>(builder: (_) {
              return PrimaryButtonWidget(
                isLoading:
                    shoppingCartController.shoppingCartPersonsLoading.value,
                onTap: () async {
                  await shoppingCartController.getShoppingCartPersons();
                  Get.toNamed(Routes.campaignCartResume);
                },
                titleButtom: 'Não adicionar e Continuar',
              ).paddingAll(20);
            }),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !Responsive.isTabletOrDesktop(),
        child: GetBuilder<ShoppingCartController>(builder: (_) {
          return PrimaryButtonWidget(
            height: 50,
            isLoading: shoppingCartController.shoppingCartPersonsLoading.value,
            onTap: () async {
              await shoppingCartController.getShoppingCartPersons();
              Get.toNamed(Routes.campaignCartResume);
            },
            titleButtom: 'Não adicionar e Continuar',
          ).paddingAll(20);
        }),
      ),
    );
  }

  String _textTitle() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return 'Adicione algum Dependente';
      case AppTypeEnum.COMPANY:
        return 'Adicione algum Colaborador';
      default:
        return 'Adicione algum Dependente';
    }
  }

  String _textContent() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return 'Você pode garantir os cuidados com a saúde de seus familiares e amigos. Sem restrição de vinculo familiar.';
      case AppTypeEnum.COMPANY:
        return 'Você pode garantir os cuidados com a saúde de seus colaboradores e os familiares deles.';
      default:
        return 'Você pode garantir os cuidados com a saúde de seus familiares e amigos. Sem restrição de vinculo familiar.';
    }
  }
}
