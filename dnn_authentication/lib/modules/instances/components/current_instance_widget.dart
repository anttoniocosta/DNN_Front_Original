import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class CurrentInstanceWidget extends StatelessWidget {
  const CurrentInstanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(builder: (_) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: accountController.userAccount!.instances!.length > 1
            ? () {
                Get.to(() => const InstancesPage(),
                    transition: Transition.cupertino);
              }
            : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color:
                    Get.isDarkMode ? AppColors.whiteColor : AppColors.greyColor,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              const RippleWidget(),
              20.widthGap,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountController.userAccount!.instances!.length > 1
                          ? 'Sua instância atual:'
                          : 'Instância única:',
                      style: Fonts.bodySmall(context),
                    ),
                    Text(
                      _.currentInstance!.instanceName!.capitalize!,
                      style: Fonts.titleSmall(context),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: accountController.userAccount!.instances!.length > 1,
                child: Row(
                  children: [
                    Text(
                      'Trocar instância',
                      style: Fonts.bodySmall(context),
                    ),
                    10.widthGap,
                    FaIcon(
                      FontAwesomeIcons.chevronRight,
                      color: Get.isDarkMode ? AppColors.whiteColor : null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
