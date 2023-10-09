part of 'theme.dart';

class IconSet {
  final String edit;
  final String notification;
  final String delete;

  IconSet._({
    required this.edit,
    required this.notification,
    required this.delete,
  });

  static IconSet get create {
    return IconSet._(
      edit: "assets/icons/svg/edit.svg",
      notification: 'assets/icons/svg/notification.svg',
      delete: 'assets/icons/svg/delete.svg',
    );
  }
}
