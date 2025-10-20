import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:flutter/material.dart';

class BodyContractListWidget extends StatelessWidget {
  const BodyContractListWidget(
      {super.key, required this.index, required this.type});
  final int index;
  final String type;

  @override
  Widget build(BuildContext context) {
    if (index == 0) return ActiveContractsPartial(type: type);
    if (index == 1) return InactiveContractsPartial(type: type);
    if (index == 2) return TerminatedContractsPartial(type: type);
    return const SizedBox();
  }
}
