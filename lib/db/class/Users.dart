import 'package:ecurie_app/db/constants.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart' as r;

@r.RealmModel()
class Users {
  @r.PrimaryKey()
  late ObjectId id;
  late String username;
  late String email;
  late String password;
  late String image;
  late String number;
  late String age;
  late String link;
  late String role;
  late DateTime created_at;

  Users(this.username, this.email, this.password, this.image,this.created_at){
    created_at = DateTime.now();
  }

  //getters
  ObjectId get userId => id;
  String get userName => username;
  String get userEmail => email;
  String get userPassword => password;
  String get userImage => image;
  String get userNumber => number;
  String get userAge => age;
  String get userLink => link;
  String get userRole => role;
}