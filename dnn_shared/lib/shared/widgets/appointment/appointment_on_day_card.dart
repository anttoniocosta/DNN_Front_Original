import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AppointmentWithOneActionCard extends StatelessWidget {
  const AppointmentWithOneActionCard({
    super.key,
    required this.hour,
    required this.centerText,
    required this.onTap,
    required this.buttonTitle,
    this.model,
  });

  final String hour;
  final String centerText;
  final VoidCallback onTap;
  final String buttonTitle;
  final MyAppointmentsResponseModel? model;

  @override
  Widget build(BuildContext context) {
    return AppointmentBaseCard(
      hour: hour,
      centerText: centerText,
      contentAfter: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(buttonTitle),
        ).paddingOnly(top: 16),
      ),
      model: model!,
    );
  }
}

class AppointmentWithNoActionCard extends StatelessWidget {
  const AppointmentWithNoActionCard({
    super.key,
    required this.hour,
    required this.centerText,
    this.model,
  });

  final String hour;
  final String centerText;
  final MyAppointmentsResponseModel? model;

  @override
  Widget build(BuildContext context) {
    return AppointmentBaseCard(
      hour: hour,
      centerText: centerText,
      model: model!,
    );
  }
}

class AppointmentForReappointmentCard extends StatelessWidget {
  const AppointmentForReappointmentCard({
    super.key,
    required this.hour,
    required this.centerText,
    required this.onCancel,
    required this.onReappointment,
    this.model,
  });

  final String hour;
  final String centerText;
  final VoidCallback onCancel;
  final VoidCallback onReappointment;
  final MyAppointmentsResponseModel? model;

  @override
  Widget build(BuildContext context) {
    return AppointmentBaseCard(
      hour: hour,
      centerText: centerText,
      contentAfter: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              child: const Text('Cancelar'),
            ),
          ),
          10.widthGap,
          Expanded(
            child: ElevatedButton(
              onPressed: onReappointment,
              child: const Text('Reagendar'),
            ),
          ),
        ],
      ).paddingOnly(top: 16),
      model: model!,
    );
  }
}

class AppointmentWithStatusCard extends StatelessWidget {
  const AppointmentWithStatusCard({
    super.key,
    required this.hour,
    required this.centerText,
    this.model,
    this.titleText = '',
    this.contentText = '',
  });

  final String hour;
  final String centerText;
  final MyAppointmentsResponseModel? model;
  final String? titleText;
  final String? contentText;

  @override
  Widget build(BuildContext context) {
    return AppointmentBaseCard(
      hour: hour,
      centerText: centerText,
      contentBefore: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText!,
            style: Fonts.headlineMedium(context),
          ),
          8.heightGap,
          Row(
            children: [
              const FaIcon(FontAwesomeIcons.circleExclamation),
              10.widthGap,
              Text(
                contentText!,
                style: Fonts.bodyLarge(context),
              ),
            ],
          ),
          16.heightGap,
        ],
      ),
      model: model!,
    );
  }
}

class AppointmentBaseCard extends StatefulWidget {
  const AppointmentBaseCard({
    super.key,
    required this.hour,
    required this.centerText,
    this.contentBefore = const SizedBox(),
    this.contentAfter = const SizedBox(),
    this.model,
  });

  final String hour;
  final String centerText;
  final Widget? contentBefore;
  final Widget? contentAfter;
  final MyAppointmentsResponseModel? model;
  @override
  State<AppointmentBaseCard> createState() => _AppointmentBaseCardState();
}

class _AppointmentBaseCardState extends State<AppointmentBaseCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 62, 16, 24),
          decoration: BoxDecoration(
            color: AppColors.containerColor(),
            boxShadow: highElevationTwo,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.contentBefore!,
              _ClientDetails(widget.model!),
              widget.contentAfter!,
            ],
          ),
        ).paddingOnly(bottom: 20),
        AvaiableHourTile(
          centerText: widget.centerText,
          hour: widget.hour,
          price: widget.model!.price!,
          isSelected: true,
        ),
      ],
    );
  }
}

class _ClientDetails extends StatelessWidget {
  const _ClientDetails(this.model);

  final MyAppointmentsResponseModel model;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Dados do paciente', style: Fonts.headlineMedium(context)),
      10.heightGap,
      AppointmentRichText(
        title: 'Nome',
        content: model.patient!.name!.capitalize!,
      ),
      AppointmentRichText(
        title: 'CPF',
        content: model.patient!.document!.formatDocument(),
      ),
      AppointmentRichText(
        title: 'Data de Nascimento',
        content: model.patient!.birthday!.formatDateFromIso(),
      ),
      AppointmentRichText(
        title: 'Celular',
        content: model.patient!.phoneNumber!.formatPhone(),
      ),
      AppointmentRichText(
          title: 'E-mail', content: model.patient!.email!.toLowerCase()),
      10.heightGap,
      Text(
        'Endereço',
        style: Fonts.titleMedium(context),
      ),
      10.heightGap,
      AppointmentRichText(
          title: 'CEP', content: model.patient!.zipcode!.formatZipCode()),
      AppointmentRichText(title: 'Rua', content: model.patient!.address!),
      AppointmentRichText(title: 'N°', content: model.patient!.number!),
      if (model.patient!.complement != null)
        AppointmentRichText(
          title: 'Complemento',
          content: model.patient!.complement!,
        ),
      AppointmentRichText(
        title: 'Bairro',
        content: model.patient!.neighborhood!,
      ),
      AppointmentRichText(title: 'UF', content: model.patient!.state!),
      AppointmentRichText(title: 'Cidade', content: model.patient!.city!),
    ]);
  }
}
