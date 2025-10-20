import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class AppointmentCityFilterPage extends StatelessWidget {
  const AppointmentCityFilterPage({super.key});

  _text(String text) {
    return Text(
      text,
      style: Fonts.bodyLarge(Get.context!).copyWith(
        fontSize: 16,
        fontWeight: Fonts.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Agendar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<ScheduleController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.heightGap,
            Text(
              'Pesquisar por:',
              style: Fonts.headlineMedium(context).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            24.heightGap,
            CustomSearchBar(
              hintText: 'Filtre pelo nome da cidade desejada',
              controller: _.filterCity,
              onChanged: (val) {
                _.filterCityList(val);
              },
            ),
            20.heightGap,
            if (_.cityListFiltered.isNotEmpty) ...[
              ..._.cityListFiltered.map(
                (e) => SearchResultTile(
                    onTap: () {
                      _.setCity(e);
                      Get.back();
                    },
                    child: _text(e)),
              )
            ] else if (_.cityList.isEmpty) ...[
              Text(
                'Sem items...',
                style: Fonts.titleLarge(context),
              )
            ] else ...[
              Text(
                'Sem resultados para a sua pesquisa...',
                style: Fonts.titleLarge(context),
              )
            ],
            20.heightGap,
          ],
        );
      }),
    );
  }
}
