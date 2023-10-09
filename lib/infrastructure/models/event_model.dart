import 'package:flutter/material.dart';

class EvetsFNM {
  static final List<String> names = [
    eventId,
    eventName,
    description,
    location,
    time,
    color,
  ];

  static const String eventId = "_id";
  static const String eventName = "name";
  static const String description = "description";
  static const String location = "location";
  static const String time = "time";
  static const String date = 'date';
  static const String color = 'color';
}

class EventDBModel {
  final int? id;
  final String? name;
  final String? description;
  final String? location;
  final String? time;
  final String? date;
  final String? color;

  EventDBModel({
    this.id,
    this.name,
    this.description,
    this.location,
    this.time,
    this.date,
    this.color,
  });

  EventDBModel copyWith({
    int? id,
    String? name,
    String? description,
    String? location,
    String? color,
    String? time,
    String? date,
  }) =>
      EventDBModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        time: time ?? this.time,
        date: date ?? this.date,
        color: color ?? this.color,
      );

  Map<String, Object?> toMap() => {
        EvetsFNM.eventName: name,
        EvetsFNM.description: description,
        EvetsFNM.location: location,
        EvetsFNM.time: time,
        EvetsFNM.date: date,
        EvetsFNM.color: color,
      };

  static EventDBModel fromMap(Map<String, Object?> json) => EventDBModel(
        id: json[EvetsFNM.eventId] as int?,
        name: json[EvetsFNM.eventName] as String?,
        description: json[EvetsFNM.description] as String?,
        location: json[EvetsFNM.location] as String?,
        time: json[EvetsFNM.time] as String?,
        date: json[EvetsFNM.date] as String?,
        color: json[EvetsFNM.color] as String?,
      );
}

class EventModel {
  final int? id;
  final String? name;
  final String? description;
  final String? location;
  final String? time;
  final String? date;
  final Color? color;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.location,
    this.time,
    this.date,
    this.color,
  });

  EventModel copyWith({
    int? id,
    String? name,
    String? description,
    String? location,
    Color? color,
    String? time,
    String? date,
  }) =>
      EventModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        location: location ?? this.location,
        time: time ?? this.time,
        date: date ?? this.date,
        color: color ?? this.color,
      );

  Map<String, Object?> toMap() => {
        EvetsFNM.eventName: name,
        EvetsFNM.description: description,
        EvetsFNM.location: location,
        EvetsFNM.time: time,
        EvetsFNM.date: date,
        EvetsFNM.color: color,
      };

  static EventModel fromMap(Map<String, Object?> json) => EventModel(
        id: json[EvetsFNM.eventId] as int?,
        name: json[EvetsFNM.eventName] as String?,
        description: json[EvetsFNM.description] as String?,
        location: json[EvetsFNM.location] as String?,
        time: json[EvetsFNM.time] as String?,
        date: json[EvetsFNM.date] as String?,
        color: json[EvetsFNM.color] as Color?,
      );
}
