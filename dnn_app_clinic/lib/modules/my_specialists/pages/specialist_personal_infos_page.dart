import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistPersonalInfosPage extends StatefulWidget {
  const SpecialistPersonalInfosPage({super.key});

  @override
  State<SpecialistPersonalInfosPage> createState() =>
      _SpecialistPersonalInfosPageState();
}

class _SpecialistPersonalInfosPageState
    extends State<SpecialistPersonalInfosPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> cpfKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySpecialistsController>(initState: (state) {
      providersController.clear();
    }, builder: (_) {
      return MobileLayout(
        needCenter: false,
        needScrollView: true,
        title: 'Meus especialistas',
        maxWidth: Responsive.maxWidth(),
        bodyChild: GetBuilder<MySpecialistsController>(
          initState: (state) {
            Future.delayed(const Duration(milliseconds: 10), () {
              _.clearRegistration();
            });
          },
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightGap,
                Text(
                  'Insira os dados pessoais do profissional',
                  style: Fonts.bodyLarge(context),
                ),
                20.heightGap,
                SpecialistInfoFormPartial(
                  formKey: formKey,
                  cpfKey: cpfKey,
                  crmController: _.crmController,
                ),
                16.heightGap,
                PrimaryButtonWidget(
                  onTap: () {
                    if (formKey.currentState!.validate() &&
                        cpfKey.currentState!.validate()) {
                      Get.toNamed(Routes.addSpecialistLocation);
                    }
                  },
                  titleButtom: 'Continuar',
                ),
                26.heightGap,
              ],
            );
          },
        ),
      );
    });
  }
}
