import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class MyAppointmentsRapidocPage extends StatefulWidget {
  const MyAppointmentsRapidocPage({super.key});

  @override
  State<MyAppointmentsRapidocPage> createState() =>
      _MyAppointmentsRapidocPageState();
}

class _MyAppointmentsRapidocPageState extends State<MyAppointmentsRapidocPage> {
  int currentIndex = 0;

  final scrollController = ScrollController();

  static List<FilterChipsModel> chipMyAppointmentList = [
    FilterChipsModel(index: 0, title: 'Realizadas'),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoicesController>(initState: (val) {
      Future.delayed(
        const Duration(milliseconds: 10),
        () {
          val.controller!.getInvoicesServices();
        },
      );
    }, builder: (_) {
      return MobileLayout(
        needCenter:
            _.getInvoicesServicesLoading.value || _.invoicesServices.isEmpty,
        needScrollView: true,
        title: 'Minhas consultas',
        maxWidth: Responsive.maxWidth(),
        bodyChild: GetBuilder<InvoicesController>(builder: (_) {
          if (_.getInvoicesServicesLoading.value) {
            return const PageLoadingWidget();
          }
          if (_.invoicesServices.isEmpty) {
            return TryAgainPage(
              message:
                  'Aparentemente você não possui um histórico de consultas.',
              onTryAgain: () => _.getInvoicesServices(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              20.heightGap,
              SingleChildScrollView(
                controller: scrollController,
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

              ..._.invoicesServices
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColors.midBlackColor
                              : AppColors.blackDarkColor,
                          borderRadius: BorderRadius.circular(16)),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? AppColors.blackLightColor
                                  : AppColors.whiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.laptopMedical,
                              color: Get.isDarkMode
                                  ? AppColors.whiteColor
                                  : AppColors.blueColor,
                              size: Responsive.doubleSizes(
                                  mobile: 28, tablet: 28, desktop: 28),
                            ),
                          ),
                          10.widthGap,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.fullname!.capitalize!,
                                  style: Fonts.headlineMedium(context).copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                10.heightGap,
                                _richText(
                                  context,
                                  title: 'Data:',
                                  content:
                                      e.finishedDate?.formatDateFromIso() ??
                                          e.createDate!.formatDateFromIso(),
                                ),
                                _richText(
                                  context,
                                  title: 'Tipo de consulta:',
                                  content: 'Online',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).paddingOnly(bottom: 16),
                  )
                  .toList(),

              // MyAppointmentCard(
              //   clinicModel: ClinicViewModel.test(),
              //   specialist:  SpecialistResponseModel(),
              //   onReappoint: () => Get.to(() => const ReAppointmentPage()),
              //   onCancel: () => Get.to(() => const CancelAppointmentPage()),
              //   needBottomButtons: true,
              // ),
              16.heightGap,
            ],
          );
        }),
      );
    });
  }

  Text _richText(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text: '$title ',
          style: Fonts.bodyLarge(context)
              .copyWith(color: AppColors.whiteColor, fontSize: 14),
        ),
        TextSpan(
          text: content,
          style: Fonts.titleSmall(context)
              .copyWith(color: AppColors.whiteColor, fontSize: 14),
        )
      ],
    ));
  }
}
