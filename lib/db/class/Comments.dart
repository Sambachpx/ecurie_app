import 'package:ecurie_app/db/db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Comments {
  late int _idevent;
  late int _iduser;
  late String _comment;

  Comments(this._idevent, this._iduser, this._comment);

  int get getCommentIdEvent => _idevent;
  int get getCommentIdUser => _iduser;
  String get getComment => _comment;

  set setCommentIdEvent(int idevent) => {_idevent = idevent};
  set setCommentIdUser(int iduser) => {_iduser = iduser};
  set setComment(String comment) => {_comment = comment};

  Future<void> insertComment(MongoDatabase db, DbCollection collection,
      int idevent, int iduser, String comment) async {
    await db.connect();
    await collection.insertOne({
      'idevent': idevent,
      'iduser': iduser,
      'comment': comment,
    });
    print('commentaire inscrit: $_idevent, $_iduser, $_comment');
    db.db.close();
  }

  Future<Map<String, dynamic>?> getCommentbydescription(MongoDatabase db,
      DbCollection collection, String commentDescription) async {
    await db.connect();
    var comment = await collection.findOne({"comment": commentDescription});
    db.db.close();
    return comment;
  }
}
