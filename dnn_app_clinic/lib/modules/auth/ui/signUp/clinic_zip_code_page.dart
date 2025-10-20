import 'package:dnn_app_clinic/core/clinic/controller/clinic_account_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ClinicZipcodePage extends StatelessWidget {
  ClinicZipcodePage({super.key});

  final _zipcodeKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      scrollReverse: true,
      maxWidth: Responsive.maxWidth(),
      title: 'Endereço',
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.personalLocation),
          20.heightGap,
          FormPartialZipcode(formKey: _formKey, zipcodeKey: _zipcodeKey),
          GetBuilder<ClinicAccountController>(
            builder: (_) {
              return PrimaryButtonWidget(
                isLoading: _.isLoading.value,
                titleButtom: 'Confirmar',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await _.createClinic(providersController.setAccount());
                  }
                },
              );
            },
          ),
          10.heightGap,
        ],
      ),
    );
  }
}
