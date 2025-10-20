import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HelpersPage extends StatelessWidget {
  final bool showAppBar;
  const HelpersPage({
    super.key,
    this.showAppBar = true,
  });

  Widget? _leading() {
    if (Get.currentRoute == Routes.basePage) return const MenuButtom();
    return null;
  }

  Widget _body() {
    if (helpersController.helpers != null) return const HelpersPartial();
    return const EmptyPageWidget(title: 'Erro ao Carregar os Dados');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpersController>(
      builder: (_) {
        return MobileLayout(
          needCenter: helpersController.helpers == null ? true : false,
          needScrollView: true,
          hasActions: false,
          maxWidth: Responsive.maxWidth(),
          appBarLeading: _leading(),
          needAppBar: showAppBar,
          title: pagesController.currentPage(PagesEnum.helpers)?.name,
          bodyChild: _body(),
        );
      },
    );
  }
}

class HelpersPartial extends StatelessWidget {
  const HelpersPartial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeader(pgEnum: PagesEnum.helpers),
        10.heightGap,
        GetBuilder<HelpersController>(
          builder: (_) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: helpersController.helpers!.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final e = helpersController.helpers![index];
                return Column(
                  children: [
                    HelpersTile(
                      e: e,
                      icon: getIconData(e.icon),
                      onTap: () {
                        Get.toNamed(
                          Routes.helpersList,
                          arguments: {
                            'tag': e.tags!,
                            'childs': e.childs,
                            'title': e.title!
                          },
                        );
                      },
                    ),
                    const Divider()
                  ],
                );
              },
            );
          },
        ),
        20.heightGap,
      ],
    );
  }
}

IconData? getIconData(String? iconName) {
  final result = MdiIcons.fromString(iconName ?? '');

  if (result != null) {
    return result;
  }

  return MdiIcons.fromString('help-circle-outline');
}
