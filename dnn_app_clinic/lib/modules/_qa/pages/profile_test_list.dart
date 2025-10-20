import 'package:dnn_authentication/core/controllers/authentication_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ProfileTestList extends StatefulWidget {
  const ProfileTestList({super.key});

  @override
  State<ProfileTestList> createState() => _ProfileTestListState();
}

class _ProfileTestListState extends State<ProfileTestList> {
  @override
  void initState() {
    qaController.getScenarios();
    super.initState();
  }

  @override
  void dispose() {
    qaController.scenerios = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QualityAssuranceController>(builder: (_) {
      return MobileLayout(
        needCenter: _.scenerios == null || _.isLoading.value,
        needScrollView: true,
        hasActions: false,
        maxWidth: Responsive.maxWidth(),
        title: 'QA',
        bodyChild: GetBuilder<QualityAssuranceController>(builder: (_) {
          return Column(
            children: [
              GetBuilder<QualityAssuranceController>(builder: (_) {
                if (_.scenerios == null) {
                  return const EmptyPageWidget(
                    title: 'Usuário sem cenários de teste.',
                  );
                }
                if (_.isLoading.value) {
                  return const Expanded(child: PageLoadingWidget());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Lista de perfis para teste',
                      style: Fonts.titleLarge(context),
                    ),
                    const Divider(),
                    ..._.scenerios!.members!
                        .where((x) => x.isCliente)
                        .map((member) => QAProfileTile(member: member))
                        .toList(),
                  ],
                );
              })
            ],
          );
        }),
      );
    });
  }
}

class QAProfileTile extends StatelessWidget {
  const QAProfileTile({super.key, required this.member});

  final MemberModel member;

  _switchProfile() async {
    LoadingDialog.show(Get.context!);
    await qaController.changeScenario(member).then((value) {
      Get.offAllNamed(Routes.basePage);
      LoadingDialog.hide(Get.context!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: _switchProfile,
            title: Text(member.name!, style: Fonts.titleSmall(context)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.role!),
                Text(member.login!),
                Text(member.email!),
              ],
            ),
            trailing: const Icon(Icons.login, color: AppColors.blackLightColor),
          ),
          const Divider(),
        ],
      );
    });
  }
}
