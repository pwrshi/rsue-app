import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:rsue_schedule_api/schedule_type.dart';
import 'package:table_calendar/table_calendar.dart';

import 'day.dart';

class ScheduleCalendarView extends StatelessWidget {
  ScheduleCalendarView(
      {this.onPageChanged,
      required this.pages,
      required this.data,
      required this.format});
  final CalendarFormat format;
  final List<DateTime> pages;
  final Schedule data;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height -
                (format == CalendarFormat.week ? 225 : 485),
            initialPage: 1,
            viewportFraction: 1,
            onPageChanged: onPageChanged),
        items: pages.map((i) {
          return ListView(children: [DayList(data.onDay(i))]);
        }).toList());
  }
}
