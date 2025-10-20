import 'package:dnn_app_clinic/core/clinic/controller/publish_agenda_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SelectDaysToPublishPage extends StatefulWidget {
  const SelectDaysToPublishPage({super.key});

  @override
  State<SelectDaysToPublishPage> createState() =>
      _SelectDaysToPublishPageState();
}

class _SelectDaysToPublishPageState extends State<SelectDaysToPublishPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublishAgendaController>(builder: (pbAgenda) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        title:
            'Divulgar ${pbAgenda.isReadyService ? 'Pronto Atendimento' : 'Agenda'}',
        maxWidth: Responsive.maxWidth(),
        bodyChild: GetBuilder<PublishAgendaController>(
          builder: (pbAgenda) {
            if (pbAgenda.isReadyService) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightGap,
                  PlantonistCard(
                    isSelected: true,
                    onTap: null,
                    specialty: pbAgenda.selectedSpecialist!.specialtyName!,
                    price: pbAgenda.selectedSpecialist!.price.toString(),
                  ),
                  30.heightGap,
                  Text(
                    'Agora, a clínica tem a opção de destacar o pronto atendimento para uma especialidade específica. Ao realizar o cadastro, a clínica pode inserir as informações desejadas, incluindo a opção de preencher ou não o campo de preço. Após o preenchimento, confirme para manter essa informação atualizada. Agradecemos por fornecer detalhes relevantes sobre os serviços oferecidos.',
                    style: Fonts.bodyLarge(context),
                  ),
                  50.heightGap,
                  Form(
                    key: formKey,
                    child: PriceInput(
                      label: 'Valor da consulta',
                      controller: pbAgenda.priceController,
                      onChanged: (p0) {
                        if (pbAgenda.returnNumber(p0.replaceAll('R\$', '')) ==
                            0.00) {
                          pbAgenda.clearPrice();
                        }
                      },
                    ),
                  ),
                ],
              );
            }
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
                24.heightGap,
                Text(
                  'Selecione um ou mais dias para agendamento:',
                  style: Fonts.headlineMedium(context),
                ),
                24.heightGap,
                CalendarTableCustom(
                  markerBuilder: (_, day, list) {
                    return SelectDayCalendarCell(
                      day: day,
                      isSelected: pbAgenda.containsThisDay(day),
                      onTap: () => pbAgenda.setSelectedDays(day),
                    );
                  },
                  focusedDay: pbAgenda.selectedDays.isEmpty
                      ? DateTime.now()
                      : pbAgenda.selectedDays.last.day,
                ),
                30.heightGap,
                PrimaryButtonWidget(
                  isLoading: pbAgenda.isLoadingCreate.value,
                  onTap: pbAgenda.selectedDays.isEmpty
                      ? null
                      : () async {
                          Get.toNamed(Routes.publishSelectHour);
                        },
                  titleButtom: 'Continuar',
                ),
                24.heightGap,
              ],
            );
          },
        ),
        bottomNavigationBar: pbAgenda.isReadyService
            ? BottomConfirmButton(
                isLoading: pbAgenda.isLoadingCreate.value,
                onTap: () async {
                  if (pbAgenda.priceController.text.isNotEmpty) {
                    pbAgenda.setScheduleTypeController('Online');
                    final result = await pbAgenda.postPublishAgenda();
                    if (result) {
                      Get.offAllNamed(Routes.publishSelectConclusion);
                    }
                  } else {
                    SnackbarCustom.snackbarError(
                      'Digite o valor da consulta para um pronto atendimento.',
                    );
                  }
                },
                title: 'Continuar',
              )
            : const SizedBox(),
      );
    });
  }
}
