import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/widgets.dart';

class InvoiceFilterList extends StatelessWidget {
  const InvoiceFilterList(
      {super.key, required this.currentIndex, required this.changeIndex});

  final int currentIndex;
  final void Function(int index) changeIndex;

  static List<FilterChipsModel> invoiceTypes = [
    FilterChipsModel(index: 0, title: 'Ativos'),
    FilterChipsModel(index: 1, title: 'Inativos'),
    FilterChipsModel(index: 2, title: 'Encerrados'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: invoiceTypes
            .map(
              (e) => FilterChipsCustom(
                chip: e,
                index: currentIndex,
                onTap: () => changeIndex(e.index),
              ).paddingOnly(right: 10),
            )
            .toList(),
      ),
    );
  }
}
