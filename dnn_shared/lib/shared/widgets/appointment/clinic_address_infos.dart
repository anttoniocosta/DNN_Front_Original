import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ClinicAddressInfos extends StatelessWidget {
  const ClinicAddressInfos({
    super.key,
    required this.isSelected,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.number,
    this.needSeeMap = true,
  });

  final bool? isSelected;
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;
  final String number;
  final bool? needSeeMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Endereço da clínica:',
          style: Fonts.bodyLarge(context).copyWith(
            color: isSelected == true ? AppColors.whiteColor : null,
          ),
        ),
        Text(
          '${street.capitalize}, $number',
          style: Fonts.titleSmall(context).copyWith(
            color: isSelected == true ? AppColors.whiteColor : null,
          ),
        ),
        Text(
          neighborhood.capitalize!,
          style: Fonts.titleSmall(context).copyWith(
            color: isSelected == true ? AppColors.whiteColor : null,
          ),
        ),
        Text(
          'Cidade: $city',
          style: Fonts.titleSmall(context).copyWith(
            color: isSelected == true ? AppColors.whiteColor : null,
          ),
        ),
        if (needSeeMap!)
          Row(
            children: [
              Expanded(
                child: Text(
                  'Estado: $state, CEP: ${zipCode.formatCep()}',
                  style: Fonts.titleSmall(context).copyWith(
                    color: isSelected == true ? AppColors.whiteColor : null,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SeeMapWidget(
                color: isSelected == true ? AppColors.whiteColor : null,
                address: street,
                number: number,
                neighborhood: neighborhood,
                city: city,
                state: state,
                zipcode: zipCode,
              ),
            ],
          )
        else
          Text(
            'Estado: $state, CEP: ${zipCode.formatCep()}',
            style: Fonts.titleSmall(context).copyWith(
              color: isSelected == true ? AppColors.whiteColor : null,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

class ClinicAddressInfosInline extends StatelessWidget {
  const ClinicAddressInfosInline({
    super.key,
    required this.isSelected,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.number,
    this.needSeeMap = true,
    this.color,
  });

  final bool? isSelected;
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;
  final String number;
  final bool? needSeeMap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Endereço da clínica:',
          style: Fonts.bodyLarge(context).copyWith(
            color: color ?? (isSelected == true ? AppColors.whiteColor : null),
          ),
        ),
        Text(
          '$street, $number, $neighborhood - $city | $state, ${zipCode.formatCep()}',
          style: Fonts.titleSmall(context).copyWith(
            color: color ?? (isSelected == true ? AppColors.whiteColor : null),
          ),
        ),
        if (needSeeMap!)
          Row(
            children: [
              SeeMapWidget(
                color:
                    color ?? (isSelected == true ? AppColors.whiteColor : null),
                address: street,
                number: number,
                neighborhood: neighborhood,
                city: city,
                state: state,
                zipcode: zipCode,
              ),
            ],
          )
      ],
    );
  }
}
