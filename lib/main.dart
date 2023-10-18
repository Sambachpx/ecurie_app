//import 'package:bson/src/classes/object_id.dart';
import 'dart:developer';

import 'package:ecurie_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/db/class/Users.dart';
import 'package:mongo_dart/mongo_dart.dart';

void main() {
  MongoDatabase.connect();
  var u = Users("username", "email", "password", "image", DateTime.now());
  
  MongoDatabase.insert(u);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
