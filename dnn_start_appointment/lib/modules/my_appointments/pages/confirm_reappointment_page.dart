import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ConfirmReappointmentPage extends StatefulWidget {
  const ConfirmReappointmentPage({super.key});

  @override
  State<ConfirmReappointmentPage> createState() =>
      _ConfirmReappointmentPageState();
}

class _ConfirmReappointmentPageState extends State<ConfirmReappointmentPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: true,
      title: 'Minhas consultas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: ConfirmChoicePartial(
        textToConfirm: 'Você tem certeza que deseja reagendar essa consulta? ',
        onConfirm: () {},
        onReject: () {},
      ),
    );
  }
}
