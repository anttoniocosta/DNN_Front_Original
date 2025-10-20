import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:dnn_shared/dnn_shared.dart';

import 'package:flutter/material.dart';

class CardListPartial extends StatelessWidget {
  const CardListPartial(
      {super.key, required this.newCardOnTap, required this.cardList});

  final VoidCallback newCardOnTap;
  final Widget cardList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.cardList.isEmpty,
          needScrollView: true,
          maxWidth: Responsive.maxWidth(),
          title: pagesController.currentPage(PagesEnum.creditCardMyCards)?.name,
          bodyChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_.cardList.isNotEmpty) ...[
                const PageHeader(pgEnum: PagesEnum.creditCardMyCards),
                20.heightGap,
              ],
              cardList,
              Visibility(
                visible: Responsive.isTabletOrDesktop(),
                child: PrimaryButtonWidget(
                  onTap: newCardOnTap,
                  titleButtom: 'Novo cartão',
                ).paddingOnly(top: 40),
              ),
              50.heightGap,
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: !Responsive.isTabletOrDesktop(),
            child: BottomConfirmButton(
              onTap: newCardOnTap,
              title: 'Novo cartão',
            ),
          ),
        );
      },
    );
  }
}
