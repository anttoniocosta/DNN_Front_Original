import 'dart:developer';

import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

abstract class AppointmentsStatusEnum {
  static const int agendada = 1;
  static const int realizado = 2;
  static const int cancelado = 3;
  static const int aguardandoReagendamento = 4;
  static const int naoRealizado = 5;
}

class ChoiceAppointmentTypePage extends StatelessWidget {
  const ChoiceAppointmentTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Minhas consultas',
      bodyChild: GetBuilder<MyDoctorsAppointmentsController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            Text(
              'Selecione a agenda desejada',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            ..._.statusList.map(
              (status) => AppointmentTypeWidget(
                onTap: () async {
                  _.setStatus(status);
                  final result = await _.getDoctorAppointment();
                  if (result) {
                    log(_.status!.id!.toString());
                    switch (_.status!.id!) {
                      case AppointmentsStatusEnum.agendada:
                        Get.toNamed(Routes.appointmentedSelectDay);
                        break;
                      case AppointmentsStatusEnum.realizado:
                      case AppointmentsStatusEnum.naoRealizado:
                        Get.toNamed(Routes.finishedSelectDay);
                        break;
                      case AppointmentsStatusEnum.cancelado:
                        Get.toNamed(Routes.canceledSelectDay);
                        break;
                      case AppointmentsStatusEnum.aguardandoReagendamento:
                        Get.toNamed(Routes.reappoinmentSelectDay);
                        break;
                      default:
                    }
                  } else {
                    SnackbarCustom.snackbarError(
                        'Não foi possível obter os registros');
                  }
                },
                mainButtonTitle: status.name!,
                quantity: status.quantity!,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class AppointmentTypeWidget extends StatelessWidget {
  const AppointmentTypeWidget({
    super.key,
    required this.onTap,
    required this.mainButtonTitle,
    required this.quantity,
  });

  final VoidCallback onTap;
  final String mainButtonTitle;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButtonWidget(
            onTap: onTap,
            titleButtom: mainButtonTitle,
          ),
        ),
        16.widthGap,
        Container(
          width: 72,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.midBlackColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            quantity.toStringAsFixed(0),
            style: Fonts.titleMedium(context),
          ).toCenter,
        )
      ],
    ).paddingOnly(bottom: 24);
  }
}
