import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/modules/gateway/export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class GatewayButton extends StatelessWidget {
  const GatewayButton({
    super.key,
    required this.onTap,
    required this.name,
    required this.id,
  });

  final VoidCallback onTap;
  final String name;
  final int id;

  IconData gatewayIcon(int id) {
    switch (id) {
      case GatewayEnum.PIX_GNT:
      case GatewayEnum.PIX_MP:
        return FontAwesomeIcons.pix;
      case GatewayEnum.BILLET_GNT:
      case GatewayEnum.BILLET_MP:
        return FontAwesomeIcons.barcode;
      case GatewayEnum.CREDIT_GNT:
      case GatewayEnum.CREDIT_MP:
        return FontAwesomeIcons.creditCard;
      default:
        return FontAwesomeIcons.triangleExclamation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        highlightColor: AppColors.transparent,
        splashColor: AppColors.transparent,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            boxShadow: highElevation,
            color:
                Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          child: Row(
            children: [
              Center(
                child: FaIcon(
                  gatewayIcon(id),
                  color: Get.isDarkMode
                      ? AppColors.whiteColor
                      : AppColors.blackDarkColor,
                  size: 32,
                ),
              ),
              18.widthGap,
              Expanded(
                child: Text(name, style: Fonts.titleMedium(context)),
              ),
            ],
          ).paddingSymmetric(vertical: 16, horizontal: 28),
        ),
      ),
    );
  }
}
