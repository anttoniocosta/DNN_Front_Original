import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistConsultDurationPage extends StatefulWidget {
  const SpecialistConsultDurationPage({super.key});

  @override
  State<SpecialistConsultDurationPage> createState() =>
      _SpecialistConsultDurationPageState();
}

class _SpecialistConsultDurationPageState
    extends State<SpecialistConsultDurationPage> {
  List<String> durations = [
    "30 min",
    "50 min",
    "01 hora",
    "02 horas",
    "03 horas",
    "04 horas",
    "05 horas",
    "06 horas",
    "07 horas",
    "08 horas",
    "12 horas",
    "24 horas",
  ];
  String duration = '';

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
          Text(
            'Qual a duração da consulta desse especialista?',
            style: Fonts.headlineMedium(context),
          ),
          24.heightGap,
          Wrap(
            spacing: 10,
            runSpacing: 5,
            children: durations
                .map(
                  (x) => SizedBox(
                    width: Get.width * .28,
                    child: HourCardSelection(
                      onTap: () => setState(() {
                        if (x == duration) {
                          duration = '';
                        } else {
                          duration = x;
                        }
                      }),
                      title: x,
                      isSelected: x == duration,
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
      bottomNavigationBar: BottomConfirmButton(
        onTap:
            duration == '' ? null : () => Get.toNamed(Routes.addSpecialistType),
        title: 'Continuar',
      ),
    );
  }
}
