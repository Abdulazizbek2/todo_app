part of 'theme.dart';

class CustomColorSet {
  final Color text;

  final Color primary;

  final Color white;

  final Color grey;

  final Color backgroundColor;

  final Color secondary;

  final Color error;

  final Color transparent;

  final Color black;

  final Color stroke;

  final Color background;

  final Color filledColor;

  final Color subtitle;

  final Color redLight;

  final Color textColor2;

  CustomColorSet._({
    required this.text,
    required this.primary,
    required this.white,
    required this.grey,
    required this.backgroundColor,
    required this.secondary,
    required this.error,
    required this.transparent,
    required this.black,
    required this.stroke,
    required this.background,
    required this.filledColor,
    required this.subtitle,
    required this.redLight,
    required this.textColor2,
  });

  factory CustomColorSet._create(CustomThemeMode mode) {
    final isLight = mode.isLight;

    final text = isLight ? Style.text : Style.white;

    final backgroundColor = isLight ? Style.white : Style.backgroundColor;

    const background = Style.backgroundColor;

    const stroke = Style.stroke;

    const grey = Style.grey;

    const black = Style.black;

    const primary = Style.primary;

    const white = Style.white;

    const secondary = Style.secondary;

    const error = Style.error;

    const transparent = Style.transparent;

    const filledColor = Style.filledColor;

    const subtitle = Style.subtitle;

    const redLight = Style.redLight;

    const textColor2 = Style.textColor2;

    return CustomColorSet._(
      black: black,
      grey: grey,
      stroke: stroke,
      background: background,
      text: text,
      primary: primary,
      white: white,
      backgroundColor: backgroundColor,
      secondary: secondary,
      error: error,
      transparent: transparent,
      filledColor: filledColor,
      subtitle: subtitle,
      redLight: redLight,
      textColor2: textColor2,
    );
  }

  static CustomColorSet createOrUpdate(CustomThemeMode mode) {
    return CustomColorSet._create(mode);
  }
}
