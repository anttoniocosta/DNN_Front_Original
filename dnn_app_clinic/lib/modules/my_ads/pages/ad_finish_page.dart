import 'package:dnn_app_clinic/core/clinic/export.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AdFinishedPage extends StatefulWidget {
  const AdFinishedPage({super.key});

  @override
  State<AdFinishedPage> createState() => _AdFinishedPageState();
}

class _AdFinishedPageState extends State<AdFinishedPage> {
  List<dynamic> hours = [
    {'hour': '11:00', 'consults': 1, 'price': 70.00},
    {'hour': '12:00', 'consults': 1, 'price': 70.00},
  ];

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Meus anuncios',
      maxWidth: Responsive.maxWidth(),
      bodyChild: GetBuilder<MyAdsController>(builder: (myAds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightGap,
            Text(
              'Seus anúncios foram removidos com sucesso',
              style: Fonts.headlineMedium(context).copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 20),
            10.heightGap,
            Image.asset(
              MediaRes.doctorAppointment,
              width: 200,
            ).toCenter,
            10.heightGap,
            SpecialistCard(
              specialist: SpecialistResponseModel(),
              isSelected: true,
              crmNumber: myAds.selectedSpecialist!.doctor!.crmNumber!,
              specialty: myAds.selectedSpecialist!.specialtyName!,
              fullName: myAds.selectedSpecialist!.doctor!.fullName!,
              price: myAds.selectedSpecialist!.price.toString(),
              clinicName: myAds.selectedSpecialist!.clinic!.fullName!,
            ),
            10.heightGap,
            ...myAds.hoursToRemove.map(
              (hour) => HourScheduledTile(
                hour: hour.hour!,
                typeScheduled: hour.typeScheduleName!,
                price: hour.price!,
                isSelected: true,
                onTap: null,
              ),
            ),
            10.heightGap,
          ],
        );
      }),
      bottomNavigationBar: GetBuilder<MyAdsController>(
        builder: (myAds) {
          return BottomConfirmButton(
            onTap: () {
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
              myAds.clear();
            },
            title: 'Voltar para o início',
          );
        },
      ),
    );
  }
}
