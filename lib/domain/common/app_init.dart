import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/infrastructure/services/local_db.dart';
import 'package:todo_app/presentation/styles/style.dart';

class AppInit {
  static DBProvider? dbProvider;
  AppInit._();

  static Future<AppInit> get create async {
    await appInitialized();

    dbProvider ??= DBProvider.db;
    return AppInit._();
  }

  static Future<void> appInitialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 1)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Style.white
      ..backgroundColor = Style.primary.withOpacity(0.4)
      ..errorWidget
      ..indicatorColor = Style.white
      ..textColor = Style.white
      ..maskColor = Style.primary.withOpacity(0.2)
      ..userInteractions = true
      ..dismissOnTap = true;
  }
}
