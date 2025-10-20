import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class OnReappointmentHoursPage extends StatelessWidget {
  const OnReappointmentHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppointmentHoursPartial(
      titlePage: 'Aguardando aprovação',
      contentTitle:
          'Consultas aguardando confirmação de reagendamento pelo paciente',
      dayTitle: 'Dia da consulta selecionada',
      daySelected: '18/10/2023',
      child: Column(
        children: [
          AppointmentWithOneActionCard(
            hour: '11:00',
            centerText: 'Consulta agendada',
            onTap: () {},
            buttonTitle: 'Cancelar reagendamento',
          ),
          AppointmentWithOneActionCard(
            hour: '16:00',
            centerText: 'Consulta agendada',
            onTap: () {},
            buttonTitle: 'Cancelar reagendamento',
          ),
        ],
      ),
    );
  }
}
