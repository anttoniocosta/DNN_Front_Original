import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_shopping_cart/dnn_shopping_cart.dart';
import 'package:flutter/material.dart';

class CampaignDependentsZipCodePage extends StatelessWidget {
  CampaignDependentsZipCodePage({super.key});

  final _zipcodeKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: switch (appContext.type) {
        AppTypeEnum.CLIENT =>
          pagesController.currentPage(PagesEnum.dependentLocation)?.name,
        AppTypeEnum.COMPANY => 'Endereço',
        int() => pagesController.currentPage(PagesEnum.dependentLocation)?.name,
      },
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle(),
          20.heightGap,
          FormPartialZipcode(formKey: _formKey, zipcodeKey: _zipcodeKey),
          20.heightGap,
          GetBuilder<ShoppingCartController>(
            builder: (_) {
              return PrimaryButtonWidget(
                titleButtom: 'Continuar',
                isLoading: shoppingCartController.addDependentLoading.value,
                onTap: () async {
                  await shoppingCartController.addDependentToShoppingCart();
                },
              );
            },
          ),
          10.heightGap,
        ],
      ),
    );
  }

  Widget _subtitle() {
    switch (appContext.type) {
      case AppTypeEnum.CLIENT:
        return Text(
          'Para finalizar, nos informe o endereço do dependente.',
          style: Fonts.bodyLarge(Get.context!).copyWith(
            fontFamily: Fonts.poppins,
          ),
        );
      case AppTypeEnum.COMPANY:
        return Text(
          'Agora, nos informe os dados do endereço do seu colaborar ou dependente dele.',
          style: Fonts.bodyLarge(Get.context!),
        );
      default:
        return const PageHeader(pgEnum: PagesEnum.dependentLocation);
    }
  }
}
