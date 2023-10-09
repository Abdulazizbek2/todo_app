import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/styles/style.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final String titleHintText;
  final bool isEmail;
  final bool isPassword;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final TextAlignVertical? textAlignVertical;
  final Widget? suffixIcon;
  final void Function()? onsuffixIconPressed;
  final void Function()? onPressed;
  final TextInputType keyboardType;
  final String? error;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatter;
  final TextAlign textAlign;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final bool isStarNeeded;
  final Widget? prefix;
  final TextStyle? hintStyle;
  final Widget? widgetTitle;
  final bool? autoFox;
  final Color? borderColor;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool? enabled;

  const CustomTextField({
    Key? key,
    this.onPressed,
    this.textAlignVertical,
    this.onsuffixIconPressed,
    this.formatter,
    this.borderColor,
    this.controller,
    this.hintText = '',
    this.title = '',
    this.isPassword = false,
    this.minLines = 1,
    this.maxLines = 2,
    this.isEmail = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.maxLength,
    this.obscureText = false,
    this.error,
    this.titleHintText = '',
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.isStarNeeded = false,
    this.prefix,
    this.hintStyle,
    this.widgetTitle,
    this.autoFox,
    this.validator,
    this.autovalidateMode,
    this.enabled,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.ltr,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1,
                  text: TextSpan(
                    text: widget.title,
                    style: fonts.regular14.copyWith(
                      color: widget.error == null ? colors.text : colors.error,
                    ),
                    children: <TextSpan>[
                      widget.isStarNeeded
                          ? TextSpan(text: ' *', style: fonts.regular12)
                          : const TextSpan(),
                    ],
                  ),
                )
              : const SizedBox(),
          widget.title.isNotEmpty ? SizedBox(height: 8.h) : const SizedBox(),
          widget.titleHintText.isNotEmpty
              ? Text(
                  widget.titleHintText,
                  style: fonts.regular12.copyWith(
                    color: colors.text,
                  ),
                )
              : const SizedBox(),
          widget.titleHintText.isNotEmpty
              ? SizedBox(height: 6.h)
              : const SizedBox(),
          TextFormField(
            enabled: widget.enabled,
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            autofocus: widget.autoFox ?? false,
            onTap: widget.onPressed,
            textInputAction: TextInputAction.done,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength ?? 255,
            onChanged: widget.onChanged,
            readOnly: widget.readOnly,
            textAlign: widget.textAlign,
            inputFormatters: widget.formatter,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            textAlignVertical: widget.textAlignVertical,
            controller: widget.controller,
            style: fonts.regular14.copyWith(color: colors.text),
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              counterText: '',
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      splashColor: colors.transparent,
                      highlightColor: colors.transparent,
                      icon: widget.suffixIcon!,
                      onPressed: widget.onsuffixIconPressed ?? () {},
                    )
                  : null,
              focusColor: Style.primary,
              fillColor: colors.filledColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: widget.borderColor ?? colors.transparent,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: widget.borderColor ?? colors.transparent,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: widget.borderColor ?? colors.transparent,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: widget.borderColor ?? colors.transparent,
                  width: 1,
                ),
              ),
              hintStyle: widget.hintStyle ??
                  fonts.regular14.copyWith(
                    color: colors.textColor2,
                  ),
              hintText: widget.hintText,
              errorText: widget.error,
              errorStyle: fonts.regular12.copyWith(color: colors.error),
              contentPadding:
                  EdgeInsets.only(left: 12.w, top: 10.h, right: 12.w),
            ),
          ),
        ],
      );
    });
  }
}
