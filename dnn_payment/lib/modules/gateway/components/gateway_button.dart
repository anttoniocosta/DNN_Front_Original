import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class GatewayButton extends StatelessWidget {
  const GatewayButton({
    super.key,
    required this.onTap,
    required this.name,
    required this.id,
    this.icon,
  });

  final VoidCallback onTap;
  final String name;
  final int id;
  final IconData? icon;

  String gatewayIcon(int id) {
    switch (id) {
      case GatewayEnum.PIX_GNT:
      case GatewayEnum.PIX_MP:
        return MediaRes.paymentPix;
      case GatewayEnum.BILLET_GNT:
      case GatewayEnum.BILLET_MP:
        return MediaRes.paymentBillet;
      case GatewayEnum.CREDIT_GNT:
      case GatewayEnum.CREDIT_MP:
        return MediaRes.paymentCredit;
      default:
        return '';
    }
  }

  Color gatewayColor(int id) {
    switch (id) {
      case GatewayEnum.PIX_GNT:
      case GatewayEnum.PIX_MP:
        return const Color(0xff00bdae);
      case GatewayEnum.BILLET_GNT:
      case GatewayEnum.BILLET_MP:
        return const Color(0xff332c45);
      case GatewayEnum.CREDIT_GNT:
      case GatewayEnum.CREDIT_MP:
        return const Color(0xff0081f8);
      default:
        return AppColors.transparent;
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
            border: Border.all(
              color: Get.isDarkMode ? gatewayColor(id) : gatewayColor(id),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(radiusLarge),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 32,
                  child: Image.asset(
                    gatewayIcon(id),
                    height: 22,
                  )),
              5.widthGap,
              Text(
                name,
                style: Fonts.titleMedium(context).copyWith(
                    color: gatewayColor(id), fontWeight: FontWeight.w400,fontFamily: 'Poppins'),
              )
            ],
          ).paddingSymmetric(vertical: 16, horizontal: 28),
        ),
      ),
    );
  }
}
