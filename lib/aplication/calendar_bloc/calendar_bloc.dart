import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/infrastructure/db_repository/database_repository.dart';
import 'package:todo_app/infrastructure/extensions/extensions.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';

part 'calendar_bloc.freezed.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const _CalendarState()) {
    on<_InitDate>(_init);
    on<_ChangeMonth>(_changeMonth);
    on<_ChangeDropdown>(_changeDropdown);
    on<_SelectDay>(_selectDay);
    on<_GetAllEvents>(_getAllEvents);
    on<_GetEventInSelectedDay>(_getEventInSelectedDay);
  }
  void _init(
    _InitDate event,
    Emitter<CalendarState> emit,
  ) {
    DateTime dateTime = DateTime.now();
    emit(
      state.copyWith(
        selectedDay: dateTime,
        selectedMonth: dateTime.monthStart,
      ),
    );
  }

  void _changeMonth(_ChangeMonth event, Emitter<CalendarState> emit) {
    if (event.value.year >= 1950 && event.value.year <= 2950) {
      add(CalendarEvent.selectDay(selectedDay: event.value));
      return emit(
        state.copyWith(
          selectedMonth: event.value,
        ),
      );
    }
  }

  void _changeDropdown(_ChangeDropdown event, Emitter<CalendarState> emit) {
    return emit(state.copyWith(dropDownValue: event.dropDownValue));
  }

  Future<void> _getAllEvents(
    _GetAllEvents event,
    Emitter<CalendarState> emit,
  ) async {
    List<EventModel> todo = await DBRepozitory.getAllEvents();
    Map<String, List<EventModel>> toDo = {};
    for (EventModel el in todo) {
      if (toDo.keys.contains(el.date)) {
        toDo[el.date]?.add(el);
      } else {
        toDo[el.date ?? "0"] = [el];
      }
    }
    emit(state.copyWith(
      dropDownValue: const Color(0xff009FEE),
      toDoForCheck: toDo,
    ));
  }

  FutureOr<void> _getEventInSelectedDay(
      event, Emitter<CalendarState> emit) async {
    List<EventModel> model = await DBRepozitory.getByDate(
      '${state.selectedDay?.year}-${state.selectedDay?.month}-${state.selectedDay?.day}',
    );
    return emit(state.copyWith(eventModelList: model));
  }

  FutureOr<void> _selectDay(
      _SelectDay event, Emitter<CalendarState> emit) async {
    try {
      add(const CalendarEvent.getEventInSelectedDay());
      emit(
        state.copyWith(
          selectedMonth: state.selectedMonth?.addMonth(
              event.selectedDay.month - (state.selectedMonth?.month ?? 0)),
          selectedDay: event.selectedDay,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          selectedDay: event.selectedDay,
          eventModelList: null,
        ),
      );
    }
  }
}
