import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/res/exports.dart';
import 'package:dnn_shared/utils/export.dart';
import 'package:flutter/material.dart';

class SeeMapWidget extends StatelessWidget {
  const SeeMapWidget({
    super.key,
    required this.address,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipcode,
    this.color,
  });

  final String address;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String zipcode;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppFunctions.openGoogleMaps(
          address: address,
          number: number,
          neighboorhood: neighborhood,
          city: city,
          state: state,
          zipcode: zipcode,
        );
      },
      child: Text(
        'Ver mapa',
        style: Fonts.titleMedium(context).copyWith(
          color: color,
          decoration: TextDecoration.underline,
          decorationThickness: 2,
          decorationColor:
              color ?? (Get.isDarkMode ? AppColors.whiteColor : null),
          height: 1.1,
        ),
      ),
    );
  }
}
