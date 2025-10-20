import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AgendaSpecialistListPage extends StatelessWidget {
  const AgendaSpecialistListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySpecialistsController>(
      builder: (_) {
        return GetBuilder<PublishAgendaController>(builder: (pbAgenda) {
          return MobileLayout(
            needCenter:
                _.isLoadingSpecialists.value || _.specialistList.isEmpty,
            needScrollView:
                _.specialistList.isNotEmpty || _.isLoadingSpecialists.value,
            title:
                'Divulgar ${pbAgenda.isReadyService ? 'Pronto Atendimento' : 'Agenda'}',
            maxWidth: Responsive.maxWidth(),
            bodyChild: GetBuilder<MySpecialistsController>(builder: (_) {
              if (_.isLoadingSpecialists.value) {
                return const PageLoadingWidget();
              }
              if (_.specialistList.isEmpty) {
                return TryAgainPage(
                  message: 'Você ainda não possui especialistas cadastrados',
                  onTryAgain: () => _.getMySpecialists(),
                );
              }
              return GetBuilder<PublishAgendaController>(
                builder: (pbAgenda) {
                  if (pbAgenda.isReadyService) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        10.heightGap,
                        Text(
                          'Selecione a especialidade para divulgar o pronto atendimento:',
                          style: Fonts.headlineMedium(context),
                        ),
                        24.heightGap,
                        ..._.plantonistFilteredList.map(
                          (e) => GetBuilder<PublishAgendaController>(
                              builder: (pbAgenda) {
                            return PlantonistCard(
                              onTap: () {
                                pbAgenda.clearPlantonista();
                                pbAgenda.setSpecialistSelected(e);
                                Get.toNamed(Routes.publishSelectDay);
                              },
                              specialty: e.specialtyName!,
                              price: e.price.toString(),
                            ).paddingOnly(bottom: 12);
                          }),
                        )
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.heightGap,
                      Text(
                        'Selecione o especialista',
                        style: Fonts.headlineMedium(context),
                      ),
                      10.heightGap,
                      CustomSearchBar(
                        controller: _.filterSpecialist,
                        hintText: 'Filtre pelo nome do especialista',
                        onChanged: (value) {
                          _.filterSpecialistList(value);
                        },
                      ),
                      24.heightGap,
                      if (_.specialistFilteredList.isNotEmpty) ...[
                        ..._.specialistFilteredList.map(
                          (e) => GetBuilder<PublishAgendaController>(
                              builder: (pbAgenda) {
                            return SpecialistCard(
                              onTap: () {
                                pbAgenda.clear();
                                pbAgenda.clearHour();
                                pbAgenda.setSpecialistSelected(e);
                                Get.toNamed(Routes.publishSelectDay);
                              },
                              crmNumber: e.doctor!.crmNumber,
                              specialty: e.specialtyName,
                              fullName: e.doctor!.fullName,
                              price: e.price.toString(),
                              clinicName: e.clinic!.fullName,
                            ).paddingOnly(bottom: 12);
                          }),
                        )
                      ] else ...[
                        Text(
                          'Sem resultados para a sua pesquisa...',
                          style: Fonts.titleLarge(context),
                        )
                      ]
                    ],
                  );
                },
              );
            }),
          );
        });
      },
    );
  }
}
