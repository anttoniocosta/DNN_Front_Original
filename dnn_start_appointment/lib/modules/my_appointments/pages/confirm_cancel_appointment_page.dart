import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class ConfirmCancelAppointmentPage extends StatefulWidget {
  const ConfirmCancelAppointmentPage({super.key});

  @override
  State<ConfirmCancelAppointmentPage> createState() =>
      _ConfirmCancelAppointmentPageState();
}

class _ConfirmCancelAppointmentPageState
    extends State<ConfirmCancelAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: true,
      title: 'Minhas consultas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<MyAppointmentsController>(
        builder: (_) {
          return ConfirmChoicePartial(
            isLoading: _.isCancel.value,
            textToConfirm:
                'Você tem certeza que deseja cancelar essa consulta?',
            onConfirm: () async {
              await _.cancelAppointment();
              await _.getMyAppointments();
            },
            onReject: () => Get.back(),
          );
        },
      ),
    );
  }
}
