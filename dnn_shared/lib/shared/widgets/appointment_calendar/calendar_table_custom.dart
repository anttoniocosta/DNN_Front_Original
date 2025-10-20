import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CalendarTableCustom extends StatelessWidget {
  const CalendarTableCustom({
    super.key,
    required this.markerBuilder,
    this.focusedDay,
    this.firstDayCalendar,
  });

  final Widget? Function(BuildContext, DateTime, List<Object?>)? markerBuilder;
  final DateTime? focusedDay;
  final DateTime? firstDayCalendar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Get.isDarkMode
              ? AppColors.lighterGreyColor
              : AppColors.lighterGreyColor,
        ),
      ),
      child: TableCalendar(
        locale: 'pt_BR',
        headerStyle: _headerStyle(),
        calendarStyle: _calendarStyle(context),
        daysOfWeekHeight: 35,
        rowHeight: 59,
        calendarFormat: CalendarFormat.month,
        availableGestures: AvailableGestures.horizontalSwipe,
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) {
            return Text(
              '${day.month.getCurrentMonth()} ${day.year}',
              style: Fonts.titleSmall(context)
                  .copyWith(fontSize: 18, color: AppColors.whiteColor),
            ).toCenter;
          },
          dowBuilder: (context, day) {
            return Text(
              day.formatWeekdayName(),
              style: Fonts.titleMedium(context),
            ).toCenter;
          },
          markerBuilder: markerBuilder,
        ),
        firstDay: firstDayCalendar ?? DateTime.now(),
        lastDay: DateTime.utc(2060, 3, 14),
        focusedDay: focusedDay ?? DateTime.now(),
      ),
    );
  }

  HeaderStyle _headerStyle() {
    return const HeaderStyle(
      headerPadding: EdgeInsets.symmetric(vertical: 5),
      formatButtonVisible: false,
      leftChevronPadding: EdgeInsets.all(6),
      rightChevronPadding: EdgeInsets.all(6),
      leftChevronMargin: EdgeInsets.only(left: 8, right: 10),
      rightChevronMargin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(color: AppColors.blackDarkColor),
      leftChevronIcon: FaIcon(FontAwesomeIcons.chevronLeft,
          size: 16, color: AppColors.whiteColor),
      rightChevronIcon: FaIcon(FontAwesomeIcons.chevronRight,
          size: 16, color: AppColors.whiteColor),
    );
  }

  CalendarStyle _calendarStyle(BuildContext context) {
    return CalendarStyle(
      cellAlignment: Alignment.topLeft,
      isTodayHighlighted: true,
      outsideTextStyle:
          Fonts.bodySmall(context).copyWith(color: AppColors.transparent),
      weekendTextStyle:
          Fonts.bodySmall(context).copyWith(color: AppColors.transparent),
      defaultTextStyle:
          Fonts.bodySmall(context).copyWith(color: AppColors.transparent),
      todayDecoration: const BoxDecoration(color: AppColors.transparent),
      tableBorder: TableBorder.all(
          color: Get.isDarkMode
              ? AppColors.lighterGreyColor.withOpacity(0.3)
              : AppColors.whiteColor),
    );
  }
}

class StandartFormartCalendarCell extends StatelessWidget {
  const StandartFormartCalendarCell({super.key, required this.day});
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: (Get.isDarkMode ? Colors.black : AppColors.lighterGreyColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              day.day.toString(),
              style: day.isSameDay(DateTime.now())
                  ? Fonts.titleSmall(context)
                  : Fonts.bodyMedium(context),
            ),
          ],
        ).paddingOnly(left: 8, top: 4),
      ),
    );
  }
}

class SelectDayCalendarCell extends StatelessWidget {
  const SelectDayCalendarCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });
  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          color: isSelected
              ? AppColors.blackDarkColor
              : (Get.isDarkMode ? Colors.black : AppColors.lighterGreyColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                day.day.toString(),
                style: day.isSameDay(DateTime.now())
                    ? Fonts.titleSmall(context).copyWith(
                        color: isSelected ? AppColors.whiteColor : null)
                    : Fonts.bodyMedium(context).copyWith(
                        color: isSelected ? AppColors.whiteColor : null),
              ),
            ],
          ).paddingOnly(left: 8, top: 4),
        ),
      ),
    );
  }
}

class CalendarCellWithPrice extends StatelessWidget {
  const CalendarCellWithPrice({
    super.key,
    required this.dayEvent,
    required this.day,
    required this.onTap,
    this.hasPermission,
  });
  final bool? hasPermission;
  final CalendarEvent dayEvent;
  final DateTime day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: dayEvent.isLowCost
              ? AppColors.blackDarkColor
              : dayEvent.acceptDnn!
                  ? AppColors.greenColor
                  : AppColors.blueColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                dayEvent.day.day.toString(),
                style: day.isSameDay(DateTime.now())
                    ? Fonts.titleSmall(context)
                        .copyWith(color: AppColors.whiteColor)
                    : Fonts.bodyMedium(context)
                        .copyWith(color: AppColors.whiteColor),
              ),
              if (hasPermission != true)
                Text(
                  'R\$',
                  style: Fonts.bodySmall(context)
                      .copyWith(fontSize: 10, color: AppColors.whiteColor),
                ),
              if (hasPermission != true)
                Text(
                  dayEvent.price.toStringAsFixed(0),
                  style: Fonts.titleSmall(context).copyWith(
                      fontWeight: Fonts.bold, color: AppColors.whiteColor),
                ),
            ],
          ).paddingOnly(left: 8, top: 4),
        ),
      ),
    );
  }
}

class ScheduledSpecialistDayPrice extends StatelessWidget {
  const ScheduledSpecialistDayPrice({
    super.key,
    required this.dayEvent,
    required this.day,
    required this.onTap,
  });

  final CalendarEvent dayEvent;
  final DateTime day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: AppColors.blackDarkColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                dayEvent.day.day.toString(),
                style: day.isSameDay(DateTime.now())
                    ? Fonts.titleSmall(context)
                        .copyWith(color: AppColors.whiteColor)
                    : Fonts.bodyMedium(context)
                        .copyWith(color: AppColors.whiteColor),
              ),
            ],
          ).paddingOnly(left: 8, top: 4),
        ),
      ),
    );
  }
}
