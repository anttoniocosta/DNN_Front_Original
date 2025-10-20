import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class HomeActionsListWidget extends StatelessWidget {
  const HomeActionsListWidget({super.key, required this.cardList});

  final List<Widget> cardList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            maxCrossAxisExtent: 150,
            mainAxisExtent: 125,
          ),
          itemCount: cardList.length,
          itemBuilder: (BuildContext context, int index) {
            return cardList[index];
          },
        ).paddingSymmetric(horizontal: 20).toCenter,
      ],
    );
  }
}
