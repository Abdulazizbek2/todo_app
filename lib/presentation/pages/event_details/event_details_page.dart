import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/db_repository/database_repository.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/pages/event_details/widgets/detail_appbar_widget.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

import '../../styles/style.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;
  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ThemeWrapper(
          builder: (ctx, colors, fonts, icons, controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  DetailAppbarWidget(event: event),
                  Padding(
                    padding: EdgeInsets.only(top: 18.h, bottom: 14.h),
                    child: ListTile(
                      title: Text(
                        'reminder'.tr(),
                        style: fonts.semiBold16,
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          '15 minutes before',
                          style: fonts.medium16.copyWith(
                            color: colors.subtitle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'description'.tr(),
                      style: fonts.semiBold16,
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(event.description ?? '...',
                          style: TextStyle(
                            color: colors.subtitle,
                            fontSize: 10.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          )
                          // fonts.regular12.copyWith(
                          //   fontSize: 10.sp,
                          //   color: colors.subtitle,
                          // ),
                          ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  bottom: (MediaQuery.of(context).viewInsets.bottom + 50),
                  left: 28.w,
                  right: 28.w,
                ),
                child: CustomButton(
                  textStyle: Style.regular16(
                    size: 14.sp,
                    fontWeight1: FontWeight.w600,
                  ),
                  icon: icons.delete,
                  color: colors.redLight,
                  titleColor: colors.black,
                  verticalPadding: 12.h,
                  title: 'delete_event'.tr(),
                  onPressed: () => deleteEvent(context),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteEvent(BuildContext context) async {
    await DBRepozitory.deleteEvent(event.id!).then((value) {
      context.read<CalendarBloc>()
        ..add(const CalendarEvent.getEventInSelectedDay())
        ..add(const CalendarEvent.getAllEvents());
      EasyLoading.showSuccess('succes'.tr());
      Navigator.pop(context);
    });
  }
}
