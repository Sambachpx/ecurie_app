import 'dart:ffi';

import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Horses {
  late int _idowner;
  late String _name;
  late int _age;
  late String _role;
  late String _race;
  late String _sexe;
  late String _specialite;
  late Array _idhorseman;
  late DateTime _created_at;

  Horses(this._idowner, this._name, this._age, this._role, this._race,
      this._sexe, this._specialite, this._idhorseman, this._created_at);

  String get getHorseName => _name;
  int get getHorseAge => _age;
  String get getHorseRole => _role;
  String get race => _race;
  String get sexe => _sexe;
  String get specialite => _specialite;
  Array get idhorseman => _idhorseman;
  DateTime get getHorseCreatedAt => _created_at;

  set setHorseName(String name) => {_name = name};
  set setHorseAge(int age) => {_age = age};
  set setHorseRole(String role) => {_role = role};
  Set setHorseRace(String race) => {_race = race};
  Set setHorseSexe(String sexe) => {_sexe = sexe};
  Set setHorseSpecialite(String specialite) => {_specialite = specialite};

  Future<void> insertHorse(
    MongoDatabase db,
    DbCollection collection,
  ) async {
    await db.connect();
    await collection.insertOne({
      'idowner': _idowner,
      'name': _name,
      'age': _age,
      'role': _role,
      'race': _race,
      'sexe': _sexe,
      'specialite': _specialite,
      'idhorseman': _idhorseman,
      'created_at': _created_at,
    });
    print(
        'cheval inscrit $_idowner, $_name, $_age, $_role,$_race,$_sexe,$_specialite,$_idhorseman,$_created_at');
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
