import 'package:dnn_app_clinic/core/core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SelectDaysAdPage extends StatefulWidget {
  const SelectDaysAdPage({super.key});

  @override
  State<SelectDaysAdPage> createState() => _SelectDaysAdPageState();
}

class _SelectDaysAdPageState extends State<SelectDaysAdPage> {
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
            SpecialistCard(
              specialist: SpecialistResponseModel(),
              isSelected: true,
              crmNumber: myAds.selectedSpecialist!.doctor!.crmNumber!,
              specialty: myAds.selectedSpecialist!.specialtyName!,
              fullName: myAds.selectedSpecialist!.doctor!.fullName!,
              price: myAds.selectedSpecialist!.price.toString(),
              clinicName: myAds.selectedSpecialist!.clinic!.fullName!,
            ),
            24.heightGap,
            Text(
              'Clique sobre o dia para ver a agenda.',
              style: Fonts.headlineMedium(context),
            ),
            24.heightGap,
            CalendarTableCustom(
              markerBuilder: (context, day, events) {
                for (final event in myAds.specialistAgenda!.dates!) {
                  if (event.date != null) {
                    if (DateTime.tryParse(event.date!)!.isSameDay(day)) {
                      final dayEvent = CalendarEvent(
                        day: DateTime.parse(event.date!),
                        uid: '',
                        isLowCost: true,
                        price: 1,
                      );
                      return ScheduledSpecialistDayPrice(
                        dayEvent: dayEvent,
                        day: day,
                        onTap: () {
                          myAds.setSelectedDate(event);
                          Get.toNamed(Routes.adSelectHour);
                        },
                      );
                    }
                  }
                }
                return StandartFormartCalendarCell(day: day);
              },
            ),
            24.heightGap,
          ],
        );
      }),
    );
  }
}
