import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_use_terms/dnn_use_terms.dart';
import 'package:flutter/material.dart';

class PayTermsBottomActions extends StatefulWidget {
  const PayTermsBottomActions({
    super.key,
    required this.onContinue,
    this.isOnBottom = true,
    this.isPathDrawer = false,
  });

  final Function() onContinue;
  final bool? isOnBottom;
  final bool isPathDrawer;

  @override
  State<PayTermsBottomActions> createState() => _PayTermsBottomActionsState();
}

class _PayTermsBottomActionsState extends State<PayTermsBottomActions> {
  String planId = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final plan = await storage.getPlanId();
    if (plan != null) {
      planId = plan;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () => AppFunctions.urlLauncherSimples(
                'https://www.doutornanet.com.br/usetermsbuy?id=$planId'),
            child: Text(
              'Acesse o termo de compra COMPLETO aqui.',
              style: Fonts.titleSmall(context)
                  .copyWith(color: AppColors.whiteColor),
              textAlign: TextAlign.center,
            ),
          ).paddingOnly(
              top: 10,
              left: Responsive.isTabletOrDesktop() ? 0 : 20,
              right: Responsive.isTabletOrDesktop() ? 0 : 20,
              bottom: 4),
        ),
        Visibility(
          visible: widget.isOnBottom!,
          replacement: PrimaryButtonWidget(
            titleButtom: 'Aceitar e continuar',
            onTap: () {
              if (widget.isPathDrawer) {
                Get.back();
              } else {
                CustomDialogs.dialogYesOrNot(
                  title: "Deseja aceitar os termos?",
                  onPositive: () {
                    UseTermsModel.saveUseTerms(
                        useTermsController.useTermsModel!.id!);
                    widget.onContinue();
                  },
                  onNegative: () {
                    Get.back();
                  },
                );
              }
            },
          ).paddingOnly(bottom: 10),
          child: BottomConfirmButton(
            needVtPadding: false,
            title: 'Aceitar e continuar',
            onTap: () {
              if (widget.isPathDrawer) {
                Get.back();
              } else {
                CustomDialogs.dialogYesOrNot(
                  title: "Deseja aceitar os termos?",
                  onPositive: () {
                    UseTermsModel.saveUseTerms(
                        useTermsController.useTermsModel!.id!);
                    widget.onContinue();
                  },
                  onNegative: () {
                    Get.back();
                  },
                );
              }
            },
          ).paddingOnly(bottom: 10),
        ),
      ],
    );
  }
}
