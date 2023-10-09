import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class DetailAppbarWidget extends StatefulWidget {
  final EventModel event;
  const DetailAppbarWidget({
    super.key,
    required this.event,
  });

  @override
  State<DetailAppbarWidget> createState() => _DetailAppbarWidgetState();
}

class _DetailAppbarWidgetState extends State<DetailAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Container(
          width: 1.sw,
          height: (248 + MediaQuery.of(context).viewInsets.top).h,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).viewInsets.top + 68).h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(icons.back),
                        onTap: () => Navigator.pop(context),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          Routes.getAddEventPage(context, widget.event),
                        ).then((value) {
                          Navigator.pop(context);
                        }),
                        child: Row(
                          children: [
                            SvgPicture.asset(icons.edit),
                            SizedBox(width: 4.w),
                            Text(
                              'edit'.tr(),
                              style: fonts.medium14.copyWith(
                                color: colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  widget.event.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: fonts.semiBold16.copyWith(
                    color: colors.white,
                    fontSize: 26.sp,
                  ),
                ),
                Text(
                  widget.event.location ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: fonts.regular12.copyWith(
                    color: colors.white,
                    fontSize: 8.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                iconText(
                  icon: Icons.watch_later_sharp,
                  text: widget.event.time ?? '--:--',
                  fonts: fonts,
                  colors: colors,
                ),
                SizedBox(height: 12.h),
                (widget.event.location?.isEmpty ?? true) &&
                        (widget.event.location?.length ?? 0) <= 1
                    ? const SizedBox()
                    : iconText(
                        icon: Icons.location_on_rounded,
                        text: widget.event.location ?? '...',
                        fonts: fonts,
                        colors: colors,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row iconText({
    required IconData icon,
    required String text,
    required FontSet fonts,
    required CustomColorSet colors,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: colors.white,
          size: 19.sp,
        ),
        SizedBox(width: 4.w),
        SizedBox(
          width: 200.w,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: fonts.medium14.copyWith(
              fontSize: 10.sp,
              color: colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
