import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MyCreditCardsListPage extends StatelessWidget {
  const MyCreditCardsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CardListPartial(
      newCardOnTap: () => Get.toNamed(Routes.creditCardInfos),
      cardList: GetBuilder<CardController>(builder: (_) {
        if (cardController.isLoading.value) {
          return const PageLoadingWidget();
        }
        if (cardController.cardList.isEmpty) {
          return TryAgainPage(
            message:
                'Houve um problema ou você não possui cartões cadastrados.',
            onTryAgain: () async => await cardController.getCardList(),
          );
        }
        return Column(
          children: cardController.cardList.map((e) {
            final card = e.decrypt();
            return CustomCreditCardTile(
              issuer: card.issuer!.capitalize!,
              lastFourDigits: card.lastFourDigits,
              holder: card.holderName!,
              onTap: () async {
                cardController.setChoicedCard(card);
                Get.toNamed(Routes.indentifyCCV);
              },
              removeOnTap: () async {
                CustomDialogs.confirmDialog(
                  title: 'Deseja remover este cartão?',
                  backAcion: () => Get.back(),
                  backVisible: true,
                  confirmAcion: () async {
                    await cardController
                        .deleteCreditCard(card.id!)
                        .then((value) => Get.back());
                  },
                  context: context,
                );
              },
            );
          }).toList(),
        );
      }),
    );
  }
}
