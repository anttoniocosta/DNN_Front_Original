import 'package:dnn_core/all_exports.dart';
import 'package:dnn_offers/modules/offers/model/offers_response_mode.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardOffer extends StatelessWidget {
  const CardOffer({
    super.key,
    required this.offer,
  });

  final OffersModel offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? AppColors.lighterblackLightColor
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: highElevation,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                offer.logo!,
                width: 70,
              ),
              10.widthGap,
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${offer.discount!.toStringAsFixed(0)}% de desconto',
                    style: Fonts.titleLarge(context).copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          16.heightGap,
          Text(
            '${offer.address}, ${offer.number} / Bairro: ${offer.neighborhood} / Cidade: ${offer.city} / Estado: ${offer.state} / CEP: ${offer.zipcode!.formatCep()}',
            style: Fonts.bodyLarge(context).copyWith(fontSize: 14, height: 1.1),
          ),
          8.heightGap,
          Text(
            'Tel: ${offer.phoneNumber!.formatPhone()}',
            style: Fonts.titleLarge(context).copyWith(fontSize: 14),
          ),
          8.heightGap,
          SeeMapWidget(
            address: offer.address!,
            number: offer.number!,
            neighborhood: offer.neighborhood!,
            city: offer.city!,
            state: offer.state!,
            zipcode: offer.zipcode!,
          ).toCenter,
        ],
      ),
    );
  }
}
