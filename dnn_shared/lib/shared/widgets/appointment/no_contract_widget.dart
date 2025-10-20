import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class NoContractInformation extends StatelessWidget {
  const NoContractInformation(
      {super.key, required this.title, this.imageAsset = MediaRes.noInvoices});

  final String title;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        32.heightGap,
        Image.asset(
          imageAsset,
          height: 200,
        ),
        32.heightGap,
        Text(
          title,
          style: Fonts.titleLarge(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
