part of 'calendar_bloc.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.init() = _InitDate;

  const factory CalendarEvent.changeMonth(DateTime value) = _ChangeMonth;

  const factory CalendarEvent.getAllEvents() = _GetAllEvents;

  const factory CalendarEvent.getEventInSelectedDay() = _GetEventInSelectedDay;

  const factory CalendarEvent.changeDropdown({
    required Color dropDownValue,
  }) = _ChangeDropdown;

  const factory CalendarEvent.selectDay({
    required DateTime selectedDay,
  }) = _SelectDay;
}
