part of 'theme.dart';

class IconSet {
  final String edit;
  final String arrowLeft;
  final String back;
  final String chevronDown;
  final String clock;
  final String location;
  final String notification;
  final String delete;

  IconSet._({
    required this.edit,
    required this.arrowLeft,
    required this.back,
    required this.chevronDown,
    required this.clock,
    required this.location,
    required this.notification,
    required this.delete,
  });

  static IconSet get create {
    return IconSet._(
      edit: "assets/icons/svg/edit.svg",
      arrowLeft: 'assets/icons/svg/arrow_left.svg',
      back: 'assets/icons/svg/back.svg',
      chevronDown: 'assets/icons/svg/chevron_down.svg',
      clock: 'assets/icons/svg/clock.svg',
      location: 'assets/icons/svg/location.svg',
      notification: 'assets/icons/svg/notification.svg',
      delete: 'assets/icons/svg/delete.svg',
    );
  }
}
