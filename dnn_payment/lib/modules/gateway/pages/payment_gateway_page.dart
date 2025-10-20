import 'dart:developer';

import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';

import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class PaymentGatewayPage extends StatelessWidget {
  const PaymentGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ClientStandardPage();
  }
}

/// Body da tela de Gateways para contratação de uma plano para
/// si/e/ou para dependentes no [Aplicativo_Client_Padrao]
class _ClientStandardPage extends StatefulWidget {
  const _ClientStandardPage();

  @override
  State<_ClientStandardPage> createState() => _ClientStandardPageState();
}

class _ClientStandardPageState extends State<_ClientStandardPage> {
  List<GatewayDataModel> gateways = [];
  bool? isSchedule = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    try {
      if (await storage.getPaymentCicle() == PaymentEnum.SCHEDULE) {
        isSchedule = true;
      } else {
        isSchedule = false;
        gateways = await storage.getGatewayList();
      }
    } catch (e) {
      isSchedule = false;
      gateways = await storage.getGatewayList();
    }

    setState(() {});
    log(gateways.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatewayController>(
      builder: (gateway) {
        return MobileLayout(
            needCenter: gateways.isEmpty && gateway.gatewayList.isEmpty,
            needScrollView: true,
            maxWidth: Responsive.maxWidth(),
            title: pagesController
                .currentPage(PagesEnum.paymentGatewayChoice)!
                .name!,
            bodyChild: GetBuilder<GatewayController>(
              initState: (__) {
                if (isSchedule!) {
                  Future.delayed((const Duration(milliseconds: 10)), () {
                    gateway.getAllGateways();
                  });
                }
              },
              builder: (_) {
                if (isSchedule!) {
                  if (_.isLoading.value) {
                    return const PageLoadingWidget();
                  }
                  if (_.gatewayList.isEmpty) {
                    return GetBuilder<GatewayController>(builder: (_) {
                      return TryAgainPage(
                        message:
                            'Não foi possível recuperar as formas de pagamento',
                        onTryAgain: () async {
                          _.getAllGateways();
                        },
                      );
                    });
                  }

                  return GetBuilder<ScheduleController>(builder: (schedule) {
                    return Column(
                      children: [
                        const PageHeader(
                            pgEnum: PagesEnum.paymentGatewayChoice),
                        20.heightGap,
                        ..._.gatewayList
                            .map(
                              (e) => GatewayButton(
                                onTap: () async {
                                  await storage.setGatewayId(e.id!);
                                  gatewayController.progressWithPayment(
                                    PaymentEnum.SCHEDULE,
                                    schedule.scheduleHourSelected!.price!,
                                  );
                                },
                                name: e.name!,
                                id: e.id!,
                              ),
                            )
                            .toList()
                      ],
                    );
                  });
                } else {
                  if (gateways.isEmpty) {
                    return TryAgainPage(
                      message:
                          'Não foi possível recuperar as formas de pagamento',
                      onTryAgain: () async {
                        gateways = await storage.getGatewayList();
                        setState(() async {});
                      },
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.heightGap,
                      const PageHeader(
                        pgEnum: PagesEnum.paymentGatewayChoice,
                        textStyle: TextStyle(fontFamily: 'Poppins'),
                      ),
                      20.heightGap,
                      Visibility(
                        visible: appContext.type == AppTypeEnum.COMPANY,
                        child: GatewayButton(
                          icon: FontAwesomeIcons.fileInvoiceDollar,
                          onTap: () async {
                            await storage.setGatewayId(99);
                            gatewayController.progressWithPayment(
                              PaymentEnum.PURCHASE,
                              shoppingCartController
                                  .shoppingCartComplete!.items![0].total!,
                            );
                          },
                          name: 'A Faturar',
                          id: 99,
                        ),
                      ),
                      ...gateways
                          .map(
                            (e) => GatewayButton(
                              onTap: () async {
                                await storage.setGatewayId(e.id!);
                                gatewayController.progressWithPayment(
                                  PaymentEnum.PURCHASE,
                                  shoppingCartController
                                      .shoppingCartComplete!.items![0].total!,
                                );
                              },
                              name: e.name!,
                              id: e.id!,
                            ),
                          )
                          .toList(),
                    ],
                  );
                }
              },
            ));
      },
    );
  }
}
