import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class MyAppointmentCard extends StatefulWidget {
  const MyAppointmentCard({
    super.key,
    this.isSelected = false,
    this.onTap,
    this.needBottomButtons = true,
    this.needStartAppointment = false,
    this.onCancel,
    this.onReappoint,
    this.onStart,
    required this.model,
    this.startButtonText,
  });

  final bool? isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onReappoint;
  final VoidCallback? onStart;
  final bool? needBottomButtons;
  final bool? needStartAppointment;
  final MyAppointmentsResponseModel model;
  final String? startButtonText;

  @override
  State<MyAppointmentCard> createState() => _MyAppointmentCardState();
}

class _MyAppointmentCardState extends State<MyAppointmentCard> {
  String differencee = '';
  bool canStartAppointment() {
    DateTime? dateScheduled = DateTime.tryParse(widget.model.dateSchedule!);
    DateTime agora = DateTime.now();
    agora.add(const Duration(hours: -3));
    if (dateScheduled != null) {
      final difference = dateScheduled.difference(agora);
      differencee = difference.inMinutes.toString();
      return difference.inMinutes >= -10 && difference.inMinutes <= 10;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: widget.isSelected == true ? null : widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: _handleColor(),
            borderRadius: BorderRadius.circular(20),
            boxShadow: highElevation + highElevationTwo,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        MediaRes.doctorIcon,
                        width: 50,
                        height: 50,
                      ).paddingOnly(right: 16),
                      SpecialistHeaderInfos(
                        isSelected: widget.isSelected,
                        crm: widget.model.doctor!.crm ?? '',
                        specialty: widget.model.specialtyName!.capitalize ?? '',
                        name: widget.model.doctor!.name!.capitalize ?? '',
                      ),
                    ],
                  ),
                  widget.model.isPayment! == true
                      ? const Icon(Icons.check_circle,
                          color: AppColors.successColor, size: 30)
                      : const SizedBox(),
                ],
              ),
              AppointmentDivider(isSelected: widget.isSelected),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   widget.model.clinic!.name!.capitalize!,
                        //   style: Fonts.titleLarge(context).copyWith(
                        //     color: widget.isSelected == true
                        //         ? AppColors.whiteColor
                        //         : null,
                        //   ),
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        // AppointmentRichText(
                        //     title: 'Data',
                        //     content:
                        //         widget.model.dateSchedule!.formatDateFromIso(),
                        //     isSelected: widget.isSelected!),
                        AppointmentRichText(
                            title: 'Hora',
                            content: widget.model.dateSchedule!
                                .formartHourFromDateIso(),
                            isSelected: widget.isSelected!),
                        AppointmentRichText(
                            title: 'Valor da Consulta',
                            content: widget.model.price!.formatReal(),
                            isSelected: widget.isSelected!),
                        AppointmentRichText(
                            title: 'Tipo de consulta',
                            content: widget.model.typeScheduleName!.capitalize!,
                            isSelected: widget.isSelected!),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 16),
              if (widget.model.typeScheduleName!.capitalize! != 'Online')
                AppointmentDivider(isSelected: widget.isSelected),
              if (widget.model.typeScheduleName!.capitalize! != 'Online')
                ClinicAddressInfos(
                  isSelected: widget.isSelected,
                  street: widget.model.clinic!.address!,
                  neighborhood: widget.model.clinic!.neighborhood!,
                  city: widget.model.clinic!.city!,
                  state: widget.model.clinic!.state!,
                  zipCode: widget.model.clinic!.zipcode!,
                  number: widget.model.clinic!.number!,
                ),
              if (canStartAppointment())
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButtonWidget(
                        onTap: widget.onStart,
                        titleButtom: 'Iniciar Consulta',
                      ),
                    ),
                  ],
                ),
              if (canStartAppointment()) 10.heightGap,
              if (widget.needBottomButtons!) 12.heightGap,
              if (widget.needBottomButtons!)
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButtonWidget(
                        onTap: widget.onCancel,
                        titleButtom: 'Cancelar',
                      ),
                    ),
                  ],
                ),
              if (!widget.model.isPayment!) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.circleInfo,
                      color: AppColors.redColor,
                    ),
                    10.widthGap,
                    Expanded(
                      child: Text(
                        widget.model.paymentStateName?.capitalizeFirst ??
                            'Pagamento em análise',
                        style: Fonts.titleLarge(context).copyWith(height: .8),
                      ),
                    )
                  ],
                ).paddingOnly(top: 20)
              ],
              if (widget.needStartAppointment! && widget.model.isPayment!) ...[
                Visibility(
                  visible: canStartAppointment(),
                  replacement: Text(
                    'O atendimento estará liberado 10 minutos antes do horário agendado, fique atento!',
                    style: Fonts.bodyLarge(context),
                    textAlign: TextAlign.center,
                  ).paddingOnly(top: 20),
                  child: PrimaryButtonWidget(
                    onTap: widget.onStart,
                    titleButtom:
                        widget.startButtonText ?? 'Iniciar atendimento',
                  ).paddingOnly(top: 10),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  _handleColor() {
    if (widget.isSelected == true) {
      return AppColors.blackDarkColor;
    }

    if (Get.isDarkMode) {
      if (widget.model.isPayment! == true) {
        return AppColors.successDarkBackgroundCardColor;
      }

      return AppColors.lighterblackLightColor;
    }

    if (widget.model.isPayment! == true) {
      return AppColors.successBackgroundCardColor;
    }

    return AppColors.whiteColor;
  }
}
