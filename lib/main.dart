import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/domain/common/app_init.dart';

import 'presentation/pages/core/app_widget.dart';

void main() async {
  await AppInit.create;
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, child) => EasyLocalization(
        path: 'assets/translation',
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('uz', 'UZ'),
        ],
        fallbackLocale: const Locale('en', 'US'),
        child: AppWidget(
          dbProvider: AppInit.dbProvider!,
        ),
      ),
    ),
  );
}
