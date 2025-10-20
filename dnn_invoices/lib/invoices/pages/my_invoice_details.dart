import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MyInvoiceDetails extends StatelessWidget {
  MyInvoiceDetails({super.key});

  final InvoiceResponseModel invoice = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: pagesController.currentPage(PagesEnum.myPlans)?.name,
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          24.heightGap,
          Text(
            invoice.productName!,
            style: Fonts.headlineMedium(context),
          ),
          24.heightGap,
          Row(
            children: [
              PictureWidget(
                img: ValueNotifier<String>(
                    invoice.holder!.photoProfile ?? MediaRes.blankImg),
                size: const Size(70, 70),
              ),
              13.widthGap,
              Expanded(
                child: Text(
                  invoice.holder!.name!.capitalize!,
                  style: Fonts.headlineMedium(context),
                ),
              )
            ],
          ),
          10.heightGap,
          _separatorTitle('Informações pessoais'),
          12.heightGap,
          RicthTextCustom(
            title: 'Documento',
            description: invoice.holder!.document?.formatDocument() ?? '',
          ),
          RicthTextCustom(
            title: 'Data de nascimento',
            description: invoice.holder!.birthday?.formatDateFromIso() ?? '',
          ),
          RicthTextCustom(
            title: 'Idade',
            description: invoice.holder!.age?.toString() ?? '',
          ),
          RicthTextCustom(
            title: 'Sexo',
            description: invoice.holder!.gender ?? '',
          ),
          16.heightGap,
          SecondaryButtonWidget(
            onTap: () {
              Get.toNamed(Routes.myEditData);
            },
            titleButtom: 'Editar Dados',
          ),
          32.heightGap,
          _separatorTitle('Informações do plano'),
          12.heightGap,
          RicthTextCustom(
            title: 'Plano',
            description: invoice.productName ?? '',
          ),
          RicthTextCustom(
            title: 'Data de contratação',
            description: invoice.startDate?.formatMMYYYY() ?? '',
          ),
          RicthTextCustom(
            title: 'Status do contrato',
            description: _contractStatusText(),
          ),
          Visibility(
            visible: Responsive.isTabletOrDesktop(),
            child: GetBuilder<NavigationController>(builder: (_) {
              return PrimaryButtonWidget(
                onTap: () {
                  navigationController.setIndex(NavigationTabs.home);
                  Get.offAllNamed(Routes.basePage);
                },
                titleButtom: 'Voltar para o início',
              );
            }).paddingOnly(top: 24),
          ),
          32.heightGap,
          _separatorTitle('Dependentes'),
          12.heightGap,
          ...invoice.dependents!.map(
            (dependent) => dependent.isOwner == true
                ? const SizedBox()
                : PersonDetails(
                    name: dependent.name!,
                    email: dependent.email!,
                    document: dependent.document!,
                    phone: dependent.phoneNumber!,
                    urlPhoto: dependent.photoProfile,
                  ),
          ),
          60.heightGap,
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !Responsive.isTabletOrDesktop(),
        child: GetBuilder<NavigationController>(builder: (_) {
          return BottomConfirmButton(
            onTap: () {
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
            },
            title: 'Voltar para o início',
          );
        }),
      ),
    );
  }

  Container _separatorTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1,
            color: Get.isDarkMode
                ? AppColors.whiteColor
                : AppColors.blackDarkColor,
          ),
        ),
      ),
      child: Text(
        title,
        style: Fonts.headlineMedium(Get.context!),
      ),
    );
  }

  String _contractStatusText() {
    String text = '';

    if (invoice.cancelationAt == null && invoice.blockedAt == null) {
      text = AppTexts.CONTRACT_ACTIVE.tr;
    }

    if (invoice.cancelationAt == null && invoice.blockedAt != null) {
      text = AppTexts.CONTRACT_INACTIVE.tr;
    }

    if (invoice.cancelationAt != null) {
      text = AppTexts.CONTRACT_TERMINATED.tr;
    }

    return text;
  }
}

class RicthTextCustom extends StatelessWidget {
  final String title;
  final String description;

  const RicthTextCustom({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "$title: ", style: Fonts.bodyLarge(context)),
          TextSpan(text: description, style: Fonts.titleSmall(context)),
        ],
      ),
    );
  }
}
