import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ConsultsScheduled extends StatelessWidget {
  const ConsultsScheduled({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      height: 149,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 8, color: AppColors.midBlackColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                quantity.toString(),
                style: Fonts.displayLarge(context)
                    .copyWith(fontSize: 64, color: AppColors.blackLightColor),
              ),
              Text('consultas',
                  style: Fonts.titleMedium(context)
                      .copyWith(color: AppColors.blackLightColor)),
            ],
          ),
          16.widthGap,
          Expanded(
            child: Text(
              'Agendadas para essa semana',
              style: Fonts.displayLarge(context).copyWith(
                  fontSize: 20, height: 1.3, color: AppColors.blackLightColor),
            ).paddingOnly(right: 40),
          )
        ],
      ),
    ).paddingOnly(left: 20);
  }
}
