import 'package:flutter/material.dart';

abstract class CCardWidget extends StatelessWidget {
  final String issuer;
  final String lastFourDigits;
  final String holder;
  final VoidCallback onTap;
  final VoidCallback removeOnTap;

  const CCardWidget({
    super.key,
    required this.issuer,
    required this.lastFourDigits,
    required this.onTap,
    required this.holder,
    required this.removeOnTap,
  });

  @override
  Widget build(BuildContext context);
}
