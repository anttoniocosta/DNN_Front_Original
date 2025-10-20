import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MyChoiceAdressPage extends StatelessWidget {
  const MyChoiceAdressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: false,
      hasActions: false,
      maxWidth: Responsive.maxWidth(),
      title:
          pagesController.currentPage(PagesEnum.choiceAddressForPayment)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.choiceAddressForPayment),
          30.heightGap,
          AddressChoiceWidget(
            onTap: () {
              creditCardController.isMyAddress.value = true;
              Get.toNamed(Routes.creditResumeFinishPage);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meu endereço cadastrado',
                  style: Fonts.headlineMedium(context),
                ),
                AddressFormatted(
                  address: accountController.userAccount!.address!,
                  city: accountController.userAccount!.city!,
                  neighborhood: accountController.userAccount!.neighborhood!,
                  number: accountController.userAccount!.number!,
                  state: accountController.userAccount!.state!,
                  zipcode: accountController.userAccount!.zipcode!,
                )
              ],
            ),
          ),
          20.heightGap,
          AddressChoiceWidget(
            onTap: () {
              creditCardController.isMyAddress.value = false;
              Get.toNamed(Routes.addressForPayment);
            },
            child: Text(
              'Outro endereço.',
              style: Fonts.headlineMedium(context),
            ),
          ),
          Visibility(
            visible: Responsive.isTabletOrDesktop(),
            child: PrimaryButtonWidget(
              onTap: () => Get.back(),
              titleButtom: 'Voltar',
            ).paddingOnly(top: 40),
          ),
          20.heightGap,
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !Responsive.isTabletOrDesktop(),
        child: BottomConfirmButton(
          onTap: () => Get.back(),
          title: 'Voltar',
        ),
      ),
    );
  }
}
