import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class BuyCard extends StatelessWidget {
  const BuyCard({super.key, required this.onTap, this.width = 296});

  final VoidCallback onTap;
  final double? width;

  final _border = const BorderRadius.all(Radius.circular(15));
  final height = 149.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _border,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: _border),
        child: ClipRRect(
          borderRadius: _border,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                MediaRes.doctorBuy,
                fit: BoxFit.fill,
                width: width,
                height: height,
              ),
              Container(
                width: width,
                height: height,
                color: Colors.black.withOpacity(0.6),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.gift,
                    color: AppColors.whiteColor,
                    size: 40,
                  ).paddingOnly(right: 6),
                  Text(
                    'COMPRAR AGORA',
                    style: Fonts.titleSmall(context).copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ).toCenter,
            ],
          ),
        ),
      ),
    );
  }
}
