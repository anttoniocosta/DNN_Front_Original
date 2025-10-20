// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dnn_dependencies/sc_util.dart';

import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    super.key,
    required this.isNull,
    required this.onTap,
    required this.title,
    this.heght,
    this.fontSize,
    this.needHzPadding = true,
  });

  final bool isNull;
  final VoidCallback onTap;
  final String title;
  final double? heght;
  final double? fontSize;
  final bool? needHzPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: needHzPadding! ? 20.h : 0, vertical: 10),
        child: SizedBox(
          height: heght ??
              Responsive.doubleSizes(mobile: 50, tablet: 50, desktop: 50),
          width: Responsive.maxWidth(),
          child: ElevatedButton(
            onPressed: isNull ? null : onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Center(
                        child: Text(
                  title,
                  style: Fonts.titleLarge(context).copyWith(
                      color: AppColors.whiteColor, fontSize: fontSize),
                ))),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Responsive.doubleSizes(
                      mobile: 24, tablet: 24, desktop: 24),
                  color: AppColors.whiteColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
