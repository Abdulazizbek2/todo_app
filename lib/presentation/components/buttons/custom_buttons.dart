import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/components/animation_effect.dart';
import 'package:todo_app/presentation/styles/style.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isDisabled;
  final double verticalPadding;
  final double radius;
  final double width;
  final String? icon;
  final Color color;
  final Color titleColor;
  final TextStyle textStyle;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.radius = 8,
    this.isDisabled = false,
    this.verticalPadding = 8,
    this.width = double.infinity,
    this.icon,
    this.color = Style.primary,
    this.titleColor = Style.white,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onPressed,
          disabled: isDisabled,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: isDisabled ? colors.grey : color,
              boxShadow: isDisabled ? null : const [Style.blueIconShadow],
              borderRadius: BorderRadius.circular(
                radius.r,
              ),
              border: Border.all(
                width: 0.7,
                color: isDisabled ? colors.grey : color,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding.h,
                horizontal: 8.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null ? SvgPicture.asset(icon!) : const SizedBox(),
                  SizedBox(width: icon != null ? 4.w : 0),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(
                        color: isDisabled ? colors.secondary : titleColor,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final String? iconPath;

  const CustomCircleButton({
    super.key,
    this.icon,
    this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.sp),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Style.buttonColor,
          shape: BoxShape.circle,
        ),
        child: icon != null || iconPath != null
            ? iconPath != null
                ? SvgPicture.asset(iconPath!)
                : Icon(
                    icon,
                    color: Style.black,
                    size: 16.sp,
                  )
            : null,
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20.r,
      onPressed: onPressed,
      icon: SvgPicture.asset(icon),
    );
  }
}
