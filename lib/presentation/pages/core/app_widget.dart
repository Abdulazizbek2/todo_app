import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/infrastructure/services/local_db.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme.dart';

class AppWidget extends StatelessWidget {
  final DBProvider dbProvider;
  const AppWidget({Key? key, required this.dbProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GridTheme>(
      create: (_) => GridTheme.create(dbProvider),
      builder: (BuildContext ctx, _) {
        return RepositoryProvider(
          create: (context) => dbProvider,
          child: Builder(builder: (context) {
            return MaterialApp(
              locale: context.locale,
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: (settings) =>
                  Routes.onGenerateRoute(context: context),
            );
          }),
        );
      },
    );
  }
}
