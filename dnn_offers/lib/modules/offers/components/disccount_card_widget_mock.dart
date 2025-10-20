import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mocks/offers_mock.dart';

class DisccountCardMock extends StatelessWidget {
  const DisccountCardMock({
    super.key,
    required this.onTap,
    required this.offer,
  });

  final VoidCallback onTap;
  final OffersModelMock offer;

  final _border = const BorderRadius.all(Radius.circular(15));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _border,
      child: Container(
        width: 296,
        height: 149,
        decoration: BoxDecoration(borderRadius: _border),
        child: ClipRRect(
          borderRadius: _border,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                offer.imagePath,
                fit: BoxFit.fill,
                width: 296,
                height: 149,
              ),
              Container(
                width: 296,
                height: 149,
                color: Colors.black.withOpacity(0.6),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 240,
                    child: Text(
                      offer.cardText,
                      textAlign: TextAlign.center,
                      style: Fonts.headlineMedium(context).copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontFamily: Fonts.poppins,
                      ),
                    ).toCenter,
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
