import 'package:dnn_shared/res/exports.dart';
import 'package:flutter/material.dart';

class AddressFormatted extends StatelessWidget {
  const AddressFormatted({
    super.key,
    required this.address,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipcode,
  });
  final String address;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String zipcode;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      style: Fonts.bodyMedium(context),
      children: [
        TextSpan(text: '$address '),
        TextSpan(text: 'Nº$number, '),
        TextSpan(text: '$neighborhood, '),
        TextSpan(text: '$city - '),
        TextSpan(text: '$state, '),
        TextSpan(text: '$zipcode.'),
      ],
    ));
  }
}
