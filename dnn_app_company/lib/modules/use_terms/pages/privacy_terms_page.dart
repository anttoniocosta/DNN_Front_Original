import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_app_company/modules/modules.dart';

import 'package:flutter/material.dart';

class UseTermsPage extends StatelessWidget {
  const UseTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UseTermsController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.isLoading.value || _.useTermsModel == null,
          needScrollView: true,
          maxWidth: Responsive.maxWidth(),
          title: pagesController.currentPage(PagesEnum.useTerms)?.name,
          bodyChild: Column(
            children: [
              const UseTermsContent(),
              Visibility(
                visible: Responsive.isTabletOrDesktop() &&
                    (!_.isLoading.value || _.useTermsModel != null),
                child: UseTermsBottomActions(
                  isOnBottom: false,
                  onContinue: () => Get.toNamed(Routes.payTerms),
                ).paddingOnly(top: 20),
              )
            ],
          ),
          bottomNavigationBar: Visibility(
            visible: !Responsive.isTabletOrDesktop() &&
                (!_.isLoading.value || _.useTermsModel != null),
            child: UseTermsBottomActions(
              onContinue: () => Get.toNamed(Routes.payTerms),
            ),
          ),
        );
      },
    );
  }
}
