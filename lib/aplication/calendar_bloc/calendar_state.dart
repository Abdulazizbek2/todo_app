part of 'calendar_bloc.dart';

@immutable
@freezed
class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    @Default(null) Color? dropDownValue,
    @Default(null) DateTime? selectedDay,
    @Default(null) DateTime? selectedMonth,
    @Default(null) List<EventModel>? eventModelList,
    @Default(null) Map<String, List<EventModel>>? toDoForCheck,
  }) = _CalendarState;
}
