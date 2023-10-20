import 'dart:ffi';

import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Horses {
  late ObjectId _id;
  late int _idowner;
  late String _name;
  late int _age;
  late String _robe;
  late String _race;
  late String _sexe;
  late String _specialite;
  late List _idhorseman;
  late DateTime _created_at;

  Horses(this._id, this._idowner, this._name, this._age, this._robe, this._race,
      this._sexe, this._specialite, this._idhorseman, this._created_at);

  ObjectId get getHorseId => _id;
  int get getIdowner  => _idowner;
  String get getHorseName => _name;
  int get getHorseAge => _age;
  String get getHorseRobe => _robe;
  String get race => _race;
  String get sexe => _sexe;
  String get specialite => _specialite;
  List get idhorseman => _idhorseman;
  DateTime get getHorseCreatedAt => _created_at;

  set setHorseName(String name) => {_name = name};
  set setHorseAge(int age) => {_age = age};
  set setHorseRobe(String robe) => {_robe = robe};
  set setHorseRace(String race) => {_race = race};
  set setHorseSexe(String sexe) => {_sexe = sexe};
  set setHorseSpecialite(String specialite) => {_specialite = specialite};
  set setidHorseman(List idhorseman) => {_idhorseman = idhorseman};

  Future<void> insertHorse(
    MongoDatabase db,
    DbCollection collection, ObjectId id, String name, int age , String robe,
      String race, String sexe, String specialite, List idhorseman, DateTime create_at,
  ) async {
    await db.connect();
    await collection.insertOne({
      'idowner': id,
      'name': name,
      'age': age,
      'role': robe,
      'race': race,
      'sexe': sexe,
      'specialite': specialite,
      'idhorseman': idhorseman,
      'created_at': create_at,
    });
    print(
        'cheval inscrit $_idowner, $_name, $_age, $_robe,$_race,$_sexe,$_specialite,$_idhorseman,$_created_at');
    db.db.close();
  }

  Future<Map<String, dynamic>?> getHorseByName(
      MongoDatabase db, DbCollection collection, String name) async {
    await db.connect();
    var horse = await collection.findOne({"name": name});
    db.db.close();
    return horse;
  }
}
