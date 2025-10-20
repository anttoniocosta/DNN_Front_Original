import 'package:dnn_app_clinic/core/clinic/controller/my_specialists_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistConsultPricePage extends StatefulWidget {
  const SpecialistConsultPricePage({super.key});

  @override
  State<SpecialistConsultPricePage> createState() =>
      _SpecialistConsultPricePageState();
}

class _SpecialistConsultPricePageState
    extends State<SpecialistConsultPricePage> {
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySpecialistsController>(
      builder: (_) {
        return MobileLayout(
          needCenter: false,
          needScrollView: true,
          title: 'Meus especialistas',
          maxWidth: Responsive.maxWidth(),
          bodyChild: GetBuilder<MySpecialistsController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightGap,
                  Text(
                    'Qual a valor padrão da consulta?',
                    style: Fonts.headlineMedium(context),
                  ),
                  20.heightGap,
                  PriceInput(
                    controller: _.priceController,
                    onChanged: (value) => _.checkPrice(value),
                  ),
                ],
              );
            },
          ),
          bottomSheet: BottomConfirmButton(
            isLoading: _.isLoadingCreate.value,
            onTap: _.iPriceChecked
                ? null
                : () async {
                    _.setSpecialistCreateModel(
                      model: providersController.setAccount(),
                      price: _.priceController.text.returnNumber(),
                      specialtyId: _.selectedSpecialty!.id!,
                      crmNumber: _.crmController.text.replaceAll('.', ''),
                    );
                    _.createSpecialist(_.specialistCreateModel!);
                  },
            title: 'Continuar',
          ),
        );
      },
    );
  }
}
