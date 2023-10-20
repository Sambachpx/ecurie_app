import 'dart:convert';
import 'package:ecurie_app/db/db.dart';
import 'package:ecurie_app/db/class/Users.dart';
import 'package:ecurie_app/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/constants.dart';
import 'package:ecurie_app/Notifier/DbManagement.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Equitator',
          style: TextStyle(fontFamily: 'Lobster', fontSize: 24.0),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255,255,255,255),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome To Equitator',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/logo_cheval.jpeg',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}