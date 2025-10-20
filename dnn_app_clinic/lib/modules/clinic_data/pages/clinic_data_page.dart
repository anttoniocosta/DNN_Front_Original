import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ClinicDataPage extends StatelessWidget {
  const ClinicDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Meus dados',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.heightGap,
            Text(
              'Dados da clínica',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            NameInput(
              controller: TextEditingController(),
              label: 'Nome da Clínica',
              hint: 'Ex.: Clínica Lavosier',
            ),
            CNPJInput(controller: TextEditingController()),
            PhoneInput(controller: TextEditingController()),
            EmailInput(controller: TextEditingController()),
            CEPInput(controller: TextEditingController()),
            StreetInput(controller: TextEditingController()),
            Row(
              children: [
                Expanded(
                  child: NumberInput(controller: TextEditingController()),
                ),
                17.widthGap,
                Expanded(
                  child: ComplementInput(controller: TextEditingController()),
                ),
              ],
            ),
            NeighborhoodInput(controller: TextEditingController()),
            Row(
              children: [
                Expanded(
                  child: StateInput(controller: TextEditingController()),
                ),
                17.widthGap,
                Expanded(
                  child: CityInput(controller: TextEditingController()),
                ),
              ],
            ),
            24.heightGap,
            Text(
              'Responsável financeiro',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            NameInput(
              controller: TextEditingController(),
              label: 'Nome do responsável',
              hint: 'Ex.: Eduardo Silva',
            ),
            EmailInput(controller: TextEditingController()),
            PhoneInput(controller: TextEditingController()),
            24.heightGap,
            Text(
              'Responsável administrativo',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            NameInput(
              controller: TextEditingController(),
              label: 'Nome do responsável',
              hint: 'Ex.: Eduardo Silva',
            ),
            EmailInput(controller: TextEditingController()),
            PhoneInput(controller: TextEditingController()),
            24.heightGap,
            PrimaryButtonWidget(
              onTap: () => Get.toNamed(Routes.clinicaDataChanged),
              titleButtom: 'Salvar',
            ),
            20.heightGap
          ],
        ),
      ),
    );
  }
}
