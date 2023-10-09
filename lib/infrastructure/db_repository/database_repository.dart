import 'package:flutter/material.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';

import '../services/local_db.dart';

class DBRepozitory {
  static Future<void> addEvent(EventModel event) async {
    await DBProvider.db.addEvent(EventDBModel(
      id: event.id,
      name: event.name,
      description: event.description,
      location: event.location,
      time: event.time,
      date: event.date,
      color: event.color?.value.toString(),
    ));
  }

  static Future updateEvent(EventModel event) async {
    final result = await DBProvider.db.updateEvent(EventDBModel(
      id: event.id,
      name: event.name,
      description: event.description,
      location: event.location,
      time: event.time,
      date: event.date,
      color: event.color?.value.toString(),
    ));
    return result;
  }

  static Future<List<EventModel>> getByDate(String date) async {
    final lt = await DBProvider.db.getByDate(date);
    return lt
        .map((event) => EventModel(
              id: event.id,
              name: event.name,
              description: event.description,
              location: event.location,
              time: event.time,
              date: event.date,
              color: Color(int.tryParse(event.color ?? "0xFF000000") ?? 0),
            ))
        .toList();
  }

  static Future<void> deleteEvent(int arrivalCode) async {
    await DBProvider.db.deleteEvent(arrivalCode);
  }

  static Future<List<EventModel>> getAllEvents() async {
    final lt = await DBProvider.db.getAllEvents();
    return lt
        .map((event) => EventModel(
              id: event.id,
              name: event.name,
              description: event.description,
              location: event.location,
              time: event.time,
              date: event.date,
              color: Color(int.tryParse(event.color ?? "0xFF000000") ?? 0),
            ))
        .toList();
  }
}
