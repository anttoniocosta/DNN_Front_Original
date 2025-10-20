import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistFinishRegisterPage extends StatelessWidget {
  const SpecialistFinishRegisterPage({super.key});

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
            'Especialista cadastrado com sucesso!',
            style: Fonts.headlineMedium(context).copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 20),
          10.heightGap,
          Image.asset(MediaRes.scheduleAppointmentSucess, width: 250).toCenter,
          GetBuilder<MySpecialistsController>(
            builder: (_) {
              return Column(
                children: [
                  SpecialistCard(
                    isSelected: true,
                    specialist: SpecialistResponseModel(),
                    crmNumber: _.specialistCreateModel!.crmNumber!,
                    specialty: _.selectedSpecialty!.name!,
                    price: _.priceController.text.returnNumber().toString(),
                    fullName: _.specialistCreateModel!.fullName!,
                  ),
                  32.heightGap,
                  SecondaryButtonWidget(
                    onTap: () {
                      Get.offNamedUntil(
                        Routes.addSpecialistInfos,
                        ModalRoute.withName(Routes.mySpecialistList),
                      );
                    },
                    titleButtom: 'Adicionar novo',
                  ),
                  10.heightGap,
                  PrimaryButtonWidget(
                    onTap: () {
                      _.getMySpecialists();
                      navigationController.setIndex(NavigationTabs.home);
                      Get.offAllNamed(Routes.basePage);
                    },
                    titleButtom: 'Voltar ao início',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
