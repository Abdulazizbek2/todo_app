import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  static Database? _database;
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todo_calendar.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE EVENTS ("
          "${EvetsFNM.eventId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${EvetsFNM.eventName} TEXT,"
          "${EvetsFNM.description} TEXT,"
          "${EvetsFNM.location} TEXT,"
          "${EvetsFNM.time} TEXT,"
          "${EvetsFNM.date} TEXT,"
          "${EvetsFNM.color} TEXT"
          ")");
      await db.execute("CREATE TABLE THEME (theme TEXT)");
    });
  }

//Events
  addEvent(EventDBModel event) async {
    final db = await database;
    var raw = await db.rawInsert(
        'INSERT INTO EVENTS( ${EvetsFNM.eventName}, ${EvetsFNM.description}, ${EvetsFNM.location}, ${EvetsFNM.time}, ${EvetsFNM.date}, ${EvetsFNM.color})'
        'VALUES(?,?,?,?,?,?)',
        [
          event.name,
          event.description,
          event.location,
          event.time,
          event.date,
          event.color,
        ]);
    return raw;
  }

  Future<List<EventDBModel>> getAllEvents() async {
    final db = await database;
    var res = await db.query("EVENTS", orderBy: "${EvetsFNM.time} DESC");
    List<EventDBModel> list =
        res.isEmpty ? [] : res.map((e) => EventDBModel.fromMap(e)).toList();
    return list;
  }

  deleteEvent(int eventId) async {
    final db = await database;
    return db.delete("EVENTS",
        where: "${EvetsFNM.eventId} = ?", whereArgs: [eventId]);
  }

  updateEvent(EventDBModel event) async {
    final db = await database;
    return db.update("EVENTS", event.toMap(),
        where: "${EvetsFNM.eventId} = ?", whereArgs: [event.id]);
  }

  Future<List<EventDBModel>> getByDate(String date) async {
    final db = await database;
    final results = await db.query(
      "EVENTS",
      // columns: EvetsFNM.names,
      orderBy: "${EvetsFNM.time} DESC",
      where: '${EvetsFNM.date} = ?',
      whereArgs: [date],
    );
    if (results.isNotEmpty) {
      return results.map((json) => EventDBModel.fromMap(json)).toList();
    } else {
      return [];
    }
  }

//service
  setThemeMode(String? mode) async {
    final db = await database;
    await db.insert("THEME", {"theme": mode});
  }

  static String? _themeMode;
  static Future<DBProvider> get create async {
    final db = await database;
    var res = await db.query("THEME");
    List<String> list =
        res.isEmpty ? [] : res.map((e) => e["theme"] as String).toList();
    _themeMode = list[0];
    return DBProvider();
  }

  String? get getThemeMode {
    return _themeMode;
  }

  Future<void> signOut() async => (await database).close();
}
