import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendarBar extends StatelessWidget {
  const ScheduleCalendarBar(this.focusedDay, this.changeFocusedDay,
      this.calendarFormat, this.onFormatChanged,
      {super.key});
  final void Function(DateTime, DateTime)? changeFocusedDay;
  final void Function(CalendarFormat)? onFormatChanged;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          formatAnimationCurve: Curves.fastLinearToSlowEaseIn,
          onFormatChanged: onFormatChanged,
          calendarFormat: calendarFormat,
          //sixWeekMonthsEnforced: true,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Месяц',
            //  CalendarFormat.twoWeeks: '2 недели',
            CalendarFormat.week: 'Неделя'
          },
          calendarStyle: CalendarStyle(
            weekendDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle),
            holidayDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle),
            outsideDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle),
            defaultDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle),
            selectedDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle),
            // Use `CalendarStyle` to customize the UI
            markerDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                shape: BoxShape.rectangle),
            todayTextStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 16.0),
            todayDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).primaryColorLight,
                shape: BoxShape.rectangle),
            outsideDaysVisible: false,
          ),
          onDaySelected: changeFocusedDay,
          locale: 'ru_RU',
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          currentDay: focusedDay,
          focusedDay: focusedDay,
        ),

        //IconButton(onPressed: (){onFormatChanged!(calendarFormat == CalendarFormat.month?CalendarFormat.week: CalendarFormat.month);}, icon: Icon(calendarFormat == CalendarFormat.month?Icons.arrow_drop_up:Icons.arrow_drop_down)),
        const Divider(
          indent: 10,
          endIndent: 10,
          height: 1,
          color: Colors.black12,
        ),
      ],
    );
  }
}
