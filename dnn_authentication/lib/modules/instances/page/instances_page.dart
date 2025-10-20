import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

import '../../../dnn_authentication.dart';

class InstancesPage extends StatelessWidget {
  const InstancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (_) {
      return MobileLayout(
        needCenter: _.isLoadingAccountInfos.value ||
            (_.userAccount!.instances == null &&
                _.userAccount!.instances!.isEmpty),
        needScrollView: true,
        title: 'Minhas Instâncias',
        onRefresh: () async => _.getAccount(),
        maxWidth: Responsive.maxWidth(),
        bodyChild: GetBuilder<AccountController>(
          builder: (_) {
            if (_.userAccount != null &&
                (_.userAccount!.instances == null &&
                    _.userAccount!.instances!.isEmpty)) {
              return TryAgainPage(
                message: 'Aparentemente você não possui instâncias',
                onTryAgain: () => _.getAccount(),
              );
            }

            if (_.isLoadingAccountInfos.value) {
              return const PageLoadingWidget();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightGap,
                Text(
                  'Aqui você tem a sua lista de instâncias para serem utilizadas pelo seu perfil. Clique sobre a instância que gostaria de trocar.',
                  style: Fonts.bodyLarge(context),
                ),
                20.heightGap,
                ..._.userAccount!.instances!
                    .map(
                      (e) => GetBuilder<AuthenticationController>(
                        builder: (_) {
                          return InstanceTile(
                            text: e.instanceName!.capitalize!,
                            onTap: () async => await _.changeInstance(e),
                          ).paddingOnly(bottom: 12);
                        },
                      ),
                    )
                    .toList()
              ],
            );
          },
        ),
      );
    });
  }
}

class InstanceTile extends StatelessWidget {
  const InstanceTile({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Get.isDarkMode
                ? AppColors.whiteColor
                : AppColors.lighterGreyColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: Fonts.titleLarge(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            20.widthGap,
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Get.isDarkMode ? AppColors.whiteColor : null,
            )
          ],
        ),
      ),
    );
  }
}
