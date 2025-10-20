import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

// import 'partials/clinica_partial.dart';
// import 'partials/specialist_partial.dart';
// import 'partials/specialty_partial.dart';

class AppointmentGeneralFiltersPage extends StatefulWidget {
  const AppointmentGeneralFiltersPage({super.key});

  @override
  State<AppointmentGeneralFiltersPage> createState() =>
      _AppointmentGeneralFiltersPageState();
}

class _AppointmentGeneralFiltersPageState
    extends State<AppointmentGeneralFiltersPage> {
  int currentIndex = 0;

  // static List<FilterChipsModel> chipList = [
  //   FilterChipsModel(index: 0, title: 'Clínica'),
  //   FilterChipsModel(index: 1, title: 'Especialista'),
  //   FilterChipsModel(index: 2, title: 'Especialidade'),
  // ];

  // final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Agendar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SingleChildScrollView(
          //   controller: scrollController,
          //   scrollDirection: Axis.horizontal,
          //   clipBehavior: Clip.none,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: chipList
          //         .map(
          //           (e) => FilterChipsCustom(
          //             index: currentIndex,
          //             chip: e,
          //             onTap: () {
          //               setState(() => currentIndex = e.index);
          //             },
          //           ).paddingOnly(right: 10),
          //         )
          //         .toList(),
          //   ),
          // ).paddingOnly(left: 20),
          // 10.heightGap,
          GetBuilder<ScheduleController>(
            builder: (_) {
              if (!_.isOnline) {
                return FilterChipCityCustom(
                  title: _.selectedCity,
                  onTap: () => Get.toNamed(Routes.scheduleCityFilter),
                  onDelete: () => _.setCity('Todos'),
                ).paddingOnly(bottom: 21);
              } else {
                return const SizedBox();
              }
            },
          ),

          const SpecialtyFilterPartial(),
        ],
      ),
    );
  }
}
