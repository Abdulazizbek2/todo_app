import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';
import 'package:todo_app/infrastructure/services/local_db.dart';
import 'package:todo_app/presentation/pages/add_event_page/add_event_page.dart';
import 'package:todo_app/presentation/pages/calendar_page/calendar_page.dart';
import 'package:todo_app/presentation/pages/core/app_widget.dart';
import 'package:todo_app/presentation/pages/event_details/event_details_page.dart';

class Routes {
  static PageRoute getAddEventPage(BuildContext context, [EventModel? event]) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CalendarBloc>(),
          child: AddEventPage(event: event),
        ),
      );

  static PageRoute getAppWidget(DBProvider dbProvider) => MaterialPageRoute(
        builder: (_) => AppWidget(dbProvider: dbProvider),
      );

  static PageRoute getCalendarPage(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => CalendarBloc()
            ..add(const CalendarEvent.init())
            ..add(const CalendarEvent.getAllEvents())
            ..add(const CalendarEvent.getEventInSelectedDay()),
          child: const HomePage(),
        ),
      );

  static PageRoute getEventDetailsPage(
    EventModel event,
    BuildContext context,
  ) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CalendarBloc>(),
          child: EventDetailsPage(
            event: event,
          ),
        ),
      );

  static PageRoute onGenerateRoute({required BuildContext context}) {
    return getCalendarPage(context);
  }
}
