import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AppointmentHoursPartial extends StatelessWidget {
  const AppointmentHoursPartial({
    super.key,
    required this.titlePage,
    required this.contentTitle,
    required this.dayTitle,
    required this.daySelected,
    required this.child,
  });

  final String titlePage;
  final String contentTitle;
  final String dayTitle;
  final String daySelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: titlePage,
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.heightGap,
          Text(
            contentTitle,
            style: Fonts.headlineMedium(context),
          ),
          16.heightGap,
          AppointmentRichText(
            title: dayTitle,
            content: daySelected,
          ),
          24.heightGap,
          child,
        ],
      ),
    );
  }
}
