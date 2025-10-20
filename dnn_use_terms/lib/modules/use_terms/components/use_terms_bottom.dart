import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_use_terms/dnn_use_terms.dart';
import 'package:flutter/material.dart';

class UseTermsBottomActions extends StatelessWidget {
  const UseTermsBottomActions({
    super.key,
    required this.onContinue,
    this.isOnBottom = true,
    this.isDrawer = false,
  });

  final Function() onContinue;
  final bool? isOnBottom;
  final bool isDrawer;

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
                'https://www.doutornanet.com.br/useterms'),
            child: Text(
              'Acesse o termo de uso COMPLETO aqui.',
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
          visible: isOnBottom! && !isDrawer,
          child: BottomConfirmButton(
            needVtPadding: false,
            title: 'Aceitar e continuar',
            onTap: () {
              UseTermsModel.saveUseTerms(useTermsController.useTermsModel!.id!);
              onContinue();
            },
          ).paddingOnly(bottom: 10),
        ),
      ],
    );
  }
}
