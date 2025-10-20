import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class DisccountCard extends StatelessWidget {
  const DisccountCard({
    super.key,
    required this.segmentDisccount,
    required this.icon,
    required this.backgroudColor,
    required this.segmentName,
    required this.onTap,
  });

  final String segmentDisccount;
  final String segmentName;
  final String icon;
  final VoidCallback onTap;
  final Color backgroudColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        width: 296,
        decoration: BoxDecoration(
          color: backgroudColor,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 29),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GANHE até',
                  style: Fonts.titleSmall(context)
                      .copyWith(color: AppColors.whiteColor),
                ),
                Text(
                  '$segmentDisccount%',
                  style: Fonts.displayMedium(context)
                      .copyWith(color: AppColors.whiteColor),
                ),
                Text(
                  'DE DESCONTO',
                  style: Fonts.titleSmall(context)
                      .copyWith(color: AppColors.whiteColor),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'EM ',
                    style: Fonts.titleSmall(context)
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  TextSpan(
                    text: segmentName,
                    style: Fonts.displaySmall(context).copyWith(
                      color: AppColors.whiteColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.whiteColor,
                      height: 1.2,
                      decorationThickness: 2,
                    ),
                  )
                ])),
              ],
            ),
            const Align(
              alignment: Alignment.topRight,
              child: FaIcon(
                FontAwesomeIcons.stethoscope,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
