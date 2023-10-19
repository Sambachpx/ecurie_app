import 'package:ecurie_app/db/class/Users.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ecurie_app/db/constants.dart';

class MongoDatabase {

  late Db _db;

  MongoDatabase(){
    initialize();
  }

  Db get db => _db;

  Future<void> initialize() async{
    _db = await Db.create(MONGO_URL);
  }

  Future<void> connect() async {
    await _db.open();
    print('Connected !');
  }

  Future<DbCollection> getCollection(String collectionName) async{
    return _db.collection(collectionName);
  }

  Future<void> insert(Function insert) async{
    insert();
  }
}
