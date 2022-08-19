import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendarBar extends StatelessWidget {
  ScheduleCalendarBar(this.focusedDay, this.changeFocusedDay,
      this.calendarFormat, this.onFormatChanged);
  final void Function(DateTime, DateTime)? changeFocusedDay;
  final void Function(CalendarFormat)? onFormatChanged;
  final String focusedDay;
  final CalendarFormat calendarFormat;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
          formatButtonDecoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )),
      formatAnimationDuration: Duration(milliseconds: 300),
      formatAnimationCurve: Curves.linear,
      onFormatChanged: onFormatChanged,
      calendarFormat: calendarFormat,
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
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).primaryColorLight,
            shape: BoxShape.rectangle),
        outsideDaysVisible: false,
      ),
      onDaySelected: changeFocusedDay,
      locale: 'ru_RU',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      currentDay: DateTime.parse(focusedDay.toString()),
      focusedDay: DateTime.parse(focusedDay.toString()),
    );
  }
}
