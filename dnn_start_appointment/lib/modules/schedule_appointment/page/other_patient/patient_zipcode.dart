import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PatientZipCodePage extends StatelessWidget {
  PatientZipCodePage({super.key});

  final _zipcodeKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      scrollReverse: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.personalLocation)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.personalLocation),
          20.heightGap,
          FormPartialZipcode(formKey: _formKey, zipcodeKey: _zipcodeKey),
          GetBuilder<AccountController>(
            builder: (_) {
              return PrimaryButtonWidget(
                isLoading: accountController.isLoading.value,
                titleButtom: 'Confirmar',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    storage.saveAccountForSchedule(
                        providersController.setAccount());
                    Get.toNamed(Routes.useTerms);
                  }
                },
              );
            },
          ),
          20.widthGap,
        ],
      ),
    );
  }
}
