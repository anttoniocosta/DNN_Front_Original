import 'package:dnn_app_clinic/core/clinic/controller/my_specialists_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistsSelectSpecialtyPage extends StatefulWidget {
  const SpecialistsSelectSpecialtyPage({super.key});

  @override
  State<SpecialistsSelectSpecialtyPage> createState() =>
      _SpecialistsSelectSpecialtyPageState();
}

class _SpecialistsSelectSpecialtyPageState
    extends State<SpecialistsSelectSpecialtyPage> {
  List<String> specialties = ["Alergista", "Cardiologista", "Clínico Geral"];
  String specialty = '';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySpecialistsController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.isLoadingSpecialty.value,
          needScrollView: _.specialtyList.isNotEmpty,
          title: 'Meus especialistas',
          maxWidth: Responsive.maxWidth(),
          onRefresh: () => _.getSpecialties(),
          bodyChild: GetBuilder<MySpecialistsController>(
            builder: (_) {
              if (_.isLoadingSpecialty.value) {
                return const PageLoadingWidget();
              }

              if (_.specialtyList.isEmpty) {
                return TryAgainPage(
                  message:
                      'Não foi possível recuparar os dados das especialidades',
                  onTryAgain: () => _.getSpecialties(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightGap,
                  Text(
                    'Selecione a especialidade',
                    style: Fonts.headlineMedium(context),
                  ),
                  10.heightGap,
                  CustomSearchBar(
                    controller: _.filterSpecialty,
                    hintText: 'Filtre pelo nome do especialidade',
                    onChanged: (value) {
                      _.filterSpecialtyList(value);
                    },
                  ),
                  24.heightGap,
                  if (_.specialtyFilteredList.isNotEmpty) ...[
                    ..._.specialtyFilteredList.map(
                      (x) => SearchTileSelection(
                        onTap: () => setState(() {
                          if (_.selectedSpecialty == x) {
                            _.setSpecialtySelected(null);
                          } else {
                            _.setSpecialtySelected(x);
                          }
                        }),
                        title: x.name!,
                        isSelected: _.selectedSpecialty == x,
                      ),
                    ),
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
          bottomNavigationBar: Visibility(
            visible: _.specialtyFilteredList.isNotEmpty ||
                _.isLoadingSpecialty.value,
            child: BottomConfirmButton(
              onTap: _.selectedSpecialty == null
                  ? null
                  : () => Get.toNamed(Routes.addSpecialistPrice),
              title: 'Continuar',
            ),
          ),
        );
      },
    );
  }
}
