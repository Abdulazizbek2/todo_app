part of 'theme.dart';

class FontSet {
  final TextStyle medium20;
  final TextStyle medium16;
  final TextStyle bold16;
  final TextStyle medium14;
  final TextStyle semiBold14;
  final TextStyle semiBold16;
  final TextStyle regular14;
  final TextStyle semiBold10;
  final TextStyle regular12;

  FontSet._({
    required this.medium20,
    required this.medium16,
    required this.bold16,
    required this.medium14,
    required this.semiBold14,
    required this.semiBold16,
    required this.regular14,
    required this.semiBold10,
    required this.regular12,
  });

  static FontSet createOrUpdate(CustomColorSet colors) {
    return FontSet._(
      medium20: Style.medium20(size: 20.sp, color: colors.text),
      medium16: Style.medium16(size: 16.sp, color: colors.text),
      medium14: Style.medium14(size: 14.sp, color: colors.text),
      semiBold16: Style.semiBold16(size: 16.sp),
      semiBold14: Style.semiBold16(size: 14.sp),
      regular14: Style.regular14(size: 14.sp, color: colors.text),
      semiBold10: Style.semiBold16(
        size: 10.sp,
      ).copyWith(fontWeight: FontWeight.w600),
      regular12: Style.regular12(size: 12.sp),
      bold16: Style.bold16(size: 16.sp, color: colors.text),
    );
  }
}
