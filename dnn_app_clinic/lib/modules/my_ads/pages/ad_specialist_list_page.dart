import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AdSpecialistListPage extends StatelessWidget {
  const AdSpecialistListPage({super.key});

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
              !_.specialistList.isNotEmpty || _.isLoadingSpecialists.value,
          appBarLeading: _leading(),
          title: 'Meus anuncios',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () => _.getMySpecialists(),
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
                    (e) => GetBuilder<MyAdsController>(builder: (myAds) {
                      return SpecialistCard(
                        onTap: () async {
                          myAds.clear();
                          myAds.setSpecialistSelected(e);
                          final result =
                              await myAds.getSchedulesFromSpecialistId();
                          if (result) {
                            if (myAds.specialistAgenda!.dates!.isNotEmpty) {
                              Get.toNamed(Routes.adSelectDay);
                            } else {
                              SnackbarCustom.snackbarError(
                                  'Este especialista não possui agenda no momento');
                            }
                          }
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
          }),
        );
      },
    );
  }
}
