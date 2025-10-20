import 'package:dnn_app_clinic/core/clinic/controller/update_specialist.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/widgets.dart';

class SpecialistUpdateData extends StatefulWidget {
  const SpecialistUpdateData({super.key});

  @override
  State<SpecialistUpdateData> createState() => _SpecialistUpdateDataState();
}

class _SpecialistUpdateDataState extends State<SpecialistUpdateData> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Dados do especialista',
      bodyChild: GetBuilder<UpdateSpecialistController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informações pessoais',
                    style: Fonts.titleMedium(context),
                  ).paddingOnly(bottom: 10),
                  CPFInput(
                    controller: _.document,
                    isEnabled: false,
                  ),
                  RGInput(
                    controller: _.registration,
                    isEnabled: false,
                  ),
                  CRMInput(
                    controller: _.crmController,
                    isEnabled: false,
                  ),
                  NameInput(
                    controller: _.name,
                    label: 'Nome do profissional',
                    hint: 'Nome completo do especialista',
                  ),
                  GenderDropdownMenu(controller: _.gender),
                  10.heightGap,
                  DateInput(
                      label: 'Data de nascimento', controller: _.birthDay),
                  PhoneInput(controller: _.phone),
                  EmailInput(controller: _.email),
                  Text(
                    'Endereço',
                    style: Fonts.titleMedium(context),
                  ).paddingOnly(bottom: 10),
                  CEPInput(controller: _.zipcode),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3, child: StreetInput(controller: _.address)),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2, child: NumberInput(controller: _.number))
                    ],
                  ),
                  ComplementInput(controller: _.complement),
                  NeighborhoodInput(controller: _.neighborhood),
                  CityInput(controller: _.city),
                  StateInput(controller: _.state),
                  Text(
                    'Valor padrão da consulta',
                    style: Fonts.titleMedium(context),
                  ).paddingOnly(bottom: 10),
                  PriceInput(
                    controller: _.price,
                    needValidate: false,
                    onChanged: (p0) {
                      if (p0.returnNumber() == 0.00) {
                        _.clearPrice();
                      }
                    },
                  ),
                ],
              ),
            ),
            10.heightGap,
            PrimaryButtonWidget(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  await _.updateSpecialist();
                }
              },
              titleButtom: 'Salvar',
            ),
            10.heightGap,
          ],
        );
      }),
    );
  }
}
