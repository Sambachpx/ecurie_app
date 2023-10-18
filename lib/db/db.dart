import 'package:mongo_dart/mongo_dart.dart';
import 'package:ecurie_app/db/constants.dart';

class MongoDatabase {
  static connect() async {
    try {
      var db = await Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection(COLLECTION_NAME);
      print(collection);
      print('Connected !');
    } catch (e) {
        print(e);
    };
  }
}