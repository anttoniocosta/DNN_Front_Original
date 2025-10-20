import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceChoiceDependent extends StatelessWidget {
  const ServiceChoiceDependent({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      hasLeading: true,
      appBarLeading: const SizedBox(),
      title: 'Escolha quem será atendido',
      //pagesController.currentPage(PagesEnum.choiceDependent)?.name,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const PageHeader(pgEnum: PagesEnum.choiceDependent),
          Text(
            'Para quem será o atendimento? Selecione outras pessoas do plano clicando sobre o nome delas.',
            style: Fonts.bodyLarge(context),
          ),
          20.heightGap,
          GetBuilder<StartAppointmentController>(
            builder: (_) {
              final ownerId = accountController.userAccount!.id!;
              return Column(
                children: startAppointmentController.dependents
                    .map(
                      (dependent) => ClickableBaseTile(
                        onTap: () {
                          startAppointmentController.startAppointment(
                            dependent.personId!,
                          );
                          // if (AppTrigger.isAppPartner) {
                          //   Get.toNamed(
                          //     Routes.partnerConfirmService,
                          //     arguments: dependent.personId,
                          //   );
                          // }
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          clipBehavior: Clip.none,
                          children: [
                            Row(
                              children: [
                                10.widthGap,
                                PictureWidget(
                                  img: ValueNotifier<String>(
                                      dependent.photoProfile ??
                                          MediaRes.blankImg),
                                  size: const Size(60, 60),
                                ),
                                20.widthGap,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dependent.name!.capitalize!,
                                        style: Fonts.titleSmall(context),
                                      ),
                                      Text(
                                        dependent.email!,
                                        style: Fonts.titleSmall(context),
                                      ),
                                      Text(
                                        dependent.phoneNumber!.formatPhone(),
                                        style: Fonts.titleSmall(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ).paddingAll(5),
                            Visibility(
                              visible: ownerId == dependent.personId,
                              child: Positioned(
                                top: -15,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: AppColors.blueColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    'Principal',
                                    style: Fonts.titleSmall(context).copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 20),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomConfirmButton(
        title: 'Voltar ao início',
        onTap: () {
          navigationController.setIndex(NavigationTabs.home);
          Get.offAllNamed(Routes.basePage);
        },
      ),
    );
  }
}
