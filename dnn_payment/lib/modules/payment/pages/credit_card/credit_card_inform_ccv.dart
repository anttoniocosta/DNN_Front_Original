import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CreditCardInformCCVPage extends StatefulWidget {
  const CreditCardInformCCVPage({super.key});

  @override
  State<CreditCardInformCCVPage> createState() =>
      _CreditCardInformCCVPageState();
}

class _CreditCardInformCCVPageState extends State<CreditCardInformCCVPage> {
  final key = GlobalKey<FormState>();
  final ccv = TextEditingController();

  @override
  void initState() {
    cardController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.creditCardCVV)?.name,
      bodyChild: GetBuilder<CardController>(builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(pgEnum: PagesEnum.creditCardCVV),
            20.heightGap,
            CardForDetails(
              bgColor: Colors.green.withOpacity(0.2),
              children: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: [
                    Image.asset(_.card!.issuer!.creditCardIssuer(), width: 50),
                    22.widthGap,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: _.card!.issuer!.capitalize,
                                  style: Fonts.titleSmall(context),
                                ),
                                TextSpan(
                                    text: '***** ',
                                    style: Fonts.bodyLarge(context)),
                                TextSpan(
                                  text: _.card!.lastFourDigits,
                                  style: Fonts.titleSmall(context),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Titular: ${_.card!.holderName!}',
                            style: Fonts.bodySmall(context),
                          )
                        ],
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.circleCheck,
                      size: 32,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            20.heightGap,
            Form(key: key, child: CCVInput(controller: _.ccv)),
            Visibility(
              visible: Responsive.isTabletOrDesktop(),
              child: GetBuilder<CardController>(
                builder: (_) {
                  return PrimaryButtonWidget(
                    isLoading: cardController.isLoading.value,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (key.currentState!.validate()) {
                        await cardController.creditIndefyCCVAction();
                      }
                    },
                    titleButtom: 'Continuar',
                  );
                },
              ).paddingOnly(top: 20),
            ),
            20.heightGap,
          ],
        );
      }),
      bottomSheet: Visibility(
        visible: !Responsive.isTabletOrDesktop(),
        child: GetBuilder<CardController>(
          builder: (_) {
            return BottomConfirmButton(
              isLoading: cardController.isLoading.value,
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (key.currentState!.validate()) {
                  await cardController.creditIndefyCCVAction();
                }
              },
              title: 'Continuar',
            );
          },
        ),
      ),
    );
  }
}
