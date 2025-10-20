import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CampaignLocatonInfosPage extends StatelessWidget {
  CampaignLocatonInfosPage({super.key});

  final _zipcodeKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  Future<void> onContinue() async {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        await accountController
            .createAccount(providersController.setAccount())
            .then((created) async {
          if (created) {
            await shoppingCartController.addShoppingCartMain();
            Get.offNamedUntil(
              Routes.campaignHireForDependent,
              ModalRoute.withName(Routes.campaignComplementsOffers),
            );
          } else {
            CustomDialogs.simpleDialog(
              title: 'Atenção',
              context: Get.context!,
              content: Column(children: [
                Text(
                  'Este CPF já possuí conta, faça o login para acessar a sua conta.',
                  style: Fonts.titleSmall(Get.context!),
                ),
                20.heightGap,
                GetBuilder<NavigationController>(
                  builder: (_) {
                    return SecondaryButtonWidget(
                      onTap: () {
                        providersController.clear();
                        _.setIndex(NavigationTabs.home);
                        Get.offAllNamed(Routes.basePage);
                        Future.delayed(const Duration(milliseconds: 500), () {
                          _.navigatePageView(NavigationTabs.login);
                        });
                      },
                      titleButtom: 'Entrar na conta',
                    );
                  },
                ),
                10.heightGap,
                PrimaryButtonWidget(
                  onTap: () => Get.back(),
                  titleButtom: 'Voltar',
                )
              ]),
            );
          }
        });
        break;
      case AppTypeEnum.COMPANY:
        Get.toNamed(Routes.campaignHireForDependent);
        break;
      default:
        Get.toNamed(Routes.campaignHireForDependent);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      scrollReverse: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.personalLocation)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.personalLocation),
          20.heightGap,
          FormPartialZipcode(formKey: _formKey, zipcodeKey: _zipcodeKey),
          GetBuilder<AccountController>(
            builder: (_) {
              return PrimaryButtonWidget(
                titleButtom: 'Confirmar',
                isLoading: accountController.isLoading.value,
                onTap: () async {
                  if (_formKey.currentState!.validate() &&
                      _zipcodeKey.currentState!.validate()) {
                    onContinue();
                  }
                },
              );
            },
          ),
          10.heightGap,
        ],
      ),
    );
  }
}
