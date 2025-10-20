import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CardForDetails extends StatelessWidget {
  const CardForDetails({super.key, required this.children, this.bgColor});

  final Widget children;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: highElevation,
        color: bgColor ?? Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [children],
        ),
      ),
    );
  }
}
