import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistPicturePage extends StatelessWidget {
  const SpecialistPicturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Meus especialistas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightGap,
          Text(
            'Salve uma foto para o especialista',
            style: Fonts.headlineMedium(context),
          ),
          37.heightGap,
          const ImageProfilePicker(size: 200),
          20.heightGap,
          const SpecialistCard(
            isSelected: true,
            crmNumber: '111111',
            specialty: 'teste',
            fullName: 'Teste',
            price: '10',
          ),
          60.heightGap,
        ],
      ),
      bottomNavigationBar: BottomTwoActionsButton(
        onTapFirst: () => Get.toNamed(Routes.addSpecialistConclusion),
        titleFirst: 'Salvar',
        onTapSecond: () {
          navigationController.setIndex(NavigationTabs.home);
          Get.offAllNamed(Routes.basePage);
        },
        titleSecond: 'Voltar ao início',
      ),
    );
  }
}
