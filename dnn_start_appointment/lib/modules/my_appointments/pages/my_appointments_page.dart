import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';

class MyAppointmentsPage extends StatefulWidget {
  final bool showAppBar;
  const MyAppointmentsPage({
    super.key,
    this.showAppBar = true,
  });

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  int currentIndex = 0;

  static List<FilterChipsModel> chipMyAppointmentList = [
    FilterChipsModel(index: 0, title: 'Consultas Agendadas'),
    FilterChipsModel(index: 1, title: 'Consultas Realizadas'),
    FilterChipsModel(index: 2, title: 'Consultas Canceladas'),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentsController>(builder: (_) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        needAppBar: widget.showAppBar,
        title: 'Minhas consultas',
        maxWidth: Responsive.maxWidth(),
        onRefresh: () => _.getMyAppointments(),
        bodyChild:
            GetBuilder<MyAppointmentsController>(builder: (myAppointments) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              20.heightGap,
              SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: chipMyAppointmentList
                      .map(
                        (e) => FilterChipsCustom(
                          index: currentIndex,
                          chip: e,
                          onTap: () {
                            setState(() {
                              currentIndex = e.index;
                            });
                          },
                        ).paddingOnly(right: 10),
                      )
                      .toList(),
                ),
              ),
              24.heightGap,
              if (currentIndex == 0)
                AppoitmentList(
                  list: myAppointments.myAppointmets
                      .where(
                        (x) =>
                            (x.dateCancel == null && x.dateFinished == null) ||
                            x.paymentStateName == "Aguardando pagamento",
                      )
                      .toList(),
                  needBottomButtons: true,
                  listEmptyText: 'Sem consultas agendadas \nno momento',
                ),
              if (currentIndex == 1)
                AppoitmentList(
                  list: myAppointments.myAppointmets
                      .where(
                          (x) => x.dateFinished != null && x.dateCancel == null)
                      .toList(),
                  needBottomButtons: false,
                  listEmptyText: 'Sem consultas realizadas \nno momento',
                ),
              if (currentIndex == 2)
                AppoitmentList(
                  list: myAppointments.myAppointmets
                      .where((x) =>
                          (x.dateCancel != null ||
                              x.dateCancelConfirm != null) &&
                          x.paymentStateName != "Aguardando pagamento")
                      .toList(),
                  needBottomButtons: false,
                  listEmptyText: 'Sem consultas canceladas \nno momento',
                ),
              60.heightGap
            ],
          );
        }),
        bottomSheet: CustomBottomNavigation(
          navItens: [
            const CustomBottomItem(
              isBackPage: true,
              icon: MediaRes.stetoscpIcon,
              index: NavigationTabs.myAppointmentsLogged,
            ),
            10.heightGap,
            const CustomBottomItem(
              isBackPage: true,
              icon: MediaRes.homeIcon,
              index: NavigationTabs.homeLogged,
            ),
            10.heightGap,
            const CustomBottomItem(
              isBackPage: true,
              icon: MediaRes.malletIcon,
              index: NavigationTabs.myPlansLogged,
            ),
          ],
        ),
      );
    });
  }
}

class AppoitmentList extends StatelessWidget {
  const AppoitmentList({
    super.key,
    required this.list,
    this.needBottomButtons = true,
    required this.listEmptyText,
  });

  final List<MyAppointmentsResponseModel> list;

  final bool? needBottomButtons;
  final String listEmptyText;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return NoContractInformation(
          title: listEmptyText, imageAsset: MediaRes.minhasConsultas);
    }
    return Column(
      children: list.map((model) {
        return GetBuilder<MyAppointmentsController>(
          builder: (_) {
            return MyAppointmentCard(
              model: model,
              onStart: () async => await _.startStandardAppointment(model.id!),
              onReappoint: () => Get.toNamed(Routes.myAppointmentsReappoint),
              onCancel: () {
                _.clear();
                _.setAppointment(model);
                Get.toNamed(Routes.myAppointmentsCancel);
              },
              needBottomButtons: needBottomButtons,
            ).paddingOnly(bottom: 10);
          },
        );
      }).toList(),
    );
  }
}
