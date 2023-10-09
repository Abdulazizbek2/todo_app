import 'package:flutter/material.dart';

class Style {
  Style._();

  static const Color black = Color(0XFF0A0A0A);

  static const Color error = Color(0XFFFF0C27);

  static const Color white = Color(0XFFFFFFFF);

  static const Color text = Color(0XFF111827);

  static const Color grey = Color(0XFFAFAFAF);

  static const Color backgroundColor = Color(0XFFF8F8F8);

  static const Color primary = Color(0XFF009FEE);

  static const Color secondary = Color(0XFF0A0A0A);

  static const Color transparent = Colors.transparent;

  static const Color stroke = Color(0XFFEFF3F8);

  static const Color buttonColor = Color(0XFFEFEFEF);

  static const Color filledColor = Color(0XFFF3F4F6);

  static const Color subtitle = Color(0XFF7C7B7B);

  static const Color redLight = Color(0XFFFEE8E9);

  static const Color textColor2 = Color(0XFF969696);

  static const BoxShadow blueIconShadow = BoxShadow(
    color: Color(0x20696A6F),
    blurRadius: 12,
    spreadRadius: 2,
  );

  static TextStyle regular24({
    double size = 24,
    Color color = text,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle regular16({
    double size = 16,
    Color color = text,
    FontWeight? fontWeight1,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size,
      color: color,
      fontWeight: fontWeight1 ?? FontWeight.w400,
    );
  }

  static TextStyle regular14(
      {double size = 14,
      Color color = text,
      TextDecoration thisdecoration = TextDecoration.none}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      decoration: thisdecoration,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle regular12(
      {double size = 12, Color color = text, String fontfamily = 'Inter'}) {
    return TextStyle(
      fontFamily: fontfamily,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle medium20({double size = 20, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle medium16({double size = 16, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle medium14({double size = 14, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBold16({double size = 16, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle semiBold14({double size = 14, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bold20({double size = 20, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bold16({double size = 16, Color color = text}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }
}
