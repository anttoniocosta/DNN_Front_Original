import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MyAddressForPaymentPage extends StatefulWidget {
  const MyAddressForPaymentPage({super.key});

  @override
  State<MyAddressForPaymentPage> createState() =>
      _MyAddressForPaymentPageState();
}

class _MyAddressForPaymentPageState extends State<MyAddressForPaymentPage> {
  final _zipcodeKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.addressForPayment)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.addressForPayment),
          const SizedBox(height: 20),
          FormPartialZipcode(formKey: _formKey, zipcodeKey: _zipcodeKey),
          const SizedBox(height: 20),
          GetBuilder<CreditCardController>(
            builder: (_) {
              return PrimaryButtonWidget(
                isLoading: creditCardController.isLoadingAddress.value,
                titleButtom: 'Continuar',
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  if (_formKey.currentState!.validate()) {
                    Get.toNamed(Routes.creditResumeFinishPage);

                    creditCardController.setCreditCard();
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
