import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.state,
  });
  final CalendarState state;
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        DateTime now = DateTime.now();
        return AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: colors.backgroundColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEEE', "en_US").format(state.selectedDay ?? now),
                style: fonts.semiBold14,
              ),
              GestureDetector(
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: state.selectedDay ?? now,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2950),
                  ).then((value) {
                    context
                        .read<CalendarBloc>()
                        .add(CalendarEvent.changeMonth(value ?? now));
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${state.selectedDay?.day} ${DateFormat.MMMM("en_US").format(state.selectedDay ?? DateTime.now())} ${state.selectedDay?.year}',
                      style: fonts.regular12.copyWith(fontSize: 10.sp),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: colors.black,
                      size: 13,
                    )
                  ],
                ),
              ),
            ],
          ),
          actions: [
            CustomIconButton(
              onPressed: () {},
              icon: icons.notification,
            )
          ],
        );
      },
    );
  }
}
