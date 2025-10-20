import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        CircularProgressIndicator.adaptive(),
      ],
    )).paddingAll(4);
  }
}
