import 'dart:ffi';
import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Event {
  late String _type;
  late String _name;
  late DateTime _date;
  late Array _participants;
  late String _location;
  late String _level;
  late int _duration;
  late String _discipline;
  late DateTime _created_at;

  Event(this._type, this._name, this._date, this._participants, this._location,
      this._level, this._duration, this._discipline, this._created_at);

  String get getEventType => _type;
  String get getEventName => _name;
  DateTime get getEventDate => _date;
  Array get getEventParticipants => _participants;
  String get getEventLocation => _location;
  String get getEventLevel => _level;
  int get getEventDuration => _duration;
  String get getEventDiscipline => _discipline;
  DateTime get getEventCreatedAt => _created_at;

  set setEventType(String type) => {_type = type};
  set setEventName(String name) => {_name = name};
  set setEventDate(DateTime date) => {_date = date};
  set setEventParticipants(Array participants) =>
      {_participants = participants};
  set setEventLocation(String location) => {_location = location};
  set setEventLevel(String level) => {_level = level};
  set setEventDuration(int duration) => {_duration = duration};
  set setEventDiscipline(String discipline) => {_discipline = discipline};

  Future<void> insertEvent(
    MongoDatabase db,
    DbCollection collection,
  ) async {
    await db.connect();
    await collection.insertOne({
      'type': _type,
      'name': _name,
      'date': _date,
      'participants': _participants,
      'location': _location,
      'level': _level,
      'duration': _duration,
      'discipline': _discipline,
      'created_at': _created_at,
    });
    print(
        'event inscrit:, $_name, $_location, $_date, $_duration, $_created_at');
    db.db.close();
  }

  Future<Map<String, dynamic>?> getEventByName(
      MongoDatabase db, DbCollection collection, String name) async {
    await db.connect();
    var event = await collection.findOne({"name": name});
    db.db.close();
    return event;
  }
}
