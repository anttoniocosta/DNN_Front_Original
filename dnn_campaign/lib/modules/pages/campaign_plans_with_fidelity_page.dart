import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_shopping_cart/dnn_shopping_cart.dart';

import 'package:flutter/material.dart';

class CampaignPlansWithFidelityPage extends StatelessWidget {
  const CampaignPlansWithFidelityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingCartController>(
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          title: 'Pagamento',
          maxWidth: Responsive.maxWidth(),
          bodyChild: GetBuilder<ShoppingCartController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightGap,
                  Text(
                    'Veja os planos que possuem fidelidade',
                    style: Fonts.headlineMedium(context),
                  ),
                  30.heightGap,
                  ...shoppingCartController.shoppingCartPersons!.items!
                      .where((x) =>
                          x.products!.firstWhereOrNull((y) =>
                              y.fidelityMonth != null &&
                              y.hasFidelity == true) !=
                          null)
                      .map((person) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person.person!.fullName!.capitalize!,
                          style: Fonts.titleLarge(context).copyWith(
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Divider(height: 0),
                        16.heightGap,
                        ...person.products!
                            .where((x) =>
                                x.hasFidelity == true &&
                                x.fidelityMonth != null)
                            .map(
                              (product) => Container(
                                decoration:
                                    BoxDecoration(boxShadow: highElevation),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Get.isDarkMode
                                            ? AppColors.midBlackColor
                                            : AppColors.whiteColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product.productName!,
                                              style: Fonts.titleSmall(context),
                                            ),
                                            Text(
                                              '${product.productPrice!.formatReal()}/mês',
                                              style: Fonts.titleSmall(context),
                                            )
                                          ],
                                        ).paddingSymmetric(
                                          horizontal: 20,
                                          vertical: 7,
                                        ),
                                      ),
                                      Container(
                                        color: Colors.green,
                                        width: double.infinity,
                                        child: Text(
                                                '* Fidelidade de ${product.fidelityMonth} mês',
                                                style:
                                                    Fonts.titleMedium(context)
                                                        .copyWith(
                                                  color: AppColors.whiteColor,
                                                ))
                                            .paddingSymmetric(
                                              horizontal: 20,
                                              vertical: 7,
                                            )
                                            .toCenter,
                                      )
                                    ],
                                  ),
                                ),
                              ).paddingOnly(bottom: 10),
                            ),
                      ],
                    ).paddingOnly(bottom: 30);
                  }),
                  Text(
                    '* Em caso de cancelamento, é importante estar ciente de que podem ser aplicadas taxas e multas. Avalie a fidelidade do plano antes de contratar, para seguir para a forma de pagamento clique em aceitar e continuar.',
                    style: Fonts.bodyLarge(context).copyWith(fontSize: 16),
                  ),
                  Visibility(
                    visible: Responsive.isTabletOrDesktop(),
                    child: PrimaryButtonWidget(
                      onTap: () => Get.toNamed(Routes.useTerms),
                      titleButtom: 'Aceitar e continuar',
                    ).paddingOnly(top: 20),
                  ),
                  100.heightGap,
                ],
              );
            },
          ),
          bottomSheet: Visibility(
            visible: !Responsive.isTabletOrDesktop(),
            child: BottomConfirmButton(
              onTap: () => Get.toNamed(Routes.useTerms),
              title: 'Aceitar e continuar',
            ),
          ),
        );
      },
    );
  }
}
