import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectHoursToPublishPage extends StatefulWidget {
  const SelectHoursToPublishPage({super.key});

  @override
  State<SelectHoursToPublishPage> createState() =>
      _SelectHoursToPublishPageState();
}

class _SelectHoursToPublishPageState extends State<SelectHoursToPublishPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Divulgar agenda',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<PublishAgendaController>(builder: (pbAgenda) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            SpecialistCard(
              specialist: SpecialistResponseModel(),
              isSelected: true,
              crmNumber: pbAgenda.selectedSpecialist!.doctor!.crmNumber,
              specialty: pbAgenda.selectedSpecialist!.specialtyName,
              fullName: pbAgenda.selectedSpecialist!.doctor!.fullName,
              price: pbAgenda.selectedSpecialist!.price.toString(),
              clinicName: pbAgenda.selectedSpecialist!.clinic!.fullName,
            ),
            15.heightGap,
            Text(
              'Selecione um ou mais horários para sua agenda:',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            AppointmentRichText(
              title: 'Dia(s) selecionado(s) para divulgação da agenda',
              content: pbAgenda.selectedDays
                  .map((e) => e.day.formatDateShort())
                  .join(' | '),
            ),
            24.heightGap,
            Form(
              key: formKey,
              child: Column(
                children: [
                  HourInput(controller: pbAgenda.hourController),
                  DropdownStandard(
                    controller: pbAgenda.scheduleTypeController,
                    listOptions:
                        pbAgenda.typeSchedules.map((e) => e.name!).toList(),
                    hintText: 'Ex.: On-line',
                    labelText: 'Tipo da Consulta',
                    onChanged: (val) {
                      pbAgenda.setScheduleTypeController(val!);
                    },
                    validator: ValidatorsCustom.typeScheduleValidator,
                  ),
                ],
              ),
            ),
            10.heightGap,
            GetBuilder<PublishAgendaController>(
              builder: (_) {
                return PriceInput(
                  label: 'Valor da consulta (opcional)',
                  controller: pbAgenda.priceController,
                  onChanged: (p0) {
                    if (pbAgenda.returnNumber(p0.replaceAll('R\$', '')) ==
                        0.00) {
                      pbAgenda.clearPrice();
                    }
                  },
                );
              },
            ),
            10.heightGap,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await pbAgenda.checkHour(
                      PublishHours(
                        hour: pbAgenda.hourController.text,
                        typeScheduleId: pbAgenda.getScheduleTypeId(
                            pbAgenda.scheduleTypeController.text),
                        price:
                            pbAgenda.checkPrice(pbAgenda.priceController.text)
                                ? pbAgenda
                                    .returnNumber(pbAgenda.priceController.text)
                                : pbAgenda.selectedSpecialist!.price!,
                      ),
                    );
                  }
                },
                child: const Text('Adicionar horário'),
              ),
            ),
            const Divider().paddingSymmetric(vertical: 10),
            if (pbAgenda.publisListHours.isNotEmpty) ...[
              Text(
                'Horas criadas',
                style: Fonts.titleLarge(context),
              ),
              Text(
                'As horas serão replicadas nos dias selecionados',
                style: Fonts.bodyMedium(context),
              ),
              20.heightGap,
              ...pbAgenda.publisListHours.map(
                (hour) => HoursCreated(
                  hour: hour.hour!,
                  scheduleType:
                      pbAgenda.getScheduleTypeName(hour.typeScheduleId!),
                  price: hour.price!,
                  onDelete: () {
                    CustomDialogs.confirmDialog(
                      title: 'Deseja realmente remover este horário?',
                      backAcion: () => Get.back(),
                      confirmAcion: () {
                        pbAgenda.removeHourToPublish(hour);
                        Get.back();
                      },
                      context: context,
                      backVisible: true,
                    );
                  },
                ),
              ),
            ],
            20.heightGap,
            PrimaryButtonWidget(
              isLoading: pbAgenda.isLoadingCreate.value,
              onTap: pbAgenda.publisListHours.isEmpty
                  ? null
                  : () async {
                      final result = await pbAgenda.postPublishAgenda();
                      if (result) {
                        Get.offAllNamed(Routes.publishSelectConclusion);
                      }
                    },
              titleButtom: 'Publicar agenda',
            ),
            20.heightGap,
          ],
        );
      }),
    );
  }
}

class HoursCreated extends StatelessWidget {
  const HoursCreated(
      {super.key,
      required this.hour,
      required this.scheduleType,
      required this.price,
      required this.onDelete});

  final String hour;
  final String scheduleType;
  final double price;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(50),
              boxShadow: highElevation,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hour, style: Fonts.titleMedium(Get.context!).copyWith()),
                Text(scheduleType,
                    style: Fonts.bodyLarge(Get.context!).copyWith(
                      overflow: TextOverflow.ellipsis,
                    )),
                Text(
                  price.formatReal(),
                  style: Fonts.titleMedium(Get.context!).copyWith(height: 0.8),
                ),
              ],
            ),
          ).paddingOnly(bottom: 10),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onDelete,
          icon: const FaIcon(
            FontAwesomeIcons.trashCan,
            size: 24,
            color: AppColors.redColor,
          ),
        ).paddingSymmetric(horizontal: 6).toCenter
      ],
    );
  }
}

class HourCreatedDemonstration extends StatelessWidget {
  const HourCreatedDemonstration({
    super.key,
    required this.hour,
    required this.scheduleType,
    required this.price,
  });

  final String hour;
  final String scheduleType;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(50),
        boxShadow: highElevation,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hour, style: Fonts.titleMedium(Get.context!).copyWith()),
          Text(scheduleType,
              style: Fonts.bodyLarge(Get.context!).copyWith(
                overflow: TextOverflow.ellipsis,
              )),
          Text(
            price.formatReal(),
            style: Fonts.titleMedium(Get.context!).copyWith(height: 0.8),
          ),
        ],
      ),
    ).paddingOnly(bottom: 10);
  }
}
