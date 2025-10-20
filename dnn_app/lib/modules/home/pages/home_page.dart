import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_offers/modules/offers/partials/home_offers_list_partial_mock.dart';
import 'package:dnn_shared/shared/viewmodels/home_filter_chip_category_model.dart';
import 'package:dnn_shared/shared/widgets/appointment/home_filter_chips_category_custom.dart';
import 'package:dnn_start_appointment/modules/schedule_appointment/page/filter/partials/specialty_partial_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final constraints = const BoxConstraints(maxWidth: 900);
  int currentIndex = -1;

  static List<HomeFilterChipsCategoryModel> chipCategoryList = [
    HomeFilterChipsCategoryModel(index: 0, title: 'Psicológo', id: 4),
    HomeFilterChipsCategoryModel(index: 1, title: 'Psiquiatra', id: 49),
    HomeFilterChipsCategoryModel(index: 2, title: 'Ginicologista', id: 23),
    // HomeFilterChipsCategoryModel(index: 3, title: 'Urologista', id: null),
    HomeFilterChipsCategoryModel(index: 4, title: 'Ortopedista', id: 44),
    HomeFilterChipsCategoryModel(index: 5, title: 'Cardiologista', id: 8),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 10), () async {
        final account = await storage.getAccount();
        if (account != null && account.needCompleteData == true) {
          await accountController.getAccount();
          if (accountController.userAccount != null &&
              (accountController.userAccount!.document == null ||
                  accountController.userAccount!.document!.isEmpty)) {
            Get.to(() => const PersonInfosForProviderPage());
          }
        }
        ScheduleController scheduleController = Get.find();
        scheduleController.setIsReadyService(false);
        if (scheduleController.typeSchedules.isNotEmpty) {
          scheduleController
              .setTypeScheduleId(scheduleController.typeSchedules[0].id!);
          await scheduleController.getFilterSpecialties();
        }
      });
    }, builder: (_) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        needBounce: false,
        needMaxWidth: false,
        needAppBar: false,
        needPadding: false,
        onRefresh: () async => _.getOffers(),
        bodyChild: CustomUpgradeWidget(
          upgradeChild: GetBuilder<NavigationController>(
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: constraints,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.heightGap,
                        Text(
                          'Olá bem-vindo(a)!',
                          style: Fonts.titleSmall(context),
                        ).paddingSymmetric(horizontal: 20),
                        10.heightGap,
                        const SpecialtyFilterPartialHome()
                            .paddingSymmetric(horizontal: 20),
                        5.heightGap,
                        GetBuilder<ScheduleController>(
                            builder: (scheduleController) {
                          if (scheduleController.hasSpecialties) {
                            return Center(
                              child: Wrap(
                                children: chipCategoryList
                                    .map(
                                      (e) => HomeFilterChipsCategoryCustom(
                                        index: currentIndex,
                                        chip: e,
                                        isSelected: currentIndex == e.index,
                                        onTap: (index) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                          scheduleController
                                              .navigateToSpecialty(e.id);
                                        },
                                      ).paddingOnly(
                                          right: 5, left: 5, top: 3, bottom: 5),
                                    )
                                    .toList(),
                              ),
                            );
                          } else if (!navigationController.isLogged) {
                            return Center(
                              child: Wrap(
                                children: chipCategoryList
                                    .map(
                                      (e) => HomeFilterChipsCategoryCustom(
                                        index: currentIndex,
                                        chip: e,
                                        isSelected: false,
                                        onTap: (index) {
                                          var context = Get.context!;
                                          var modal = AppBottomSheet(
                                            content: const LoginModal(
                                              signInAction: _signInAction,
                                            ),
                                          );

                                          modal.show(context);
                                        },
                                      ).paddingOnly(
                                          right: 5, left: 5, top: 3, bottom: 5),
                                    )
                                    .toList(),
                              ),
                            ); // Retorna um Wrap com filtros estáticos e sem ação, ao clicar irá direcionar para a tela de login
                          } else {
                            return Container();
                          }
                        }),
                        10.heightGap,
                        Text(
                          'Ações:',
                          style: Fonts.bodyLarge(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ).paddingSymmetric(horizontal: 20),
                        10.heightGap,
                        HomeActionsListWidget(cardList: clientCards),
                        HomeOffersListPartialMock(
                          title: '',
                          contentBeforeOffersList: !navigationController
                                  .isLogged
                              ? BuyCard(
                                  onTap: () =>
                                      Get.toNamed(Routes.campaignMainOffers),
                                ).paddingOnly(left: 20, right: 10)
                              : null,
                        ),
                        120.heightGap,
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

final clientCards = [
  GetBuilder<NavigationController>(
    builder: (_) => GetBuilder<MyAppointmentsController>(builder: (myApo) {
      return CardTabsHome(
        title: 'Iniciar\nConsulta',
        imageSrc: MediaRes.iniConsulta,
        isPrincipal: false,
        onTap: () async {
          if (!_.isLogged) {
            var context = Get.context!;
            var modal = AppBottomSheet(
              content: const LoginModal(
                signInAction: _signInAction,
              ),
            );

            modal.show(context);
          } else {
            if (dnnController.dnnConfigs!.modeStreaming!) {
              myApo.getMyAppointments();
              Get.toNamed(Routes.startAppointment);
            } else {
              startAppointmentController.getPermission();
            }
          }
        },
      );
    }),
  ),
  GetBuilder<ScheduleController>(
    builder: (sd) => GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
          title: 'Consulta\nOnline',
          imageSrc: MediaRes.conOnline,
          onTap: () async {
            if (!_.isLogged) {
              var context = Get.context!;
              var modal = AppBottomSheet(
                content: const LoginModal(
                  signInAction: _signInAction,
                ),
              );

              modal.show(context);
            } else {
              if (dnnController.dnnConfigs!.modeStreaming!) {
                sd.setIsReadyService(false);

                sd.setTypeScheduleId(sd.typeSchedules[0].id!);
                LoadingDialog.show(Get.context!);
                await sd.getFilterSpecialties();
                LoadingDialog.hide(Get.context!);
                if (sd.specialtyList.isNotEmpty) {
                  Get.toNamed(Routes.scheduleGeneralFilters);
                } else {
                  SnackbarCustom.snackbarError(
                    'Não há especialidades no momento para o tipo de atendimento selecionado',
                  );
                }
              } else {
                AppFunctions.urlLauncherWhatsapp(
                  '5508001509008',
                  'Olá, Doutor na Net!\nGostaria de agendar uma consulta.',
                );
              }
            }
          }),
    ),
  ),
  GetBuilder<ScheduleController>(
    builder: (sd) => GetBuilder<NavigationController>(
      builder: (_) => CardTabsHome(
          title: 'Consulta\nPresencial',
          imageSrc: MediaRes.conPresencial,
          onTap: () async {
            if (!_.isLogged) {
              var context = Get.context!;
              var modal = AppBottomSheet(
                content: const LoginModal(
                  signInAction: _signInAction,
                ),
              );

              modal.show(context);
            } else {
              if (dnnController.dnnConfigs!.modeStreaming!) {
                sd.setIsReadyService(false);

                sd.setTypeScheduleId(sd.typeSchedules[1].id!);
                LoadingDialog.show(Get.context!);
                await sd.getFilterSpecialties();
                LoadingDialog.hide(Get.context!);
                if (sd.specialtyList.isNotEmpty) {
                  Get.toNamed(Routes.scheduleGeneralFilters);
                } else {
                  SnackbarCustom.snackbarError(
                    'Não há especialidades no momento para o tipo de atendimento selecionado',
                  );
                }
              } else {
                AppFunctions.urlLauncherWhatsapp(
                  '5508001509008',
                  'Olá, Doutor na Net!\nGostaria de agendar uma consulta.',
                );
              }
            }
          }),
    ),
  ),
  GetBuilder<NavigationController>(
    builder: (_) => GetBuilder<MyAppointmentsController>(builder: (myApo) {
      return CardTabsHome(
        title: 'Minhas\nConsultas',
        imageSrc: MediaRes.minhasConsultas,
        onTap: () async {
          if (!_.isLogged) {
            var context = Get.context!;
            var modal = AppBottomSheet(
              content: const LoginModal(
                signInAction: _signInAction,
              ),
            );

            modal.show(context);
          } else {
            if (dnnController.dnnConfigs!.modeStreaming!) {
              myApo.getMyAppointments();
              Get.toNamed(Routes.myAppointments);
            } else {
              Get.to(() => const MyAppointmentsRapidocPage());
            }
          }
        },
      );
    }),
  ),
  GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      title: 'Meus\nPlanos',
      imageSrc: MediaRes.meusPlanos,
      onTap: () async {
        if (!_.isLogged) {
          var context = Get.context!;
          var modal = AppBottomSheet(
            content: const LoginModal(
              signInAction: _signInAction,
            ),
          );

          modal.show(context);
        } else {
          _.navigatePageView(NavigationTabs.meusPlanos);
        }
      },
    ),
  ),
  GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      title: 'Meus\nDados',
      imageSrc: MediaRes.meusDados,
      onTap: () async {
        if (!_.isUserLogged.value) {
          var context = Get.context!;
          var modal = AppBottomSheet(
            content: const LoginModal(
              signInAction: _signInAction,
            ),
          );

          modal.show(context);
        } else {
          Get.toNamed(Routes.profile);
        }
      },
    ),
  ),
  HomeItemUtils.contactCardClient(
      content: SizedBox(
    height: 250,
    child: Column(
      children: [
        20.heightGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Entre em contato conosco para esclarecer alguma dúvida.',
                style: Fonts.titleSmall(Get.context!)
                    .copyWith(fontFamily: Fonts.poppins),
                textAlign: TextAlign.start,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(Get.context!).pop();
              },
              icon: const Icon(
                FontAwesomeIcons.chevronDown,
                color: AppColors.blueColor,
              ),
            )
          ],
        ),
        20.heightGap,
        Row(
          children: [
            Expanded(
              child: PrimaryButtonWidget(
                onTap: () async {
                  await AppFunctions.urlLauncherWhatsapp(
                    '5508001509008',
                    'Olá, Doutor na Net!',
                  );
                },
                color: AppColors.successColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.whatsapp),
                    10.widthGap,
                    Text(
                      "WhatsApp",
                      style: Fonts.titleMedium(Get.context!).copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.poppins,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            20.widthGap,
            Expanded(
              child: PrimaryButtonWidget(
                onTap: () async {
                  await AppFunctions.urlLauncherWithScheme(
                    '5508006995003',
                    scheme: 'tel',
                  );
                },
                color: AppColors.blackDarkColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.phone),
                    10.widthGap,
                    Text(
                      "Telefone",
                      style: Fonts.titleMedium(Get.context!).copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.poppins,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        20.heightGap,
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(Get.context!).size.width / 2.2,
            child: PrimaryButtonWidget(
              onTap: () async {
                await AppFunctions.urlLauncherWithScheme(
                  'suporte@doutornanet.com.br',
                  scheme: 'mailto',
                );
              },
              color: AppColors.blueColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(FontAwesomeIcons.envelope),
                  10.widthGap,
                  Text(
                    "E-mail",
                    style: Fonts.titleMedium(Get.context!).copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: Fonts.poppins,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  )),
  GetBuilder<NavigationController>(
    builder: (_) => CardTabsHome(
      title: 'Faturas',
      imageSrc: MediaRes.faturas,
      onTap: () async {
        if (!_.isLogged) {
          var context = Get.context!;
          var modal = AppBottomSheet(
            content: const LoginModal(
              signInAction: _signInAction,
            ),
          );

          modal.show(context);
        } else {
          await storage.setPaymentCicle(2);
          Get.toNamed(Routes.myInvoices);
        }
      },
    ),
  ),
  HomeItemUtils.campaignCard(title: 'Assinar\nPlanos'),
];

_signInAction() async {
  offersController.getOffers();
  navigationController.navigatePageView(NavigationTabs.home);
  wsServices.start();
  ShoppingCartBinding().dependencies();
  await shoppingCartController.getShoppingCartSecondCall();
  shoppingCartController.deleteShoppingCart();
}
