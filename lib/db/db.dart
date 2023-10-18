import 'package:ecurie_app/db/class/Users.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ecurie_app/db/constants.dart';

class MongoDatabase {
  static var userCollection;

  static connect() async {
    try {
      var db = await Db.create(MONGO_URL);
      await db.open();
      userCollection = db.collection(USER_COLLECTION);
      print("la collection est : $userCollection");
      print('Connected !');
    } catch (e) {
        print(e);
    }
  }

  static insert(Users user) async {
    await userCollection.insertAll([user.toString()]);
  }

}