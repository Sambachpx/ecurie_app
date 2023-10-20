import 'package:ecurie_app/db/constants.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Users {
  late ObjectId _id;
  late String _username;
  late String _email;
  late String _password;
  late String _image;
  late String _number;
  late int _age;
  late String _link;
  late String _role;
  late DateTime _created_at;

  Users(this. _id, this._username, this._email, this._password, this._image, this._number, this._age, this._link, this._role, this._created_at);

  //getters
  ObjectId get getUserId => _id;
  String get getUserName => _username;
  String get getUserEmail => _email;
  String get getUserPassword => _password;
  String get getUserImage => _image;
  String get getUserNumber => _number;
  int get getUserAge => _age;
  String get getUserLink => _link;
  String get getUserRole => _role;
  DateTime get getUserCreatedAt => _created_at;

  //setters
  set setUserName(String username)=>{_username = username};
  set setUserEmail(String email)=>{_email = email};
  set setUserPassword(String passord)=>{_password = passord};
  set setUserImage(String image)=>{_image = image};
  set setUserNumber(String number)=>{_number = number};
  set setUserAge(int age)=>{_age = age};
  set setUserLink(String link)=>{_link = link};
  set setUserRole(String role)=>{_role = role};


  Future<void> insertUser(MongoDatabase db,DbCollection collection,ObjectId id, String username, String email, String password,String image, String number, int age, String link, String role) async{
    await db.connect();
    await collection.insertOne({
      'id' : id,
      'username': username,
      'email': email,
      'password': password,
      'image': image,
      'number': number,
      'age': age,
      'link': link,
      'role': role,
    });
    print('user inscrit: $id $username, $email, $password');
    db.db.close();
  }

  Future<Map<String, dynamic>?> getUserByUsername(MongoDatabase db, DbCollection collection,String username) async{
    await db.connect();
    var user = await collection.findOne({"username":username});
    db.db.close();
    return user;
  }
}