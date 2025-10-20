import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistPersonalZipCodePage extends StatefulWidget {
  const SpecialistPersonalZipCodePage({super.key});

  @override
  State<SpecialistPersonalZipCodePage> createState() =>
      _SpecialistPersonalZipCodePageState();
}

class _SpecialistPersonalZipCodePageState
    extends State<SpecialistPersonalZipCodePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> zipcodeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Meus especialistas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightGap,
          FormPartialZipcode(formKey: formKey, zipcodeKey: zipcodeKey),
          24.heightGap,
        ],
      ),
      bottomNavigationBar: BottomConfirmButton(
        onTap: () => Get.toNamed(Routes.addSpecialistSpecialty),
        title: 'Continuar',
      ),
    );
  }
}
