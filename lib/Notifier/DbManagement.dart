import 'package:ecurie_app/db/db.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  late MongoDatabase mongoDatabase;

  AppState() {
    mongoDatabase = MongoDatabase();
  }
}