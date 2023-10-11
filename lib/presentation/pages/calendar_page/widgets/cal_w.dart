import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/extensions/extensions.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.selectDate,
    required this.state,
  });
  final CalendarState state;
  final ValueChanged<DateTime> selectDate;

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: state.selectedMonth?.year ?? 0,
      month: state.selectedMonth?.month ?? 0,
    );
    List months = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Padding(
        padding: EdgeInsets.only(
          left: 28.w,
          right: 28.w,
        ),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: months
                    .map((e) => Text(
                          e,
                          style: fonts.medium14.copyWith(
                            fontSize: 12.sp,
                            color: colors.textColor2,
                          ),
                        ))
                    .toList()),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var week in data.weeks)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: week.map((d) {
                      return RowItem(
                        date: d.date,
                        eventList: state.eventMap?[
                                "${d.date.year}-${d.date.month}-${d.date.day}"] ??
                            [],
                        isActiveMonth: d.isActiveMonth,
                        onTap: () => selectDate(d.date),
                        isSelected: state.selectedDay != null &&
                            state.selectedDay!.isSameDate(d.date),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
    required this.eventList,
  });
  final List<EventModel> eventList;

  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    final isToday = date.isToday;
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.center,
              height: 25.h,
              width: 25.h,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              decoration: isToday
                  ? BoxDecoration(
                      color:
                          colors.primary.withOpacity(isActiveMonth ? 1 : 0.5),
                      shape: BoxShape.circle)
                  : isSelected
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: colors.primary
                                .withOpacity(isActiveMonth ? 1 : 0.5),
                          ),
                        )
                      : null,
              child: Text(
                number.toString(),
                style: TextStyle(
                    fontSize: 14.sp,
                    color: isActiveMonth ? Colors.black : Colors.grey[500]),
              ),
            ),
            Positioned(
              top: 33.h,
              child: eventList.isNotEmpty
                  ? Wrap(
                      spacing: 4.w,
                      children: List.generate(
                        eventList.length > 3 ? 3 : eventList.length,
                        (i) => CircleAvatar(
                          radius: 2.r,
                          backgroundColor: eventList[i]
                              .color!
                              .withOpacity(isActiveMonth ? 1 : 0.5),
                        ),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      );
    });
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.state,
  });
  final CalendarState state;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 28.w,
              right: 28.w,
              top: 30.h,
              bottom: 20.h,
            ),
            child: Row(
              children: [
                Text(
                  DateFormat.MMMM("en_US").format(state.selectedMonth!),
                  textAlign: TextAlign.center,
                  style: fonts.semiBold14,
                ),
                const Spacer(),
                CustomCircleButton(
                  onTap: () {
                    context.read<CalendarBloc>().add(
                          CalendarEvent.changeMonth(
                              state.selectedMonth!.addMonth(-1)),
                        );
                  },
                  icon: Icons.keyboard_arrow_left,
                ),
                SizedBox(width: 10.w),
                CustomCircleButton(
                  onTap: () {
                    context.read<CalendarBloc>().add(
                          CalendarEvent.changeMonth(
                              state.selectedMonth!.addMonth(1)),
                        );
                  },
                  icon: Icons.keyboard_arrow_right,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class CalendarMonthData {
  final int year;
  final int month;

  int get daysInMonth => DateUtils.getDaysInMonth(year, month);
  int get firstDayOfWeekIndex => 0;

  int get weeksCount => ((daysInMonth + firstDayOffset) / 7).ceil();

  const CalendarMonthData({
    required this.year,
    required this.month,
  });

  int get firstDayOffset {
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    return (weekdayFromMonday - ((firstDayOfWeekIndex) % 7)) % 7;
  }

  List<List<CalendarDayData>> get weeks {
    final res = <List<CalendarDayData>>[];
    var firstDayMonth = DateTime(year, month, 1);
    var firstDayOfWeek = firstDayMonth.subtract(Duration(days: firstDayOffset));

    for (var w = 0; w < weeksCount; w++) {
      final week = List<CalendarDayData>.generate(
        7,
        (index) {
          final date = firstDayOfWeek.add(Duration(days: index));

          final isActiveMonth = date.year == year && date.month == month;

          return CalendarDayData(
            date: date,
            isActiveMonth: isActiveMonth,
          );
        },
      );
      res.add(week);
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    }
    return res;
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;

  const CalendarDayData({
    required this.date,
    required this.isActiveMonth,
  });
}
