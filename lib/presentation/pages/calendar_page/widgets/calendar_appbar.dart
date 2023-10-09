import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    throw ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: colors.transparent,
          title: Column(
            children: [
              Text(
                'Sunday',
                style: fonts.semiBold14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '28 September 2021',
                    style: fonts.regular12.copyWith(fontSize: 10),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: colors.black,
                    size: 16.sp,
                  )
                ],
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
