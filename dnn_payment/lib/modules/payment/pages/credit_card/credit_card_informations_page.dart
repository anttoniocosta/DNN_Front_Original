import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/card/controller/card_controller.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CreditCardInformationsPage extends StatefulWidget {
  const CreditCardInformationsPage({super.key});

  @override
  State<CreditCardInformationsPage> createState() =>
      _CreditCardInformationsPageState();
}

class _CreditCardInformationsPageState
    extends State<CreditCardInformationsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cardController.canRegisterCard.value == true;
    creditCardController.clearCard();
    super.initState();
  }

  @override
  void dispose() {
    creditCardController.clearCard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: (Responsive.maxWidth()),
      title: pagesController.currentPage(PagesEnum.creditCardInfos)?.name,
      backAction: () {
        Get.back();
        creditCardController.clear();
      },
      bodyChild: CreditCardInfoPartial(
        formKey: _formKey,
        finisherButtom: GetBuilder<CardController>(
          builder: (_) {
            return PrimaryButtonWidget(
              isLoading: cardController.isLoading.value,
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  await cardController.creditCardInfoAction();
                }
              },
              titleButtom: 'Continuar',
            );
          },
        ),
      ),
    );
  }
}
