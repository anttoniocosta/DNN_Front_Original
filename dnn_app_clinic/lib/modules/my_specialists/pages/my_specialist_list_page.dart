import 'package:dnn_app_clinic/core/clinic/controller/my_specialists_controller.dart';
import 'package:dnn_app_clinic/core/clinic/controller/update_specialist.dart';
import 'package:dnn_app_clinic/modules/my_specialists/pages/specialist_update_data.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class MySpecialistsListPage extends StatelessWidget {
  const MySpecialistsListPage({super.key});
  Widget? _leading() {
    if (Get.currentRoute == Routes.basePage) return const MenuButtom();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySpecialistsController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.isLoadingSpecialists.value || _.specialistList.isEmpty,
          needScrollView:
              _.specialistList.isNotEmpty || _.isLoadingSpecialists.value,
          title: 'Meus especialistas',
          appBarLeading: _leading(),
          maxWidth: Responsive.maxWidth(),
          onRefresh: () => _.getMySpecialists(),
          bodyChild: GetBuilder<MySpecialistsController>(
            builder: (_) {
              if (_.isLoadingSpecialists.value) {
                return const PageLoadingWidget();
              }
              if (_.specialistList.isEmpty) {
                return Column(
                  children: [
                    EmptyPageWidget(
                      title: 'Você ainda não possui especialistas cadastrados',
                      complementWidget: PrimaryButtonWidget(
                        onTap: () => Get.toNamed(Routes.addSpecialistInfos),
                        titleButtom: 'Adicionar novo',
                      ).paddingSymmetric(vertical: 20),
                    )
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryButtonWidget(
                    onTap: () => Get.toNamed(Routes.addSpecialistInfos),
                    titleButtom: 'Adicionar novo',
                  ).paddingSymmetric(vertical: 20),
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
                      (e) => GetBuilder<UpdateSpecialistController>(
                          builder: (update) {
                        return SpecialistCard(
                          onTap: () {
                            update.setSpecialist(e);
                            update.setDataToUpdate();
                            Get.to(
                              () => const SpecialistUpdateData(),
                              transition: Transition.cupertino,
                            );
                          },
                          specialist: e,
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
          ),
        );
      },
    );
  }
}
