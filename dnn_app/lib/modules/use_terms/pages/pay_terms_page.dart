import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_use_terms/dnn_use_terms.dart';
import 'package:flutter/material.dart';

class PayTermsPage extends StatelessWidget {
  const PayTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UseTermsController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.isLoading.value || _.payTerms == null,
          needScrollView: true,
          title: 'Termo de compra',
          maxWidth: Responsive.maxWidth(),
          bodyChild: Column(
            children: [
              const PayTermsContent(),
              Visibility(
                visible: Responsive.isTabletOrDesktop() &&
                    (!_.isLoading.value || _.payTerms != null),
                child: PayTermsBottomActions(
                  isOnBottom: false,
                  onContinue: () => Get.toNamed(Routes.paymentChoice),
                ).paddingOnly(top: 20),
              )
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: !Responsive.isTabletOrDesktop() &&
                (!_.isLoading.value || _.payTerms != null),
            child: PayTermsBottomActions(
              onContinue: () => Get.toNamed(Routes.paymentChoice),
            ),
          ),
        );
      },
    );
  }
}
