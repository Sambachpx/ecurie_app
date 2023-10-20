import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Lessons {
  late String _type;
  late String _name;
  late DateTime _date;
  late String _location;
  late String? _level;
  late String? _duration;
  late String? _discipline;
  late List? _participants;
  late DateTime _created_at;

  Lessons(this._type, this._name, this._date, this._location, this._created_at,
      this._level, this._duration, this._discipline, this._participants);
  // {required String name});

  String get getEventType => _type;
  String get getEventName => _name;
  DateTime get getEventDate => _date;
  String get getEventLocation => _location;
  String? get getEventLevel => _level;
  String? get getEventDuration => _duration;
  String? get getEventDiscipline => _discipline;
  List? get getEventParticipants => _participants;
  DateTime get getEventCreatedAt => _created_at;

  set setEventType(String type) => {_type = type};
  set setEventName(String name) => {_name = name};
  set setEventDate(DateTime date) => {_date = date};
  set setEventLocation(String location) => {_location = location};
  set setEventLevel(String? level) => {_level = level};
  set setEventDuration(String? duration) => {_duration = duration};
  set setEventDiscipline(String? discipline) => {_discipline = discipline};
  set setEventParticipants(List? participants) =>
      {_participants = participants as List?};

  Future<void> insertEvent(
      MongoDatabase db,
      DbCollection collection,
      String type,
      String name,
      DateTime date,
      String location,
      String? level,
      String? duration,
      String? discipline,
      List? participants,
      DateTime created_at) async {
    await db.connect();
    await collection.insertOne({
      'type': type,
      'name': name,
      'date': date,
      'location': location,
      'level': level,
      'duration': duration,
      'discipline': discipline,
      'participants': participants,
      'created_at': created_at
    });
    print('Event created: $_name, $_location, $_date');
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
