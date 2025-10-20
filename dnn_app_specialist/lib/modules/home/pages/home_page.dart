import 'package:dnn_app_specialist/core/specialist/controller/my_appointments_controller.dart';
import 'package:dnn_app_specialist/core/specialist/controller/speacialist_controller.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final constraints = const BoxConstraints(maxWidth: 900);

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      needBounce: false,
      needMaxWidth: false,
      needAppBar: false,
      needPadding: false,
      drawer: const DrawerCustom(navbarItems: NaviItems()),
      bodyChild: CustomUpgradeWidget(
        upgradeChild: GetBuilder<NavigationController>(
          builder: (_) {
            return GetBuilder<SpecialistController>(builder: (specialist) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HomeHeaderWidget(),
                  ConstrainedBox(
                    constraints: constraints,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 16.heightGap,
                        // if (navigationController.isUserLogged.value) ...[
                        //   Text(
                        //     'Fila de pacientes no plantão por suas especialidades',
                        //     style: Fonts.titleLarge(context),
                        //   ).paddingSymmetric(horizontal: 20),
                        //   10.heightGap,
                        //   SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     controller: ScrollController(),
                        //     child: Row(
                        //       children: [
                        //         SizedBox(
                        //           width: 350,
                        //           child: const ConsultsScheduled(
                        //             quantity: 10,
                        //           ).paddingOnly(right: 10),
                        //         ),
                        //         const CardPacientsPerQueue(
                        //           pacientsQuantity: 8,
                        //           queueName: 'Clínica Geral',
                        //         ),
                        //         const CardPacientsPerQueue(
                        //           pacientsQuantity: 3,
                        //           queueName: 'Psicologia',
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ],
                        20.heightGap,
                        Text(
                          'Minhas ações',
                          style: Fonts.titleMedium(context),
                        ).paddingSymmetric(horizontal: 20),
                        12.heightGap,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3, color: AppColors.lighterGreyColor),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Está em plantão?',
                                  style: Fonts.titleMedium(context),
                                ),
                              ),
                              GetBuilder<SpecialistController>(
                                initState: (__) {
                                  Future.delayed(
                                      const Duration(milliseconds: 10), () {
                                    specialist.isAlreadyOnDuty();
                                  });
                                },
                                builder: (_) {
                                  if (_.isDutyLoading.value) {
                                    return const CircularProgressIndicator
                                            .adaptive()
                                        .paddingSymmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    );
                                  }
                                  return Switch.adaptive(
                                    activeColor: AppColors.blueColor,
                                    value: _.isOnDuty,
                                    onChanged: (val) async {
                                      if (!navigationController
                                          .isUserLogged.value) {
                                        navigationController.navigatePageView(
                                            NavigationTabs.login);
                                      } else {
                                        if (val) {
                                          await _.startDuty();
                                        } else {
                                          await _.finishDuty();
                                        }
                                      }
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 20),
                        GetBuilder<SpecialistController>(builder: (_) {
                          if (_.isOnDuty) {
                            return Column(
                              children: [
                                12.heightGap,
                                GetBuilder<SpecialistController>(builder: (_) {
                                  return HomeSpecialistAction(
                                    bg: AppColors.lighterblackLightColor,
                                    buttonText: 'Iniciar Atendimento Triagem',
                                    onTap: () async {
                                      if (!navigationController
                                          .isUserLogged.value) {
                                        navigationController.navigatePageView(
                                            NavigationTabs.login);
                                      } else {
                                        specialist.setScreeningCicle(
                                            ScreeningCicle.triagem);
                                        LoadingDialog.show(context);
                                        await specialist.getQueueTriagem();
                                        LoadingDialog.hide(context);
                                        Get.toNamed(Routes.triagemQueueDoctor);
                                      }
                                    },
                                  );
                                }),
                                12.heightGap,
                                HomeSpecialistAction(
                                  bg: AppColors.blackDarkColor,
                                  buttonText: 'Iniciar Pronto Atendimento',
                                  onTap: () async {
                                    if (!navigationController
                                        .isUserLogged.value) {
                                      navigationController.navigatePageView(
                                          NavigationTabs.login);
                                    } else {
                                      specialist.setScreeningCicle(
                                          ScreeningCicle.ready);
                                      LoadingDialog.show(context);
                                      await specialist.getQueues(true);
                                      LoadingDialog.hide(context);

                                      Get.toNamed(Routes.scheduledQueueDoctor);
                                    }
                                  },
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                        12.heightGap,
                        HomeSpecialistAction(
                          bg: AppColors.blueColor,
                          buttonText: 'Iniciar Atendimento Agendado',
                          onTap: () async {
                            if (!navigationController.isUserLogged.value) {
                              navigationController
                                  .navigatePageView(NavigationTabs.login);
                            } else {
                              LoadingDialog.show(context);
                              await specialist.getQueues(false);
                              LoadingDialog.hide(context);
                              specialist
                                  .setScreeningCicle(ScreeningCicle.scheduled);
                              Get.toNamed(Routes.scheduledQueueDoctor);
                            }
                          },
                        ),
                        12.heightGap,
                        HomeActionsListWidget(cardList: clientCards),
                        80.heightGap
                      ],
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}

class CardPacientsPerQueue extends StatelessWidget {
  const CardPacientsPerQueue(
      {super.key, required this.pacientsQuantity, required this.queueName});

  final int pacientsQuantity;
  final String queueName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      width: 205,
      height: 149,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? AppColors.blackLightColor
            : AppColors.blackDarkColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          26.heightGap,
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Existem',
                    style: Fonts.titleSmall(context).copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    pacientsQuantity < 10
                        ? '0$pacientsQuantity'
                        : pacientsQuantity.toString(),
                    style: Fonts.titleLarge(context).copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const FaIcon(
              FontAwesomeIcons.personWalking,
              color: AppColors.whiteColor,
              size: 40,
            )
          ]),
          Expanded(
            child: Text(
              'pacientes da fila ',
              style: Fonts.titleSmall(context).copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              queueName,
              style: Fonts.titleLarge(context).copyWith(
                color: AppColors.whiteColor,
                fontSize: 20,
              ),
            ),
          ),
          26.heightGap,
        ],
      ),
    ).paddingOnly(right: 10);
  }
}

class HomeSpecialistAction extends StatelessWidget {
  const HomeSpecialistAction({
    super.key,
    required this.bg,
    required this.onTap,
    required this.buttonText,
  });
  final Color bg;
  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        width: context.mediaQuerySize.width,
        height: 113,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            20.widthGap,
            CardIconWidget(
              cardColor: AppColors.whiteColor,
              iconColor: bg,
              radius: 10,
              iconSize: 30,
              icon: FontAwesomeIcons.userDoctor,
            ),
            10.widthGap,
            Expanded(
                child: Text(
              buttonText,
              style: Fonts.headlineMedium(context).copyWith(
                color: AppColors.whiteColor,
              ),
              textAlign: TextAlign.center,
            )),
            20.widthGap,
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: 20);
  }
}

final clientCards = [
  GetBuilder<NavigationController>(
    builder: (_) => GetBuilder<MyAppointmentsController>(builder: (myAppoi) {
      return CardTabsHome(
        title: 'Minhas\nConsultas',
        icon: FontAwesomeIcons.stethoscope,
        onTap: () async {
          if (!navigationController.isUserLogged.value) {
            navigationController.navigatePageView(NavigationTabs.login);
          } else {
            LoadingDialog.show(Get.context!);
            final result = await myAppoi.getAppointments();
            LoadingDialog.hide(Get.context!);
            if (result) {
              Get.toNamed(Routes.appointmentedSelectDay);
            } else {
              SnackbarCustom.snackbarError('Sem consultas na lista');
            }
          }
        },
      );
    }),
  ),
  GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      title: 'Meus Dados',
      icon: FontAwesomeIcons.solidUser,
      onTap: () async {
        if (!navigationController.isUserLogged.value) {
          navigationController.navigatePageView(NavigationTabs.login);
        } else {
          navigationController.navigatePageView(NavigationTabs.profile);
        }
      },
    ),
  ),
  HomeItemUtils.contactCard,
];
